import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/user_manager.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/snack.dart';
import 'package:flutter_wanandroid/widget/menu_view.dart';
import 'package:flutter_wanandroid/widget/style/h_radius.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';

import 'login_page.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  _login(BuildContext context) async {
    bool login = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    if (login) {
      UserManager.getInstance().login();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    UserManager userManager = UserManager.getInstance();
    bool isLogin = userManager.isLogin();

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200.0,
          child: Stack(
            children: <Widget>[
              Image.asset(
                CommonUtils.getImage("header", "jpeg"),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 32.0,
                    right: 8.0,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Snack.show(context, "开发中...");
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: HRadius.r6,
                        child: Image.asset(
                          CommonUtils.getImage("avatar", "jpeg"),
                          width: 72.0,
                          height: 72.0,
                        ),
                      ),
                      Space.h16,
                      Text(
                        isLogin ? userManager.username : "未登录",
                        style: TextStyle(
                            color: HColors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        MenuView(
          icon: "icon_fav",
          label: Strings.favorite,
          onPressed: () {
            Snack.show(context, "收藏");
          },
        ),
        Container(
          margin: const EdgeInsets.only(left: 48.0),
          width: double.infinity,
          height: 0.5,
          color: HColors.line,
        ),
        MenuView(
          icon: "icon_share",
          label: Strings.share,
          onPressed: () {
            Snack.show(context, "分享");
          },
        ),
        Container(
          margin: const EdgeInsets.only(left: 48.0),
          width: double.infinity,
          height: 0.5,
          color: HColors.line,
        ),
        MenuView(
          icon: "icon_setting",
          label: Strings.setting,
          onPressed: () {
            Snack.show(context, "设置");
          },
        ),
        Container(
          margin: const EdgeInsets.only(left: 48.0),
          width: double.infinity,
          height: 0.5,
          color: HColors.line,
        ),
        MenuView(
          icon: "icon_about",
          label: Strings.about,
          onPressed: () {
            Snack.show(context, "关于");
          },
        ),
        Container(
          width: double.infinity,
          height: 0.5,
          color: HColors.line,
        ),
        Container(
          margin: EdgeInsets.only(left: 48.0, top: 32.0, right: 48.0),
          child: InkWell(
            borderRadius: HRadius.r6,
            child: Container(
              width: double.infinity,
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                isLogin ? "退出登录" : "去登录",
                style: TextStyle(color: HColors.royalBlue, fontSize: 16.0),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: HColors.royalBlue),
                borderRadius: HRadius.r6,
              ),
            ),
            onTap: () {
              if (isLogin) {
                userManager.logout();
                setState(() {});
              } else {
                _login(context);
              }
            },
          ),
        ),
      ],
    );
  }
}
