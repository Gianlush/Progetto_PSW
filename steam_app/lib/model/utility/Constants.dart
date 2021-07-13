class Constants{
  static final String REALM = "myRealm";
  static final String TITLE_APP = "FakeSteam";
  static final String CLIENT_ID = "SteamApp";

  static final String CLIENT_ID_MASTER = "admin-cli";
  static final String USERNAME_MASTER = "gianluca";
  static final String PASSWORD_MASTER = "massara";

  static final String REQUEST_LOGIN_MASTER="/auth/realms/master/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT_MASTER="/auth/realms/master/protocol/openid-connect/logout";


  static final String ADDRESS_AUTHENTICATION_SERVER = "http://localhost:8080/auth";
  static final String ADDRESS_STORE_SERVER = "localhost:8081";

  static final String REQUEST_LOGIN = "/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

  static final String REQUEST_SEARCH_BY_NAME = "/games/name";
  static final String REQUEST_SEARCH_BY_GENRE = "/games/genre";
  static final String REQUEST_ADD_USER = "/users";
  static final String REQUEST_CREATE_ORDER = "/orders";



  static final String RESPONSE_ERROR_MAIL_ALREADY_EXIST ="ERROR_MAIL_ALREADY_EXIST";

}