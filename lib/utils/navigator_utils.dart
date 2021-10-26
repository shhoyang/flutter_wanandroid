/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/page/web_page.dart';
import 'package:flutter_wanandroid/widget/dialog/loading_dialog.dart';
import 'package:get/get.dart';

class NavigatorUtils {
  static void toPage(String page, [dynamic arguments]) {
    Get.toNamed(page, arguments: arguments);
  }

  static void back() {
    Get.back();
  }

  static void pushWeb(BuildContext context, String title, String url) {
    pushPage(context, WebPage(title: title, url: url));
  }

  static void pushPage(BuildContext context, Widget page, {String name}) {
    Navigator.push(
        context, MaterialPageRoute(settings: name == null ? null : RouteSettings(name: name), builder: (context) => page));
  }

  static void showLoadingDialog(BuildContext context, [String text = Strings.loading]) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(text: text);
        });
  }
}
