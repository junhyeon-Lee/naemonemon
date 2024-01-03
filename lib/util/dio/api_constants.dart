class APIConstants {
  static const String baseUrl = 'https://api.naemonemon.com/'; // dev

  ///Users
  static const String usersLogin = '${baseUrl}users/login';
  static const String usersInfo = '${baseUrl}users/info';
  static const String usersUpdate = '${baseUrl}users/update';
  static const String usersWithdraw = '${baseUrl}users/withdraw';
  static const String usersLogout = '${baseUrl}users/logout';


  ///Group
  static const String getGroups = '${baseUrl}groups';
  static const String getCarts = '${baseUrl}carts';

  ///Poll
  static const String polls = '${baseUrl}polls';
  static const String pollFinish = '${baseUrl}polls/finish';
  static const String feed ='${baseUrl}polls/socialPoll';
  static const String socialPollJoin ='${baseUrl}polls/socialPoll/join';

  ///Image
  static const String imageUpload = '${baseUrl}uploads';

  ///Comment
  static const String comment = '${baseUrl}Comments';
  static const String likes = '${baseUrl}Likes';

  ///Report
  static const String report = '${baseUrl}Reports';


  static String getParamsFromBody(Map<String, dynamic>? body) {
    String params = '?';
    for (var i = 0; i < body!.keys.length; i++) {
      params += '${List.from(body.keys)[i]}=${List.from(body.values)[i]}';
      if (i != body.keys.length - 1) {
        params += '&';
      }
    }
    return params;
  }
}

