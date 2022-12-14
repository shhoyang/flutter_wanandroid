import 'dart:io';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/user.dart';
import 'package:flutter_wanandroid/controller/base_controller.dart';
import 'package:get/get.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06
/// 单例

class UserManagerController extends BaseController {

  UserManagerController._privateConstructor();

  static final UserManagerController _instance = UserManagerController._privateConstructor();

  factory UserManagerController(){
    return _instance;
  }

  static const keyUsername = "loginUserName";
  static const keyToken = "token_pass";
  static const loginStateId = "loginStateId";

  User? _user;

  String get username => _user == null ? "未登录" : _user!.username ?? "";

  bool get isLogin => _user != null;

  RxInt userStateChange = 0.obs;

  @override
  void loadData([int? page]) async {}

  void init(List<Cookie>? cookies) {
    if (cookies == null || cookies.isEmpty) {
      return;
    }

    String? username;
    String? token;

    cookies.forEach((c) {
      if (keyUsername == c.name) {
        username = c.value;
      } else if (keyToken == c.name) {
        token = c.value;
      }
    });
    if (username != null && token != null) {
      _user = User(0, username!, token!);
    }
  }

  void login(User? user) {
    if (user == null) {
      return;
    }
    _user = user;
    userStateChange.value++;
    update();
  }

  void logout() {
    _user = null;
    DioManager().clearCookies();
    userStateChange.value++;
    update();
  }
}
