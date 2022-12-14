import 'dart:io';

import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/controller/user_manager_controller.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-15

class AppInit {
  static Future<void> init() async {
    DioManager dioManager = DioManager();
    await dioManager.initConfig();
    UserManagerController userManagerController = UserManagerController();
    List<Cookie> cookies = await dioManager.getCookies();
    userManagerController.init(cookies);
  }
}
