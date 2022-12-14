import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/page_params/WebParams.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/routes/routes.dart';
import 'package:flutter_wanandroid/widget/dialog/loading_dialog.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class NavigatorUtils {
  static void pushNamed<T extends Object>(BuildContext context, routeName, [Object? arguments]) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  static void pushWeb(BuildContext context, String title, String url) {
    pushNamed(context, Routes.WEB, WebParams(title, url));
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
