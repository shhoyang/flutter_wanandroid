import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/widget/InputItem.dart';
import 'package:flutter_wanandroid/widget/style/h_radius.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

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
                Strings.register,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith()
                    .copyWith(color: HColors.white),
              ),
              elevation: 0.0,
              backgroundColor: HColors.transparent,
            ),
            body: Container(
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
                  InputItem(
                    controller: _confirmPasswordController,
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
                        Strings.register,
                        style: TextStyle(color: HColors.white, fontSize: 16.0),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: HRadius.r4,
                      ),
                    ),
                    onTap: () {},
                  ),
                  Space.v8,
                  InkWell(
                    child: Text(
                      "已有账号,去登录",
                      style: TextStyle(color: HColors.white, fontSize: 12.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
