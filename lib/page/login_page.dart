/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/controller/login_controller.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/constant/images.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/widget/input.dart';
import 'package:flutter_wanandroid/style/space.dart';
import 'package:flutter_wanandroid/widget/round_button.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Image.asset(Images.loginBg, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
          Scaffold(
            backgroundColor: HColors.transparent,
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme.copyWith(color: HColors.white),
              centerTitle: true,
              title: GetBuilder<LoginController>(
                id: "title",
                init: controller,
                builder: (_) {
                  return Text(
                    _.title,
                    style: TextStyle(
                      color: HColors.textWhite,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              backgroundColor: HColors.transparent,
            ),
            body: Container(
              margin: const EdgeInsets.only(left: 48.0, top: 64.0, right: 48.0),
              child: Body(),
            ),
          ),
        ],
      ),
    );
  }
}

class Body extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Widget loginBody = LoginBody();
    Widget registerBody = RegisterBody();
    return GetBuilder<LoginController>(
      init: controller,
      builder: (_) {
        return PageView.builder(
            itemCount: 2,
            controller: _.pageController,
            itemBuilder: (context, index) {
              return index == 1 ? registerBody : loginBody;
            });
      },
    );
  }
}

class LoginBody extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: controller,
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Input(
                controller: _.usernameController,
                prefixIcon: Icons.person,
                labelText: Strings.inputUsername,
                obscureText: false,
              ),
              Input(
                controller: _.passwordController,
                prefixIcon: Icons.verified_user,
                labelText: Strings.inputPassword,
                obscureText: true,
              ),
              Space.v16,
              RoundButton(
                Strings.login,
                textColor: HColors.textWhite,
                color: Colors.white38,
                onTap: () {
                  _.login();
                },
              ),
              Space.v8,
              GestureDetector(
                child: Text(
                  Strings.toRegister,
                  style: TextStyles.caption(context).copyWith(color: HColors.textWhite),
                ),
                onTap: () {
                  _.toRegister();
                },
              ),
            ],
          );
        });
  }
}

class RegisterBody extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: controller,
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Input(
                controller: _.registerUsernameController,
                prefixIcon: Icons.person,
                labelText: Strings.inputUsername,
                obscureText: false,
              ),
              Input(
                controller: _.registerPasswordController,
                prefixIcon: Icons.verified_user,
                labelText: Strings.inputPassword,
                obscureText: true,
              ),
              Input(
                controller: _.registerConfirmPasswordController,
                prefixIcon: Icons.verified_user,
                labelText: Strings.inputConfirmPassword,
                obscureText: true,
              ),
              Space.v16,
              RoundButton(
                Strings.register,
                textColor: HColors.textWhite,
                color: Colors.white38,
                onTap: () {
                  _.loadData();
                },
              ),
              Space.v8,
              GestureDetector(
                child: Text(
                  Strings.toLogin,
                  style: TextStyles.caption(context).copyWith(color: HColors.textWhite),
                ),
                onTap: () {
                  _.toLogin();
                },
              ),
            ],
          );
        });
  }
}
