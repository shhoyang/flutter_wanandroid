import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/page/register_page.dart';
import 'package:flutter_wanandroid/utils/snack.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/InputItem.dart';
import 'package:flutter_wanandroid/widget/style/h_radius.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Image.asset(
            CommonUtils.getImage("login_bg", "jpeg"),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: HColors.transparent,
            appBar: AppBar(
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: HColors.white),
              centerTitle: true,
              title: Text(
                Strings.login,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith()
                    .copyWith(color: HColors.white),
              ),
              elevation: 0.0,
              backgroundColor: HColors.transparent,
            ),
            body: LoginBody(),
          )
        ],
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  _login(BuildContext context, String username, String password) async {
    DioManager.getInstance()
        .post(ApiService.getUrl(ApiService.login, isJson: false), (data) {
      Snack.show(context, "登录成功");
      Navigator.pop(context);
      Navigator.pop(context, true);

      //返回根路由：
//      Navigator.of(context).pushAndRemoveUntil(
//          new MaterialPageRoute(builder: (context) => new HomePage()),
//          (route) => false);
//      Navigator.of(context).pushReplacementNamed("home");
    }, errorCallBack: (msg, code) {
      Navigator.pop(context);
      Snack.show(context, code);
    }, params: {"username": username, "password": password});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 48.0, top: 64.0, right: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InputItem(
            controller: _usernameController,
            prefixIcon: Icons.person,
            labelText: Strings.inputUsername,
            obscureText: false,
          ),
          InputItem(
            controller: _passwordController,
            prefixIcon: Icons.verified_user,
            labelText: Strings.inputPassword,
            obscureText: true,
          ),
          Space.v16,
          InkWell(
            borderRadius: HRadius.r4,
            child: Container(
              width: double.infinity,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                Strings.login,
                style: TextStyle(color: HColors.white, fontSize: 16.0),
              ),
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: HRadius.r4,
              ),
            ),
            onTap: () {
              if (_usernameController.text.isEmpty) {
                Snack.show(context, "请输入用户名");
                return;
              }
              if (_passwordController.text.isEmpty) {
                Snack.show(context, "请输入密码");
                return;
              }

              NavigatorUtils.showLoadingDialog(context, "正在登录...");
              _login(
                  context, _usernameController.text, _passwordController.text);
            },
          ),
          Space.v8,
          InkWell(
            child: Text(
              "没有账号,去注册",
              style: TextStyle(color: HColors.white, fontSize: 12.0),
            ),
            onTap: () {
              NavigatorUtils.pushPage(context, RegisterPage());
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController?.dispose();
    _passwordController?.dispose();
  }
}
