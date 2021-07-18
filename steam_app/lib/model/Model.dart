import 'dart:async';
import 'dart:convert';

import 'package:steam_app/graphic/AccountPage.dart';
import 'package:steam_app/model/objects/Order.dart';
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
      print("token last: "+_authenticationData.expiresIn.toString());
      Timer.periodic(Duration(seconds: (30)), (Timer t) async {
        bool refresh = await _refreshToken();
        if(!refresh)
          t.cancel();
      });
      return LogInResult.logged;
    }
    catch (e) {
      print(e);
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
        AccountPageState.forceLogout();
        print("refresh failed");
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      print("token refreshed");
      return true;
    }
    catch (e) {
      AccountPageState.forceLogout();
      print("refresh failed");
      print(e);
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
      print(e);
      return false;
    }
  }

  Future<List<Game>> searchGame({String value="",String type="name", int pageNumber, int pageSize=7, String sortBy="name"}) async {
    Map<String, String> params = Map();
    params[type] = value;
    params["pageNumber"] = pageNumber.toString();
    params["pageSize"] = pageSize.toString();
    params["sortBy"] = sortBy;
    String REQUEST;
    if(type == "genre")
      REQUEST = Constants.REQUEST_SEARCH_BY_GENRE;
    else
      REQUEST = Constants.REQUEST_SEARCH_BY_NAME;
    try {
      return List<Game>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, REQUEST, params)).map((i) => Game.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null; // not the best solution
    }
  }

  Future<Order> createOrder(Order order) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_GET_OR_CREATE_ORDER, order);
      Order result = Order.fromJson(jsonDecode(rawResult));
      return result;
    } catch(e){
      print(e);
      return null;
    }
  }

  Future<User> getUserByEmail(User user) async{
    try{
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_USER_BY_EMAIL,user);
      return User.fromJson(jsonDecode(rawResult));
    } catch(e){
      print(e);
      return null;
    }
  }

  Future<List<Order>> searchOrder(User user) async {
    try {
      Map<String, String> params = Map();
      params["user"] = user.id.toString();
      return List<Order>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_GET_OR_CREATE_ORDER, params)).map((i) => Order.fromJson(i)).toList());
    } catch(e){
      print(e);
      return null;
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
      print(e);
      return null; // not the best solution
    }
  }

}
