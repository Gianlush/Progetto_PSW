import 'dart:async';
import 'dart:convert';

import 'package:steam_app/model/utility/Constants.dart';
import 'package:steam_app/model/utility/LogInResult.dart';

import 'managers/RestManager.dart';
import 'objects/AuthenticationData.dart';
import 'objects/Game.dart';
import 'objects/User.dart';


class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  AuthenticationData _authenticationData;


  Future<LogInResult> logIn(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["username"] = email;
      params["password"] = password;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        if ( _authenticationData.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _authenticationData.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["refresh_token"] = _authenticationData.refreshToken;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = null;
      params["client_id"] = Constants.CLIENT_ID;
      params["refresh_token"] = _authenticationData.refreshToken;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<List<Game>> searchGame({String value,String type}) async {
    Map<String, String> params = Map();
    params["x"] = value;
    String REQUEST;
    if(type == "genre")
      REQUEST = Constants.REQUEST_SEARCH_BY_GENRE;
    else
      REQUEST = Constants.REQUEST_SEARCH_BY_NAME;
    try {
      return List<Game>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, REQUEST, params)).map((i) => Game.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<User> addUserDB(User user) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_ALREADY_EXIST) ) {
        return null; // not the best solution
      }
      else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }


 /* Future<User> register(User user, String password) async {
    User result = await addUserDB(user);
    if(result==null)
      return null;


      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID_MASTER;
      params["username"] = Constants.USERNAME_MASTER;
      params["password"] = Constants.PASSWORD_MASTER;
      String keycloak = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN_MASTER, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(keycloak));
      _restManager.token = _authenticationData.accessToken;

      /// 2. Creo il corpo della richiesta per registrare l'utente e invio la richiesta a Keycloak
      var paramsKeycloakAsString = '''{
        "firstName": "${user.name}",
        "lastName": "${user.surname}",
        "email": "${user.email}",
        "username": "${user.email}",
        "attributes" : {
          "id": ${result.id}
        },
        "credentials" : [{
          "type": "password",
          "value": "$password",
          "temporary": false
        }],
        "enabled": true
      }''';
      Map keycloakJson = json.decode(paramsKeycloakAsString);
      String response = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_SIGNUP, keycloakJson);

      if(response.isNotEmpty) return SignUpResult.unknown_error;

      /// 3. Effettuo il logout dal realm Master
      params = Map();
      preferences.remove('token');
      params["client_id"] = Constants.CLIENT_ID_MASTER;
      params["refresh_token"] = _authenticationData.refreshToken;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT_MASTER, params, type: TypeHeader.urlencoded);

      return SignUpResult.signup;
    }
    catch (e) {
      return SignUpResult.unknown_error;
    }
  }*/


}
