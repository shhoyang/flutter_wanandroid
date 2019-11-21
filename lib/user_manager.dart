import 'dart:io';

import 'package:flutter_wanandroid/api/dio_manager.dart';

class UserManager {
  String username = "";
  String token = "";

  static UserManager _instance;

  static UserManager getInstance() {
    if (_instance == null) {
      _instance = UserManager();
    }

    return _instance;
  }

  bool isLogin() {
    return username != null &&
        username.isNotEmpty &&
        token != null &&
        username.isNotEmpty;
  }

  init() {
    login();
  }

  login() {
    List<Cookie> cookies = DioManager.getInstance().getCookies();
    if (cookies == null || cookies.isEmpty) {
      return;
    }

    cookies.forEach((c) {
      if ("loginUserName" == c.name) {
        UserManager
            .getInstance()
            .username = c.value;
      } else if ("token_pass" == c.name) {
        UserManager
            .getInstance()
            .token = c.value;
      }
    });
  }

  logout() {
    username = "";
    token = "";
    DioManager.getInstance().clearCookies();
  }

//  "loginUserName"
//  "token_pass"
}
