import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/controller/user_manager_controller.dart';
import 'package:get/get.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-15

class AppInit {
  static Future<void> init() async {
    DioManager dioManager = DioManager();
    await dioManager.initConfig();
    Get.put(dioManager);
    UserManagerController userManagerController = UserManagerController();
    userManagerController.init(dioManager.getCookies());
    Get.put(userManagerController);
  }
}
