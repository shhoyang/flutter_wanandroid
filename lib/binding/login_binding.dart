/// @Author: Yang Shihao
/// @Date: 2021-01-14

import 'package:flutter_wanandroid/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
