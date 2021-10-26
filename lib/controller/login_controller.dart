import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/controller/user_manager_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/utils/snack.dart';
import 'package:flutter_wanandroid/utils/t.dart';
import 'package:get/get.dart';

import 'base_simple_controller.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-14
class LoginController extends BaseSimpleController {
  PageController pageController = PageController();
  TextEditingController usernameController = TextEditingController(text: "haoshi");
  TextEditingController passwordController = TextEditingController(text: "ysh520505");
  TextEditingController registerUsernameController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController = TextEditingController();

  String _title = Strings.login;
  String get title => _title;

  void toLogin() {
    pageController.jumpToPage(0);
    _title = Strings.login;
    update(["title"]);
  }

  void toRegister() {
    pageController.jumpToPage(1);
    _title = Strings.register;
    update(["title"]);
  }

  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty) {
      T.show(Strings.usernameIsEmpty);
      return;
    }

    if (password.isEmpty) {
      T.show(Strings.passwordIsEmpty);
      return;
    }

    DioManager.of().post(ApiService.getUrl(ApiService.login, isJson: false), (data) {
      T.show(Strings.loginSucceed);
      UserManagerController controller = UserManagerController.of();
      controller.login(EntityFactory.generateEntity(data));
      NavigatorUtils.back();
    }, errorCallBack: (msg, code) {
      Snack.show(Get.context, code);
      T.show(msg);
    }, params: {"username": username, "password": password});
  }

  void register() {
    String username = registerUsernameController.text.trim();
    if (username.isEmpty) {
      T.show(Strings.usernameIsEmpty);
      return;
    }

    String password = registerPasswordController.text.trim();
    if (password.isEmpty) {
      T.show(Strings.passwordIsEmpty);
      return;
    }

    String confirmPassword = registerConfirmPasswordController.text.trim();
    if (confirmPassword.isEmpty) {
      T.show(Strings.confirmPasswordIsEmpty);
      return;
    }

    if (password != confirmPassword) {
      T.show(Strings.passwordNotEquals);
      return;
    }

    T.show(Strings.toWanAndroid);
  }

  @override
  void onClose() {
    pageController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    registerUsernameController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}
