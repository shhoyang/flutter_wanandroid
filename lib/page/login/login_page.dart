import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/page/login/login_controller.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';
import 'package:flutter_wanandroid/constant/images.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/widget/input.dart';
import 'package:flutter_wanandroid/style/space.dart';
import 'package:flutter_wanandroid/widget/round_button.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = LoginController(context);
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
                builder: (controller) {
                  return Text(
                    controller.title,
                    style: TextStyle(color: HColors.textWhite, fontSize: 16.0, fontWeight: FontWeight.bold),
                  );
                },
              ),
              backgroundColor: HColors.transparent,
            ),
            body: Container(
              margin: const EdgeInsets.only(left: 48.0, top: 64.0, right: 48.0),
              child: Body(controller),
            ),
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  final LoginController controller;

  Body(this.controller);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: controller,
      builder: (controller) {
        return PageView.builder(
            itemCount: 2,
            controller: controller.pageController,
            itemBuilder: (context, index) {
              return index == 1 ? RegisterBody(controller) : LoginBody(controller);
            });
      },
    );
  }
}

class LoginBody extends StatelessWidget {
  final LoginController controller;

  LoginBody(this.controller);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: controller,
        builder: (controller) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Input(
                  controller: controller.usernameController,
                  prefixIcon: Icons.person,
                  labelText: Strings.inputUsername,
                  obscureText: false,
                  validator: (s) {
                    return s!.trim().isEmpty ? Strings.usernameIsEmpty : null;
                  },
                ),
                Input(
                  controller: controller.passwordController,
                  prefixIcon: Icons.verified_user,
                  labelText: Strings.inputPassword,
                  obscureText: true,
                  validator: (s) {
                    return s!.trim().isEmpty ? Strings.passwordIsEmpty : null;
                  },
                ),
                Space.v16,
                Builder(builder: (context) {
                  return RoundButton(
                    Strings.login,
                    textColor: HColors.textWhite,
                    color: Colors.white38,
                    onTap: () {
                      if (true == Form.of(context)?.validate()) {
                        controller.login();
                      }
                    },
                  );
                }),
                TextButton(
                  child: Text(
                    Strings.toRegister,
                    style: TextStyles.caption(context).copyWith(color: HColors.textWhite),
                  ),
                  onPressed: () {
                    controller.toRegister();
                  },
                ),
              ],
            ),
          );
        });
  }
}

class RegisterBody extends StatelessWidget {
  final LoginController controller;

  RegisterBody(this.controller);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: controller,
        builder: (controller) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Input(
                  controller: controller.registerUsernameController,
                  prefixIcon: Icons.person,
                  labelText: Strings.inputUsername,
                  obscureText: false,
                  validator: (s) {
                    return s!.trim().isEmpty ? Strings.usernameIsEmpty : null;
                  },
                ),
                Input(
                  controller: controller.registerPasswordController,
                  prefixIcon: Icons.verified_user,
                  labelText: Strings.inputPassword,
                  obscureText: true,
                  validator: (s) {
                    return s!.trim().isEmpty ? Strings.passwordIsEmpty : null;
                  },
                ),
                Input(
                  controller: controller.registerConfirmPasswordController,
                  prefixIcon: Icons.verified_user,
                  labelText: Strings.inputConfirmPassword,
                  obscureText: true,
                  validator: (s) {
                    return s!.trim().isEmpty ? Strings.passwordIsEmpty : null;
                  },
                ),
                Space.v16,
                Builder(builder: (context) {
                  return RoundButton(
                    Strings.register,
                    textColor: HColors.textWhite,
                    color: Colors.white38,
                    onTap: () {
                      if (true == Form.of(context)?.validate()) {}
                    },
                  );
                }),
                TextButton(
                  child: Text(
                    Strings.toLogin,
                    style: TextStyles.caption(context).copyWith(color: HColors.textWhite),
                  ),
                  onPressed: () {
                    controller.toLogin();
                  },
                ),
              ],
            ),
          );
        });
  }
}
