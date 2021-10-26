/// @Author: Yang Shihao
/// @Date: 2021-01-06

/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'dart:io';

import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/user.dart';
import 'package:flutter_wanandroid/controller/base_controller.dart';
import 'package:get/get.dart';

/// 已经全局注入，保证唯一，不要再通过构造方法创建对象
class UserManagerController extends BaseController {
  static UserManagerController of() => Get.find<UserManagerController>();
  static const keyUsername = "loginUserName";
  static const keyToken = "token_pass";
  static const loginStateId = "loginStateId";

  User _user;

  String get username => _user == null ? "未登录" : _user.username;

  bool get isLogin => _user != null;

  RxInt userStateChange = 0.obs;

  @override
  void loadData([int page]) async {}

  void init(List<Cookie> cookies) {
    if (cookies == null || cookies.isEmpty) {
      return;
    }

    String username;
    String token;

    cookies.forEach((c) {
      if (keyUsername == c.name) {
        username = c.value;
      } else if (keyToken == c.name) {
        token = c.value;
      }
    });
    if (username != null && token != null) {
      _user = User(0, username, token, "", "", "");
    }
  }

  void login(User user) {
    _user = user;
    userStateChange.value++;
    update();
  }

  void logout() {
    _user = null;
    DioManager.of().clearCookies();
    userStateChange.value++;
    update();
  }
}
