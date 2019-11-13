import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/page/web_page.dart';

class NavigatorUtils {
  static void pushPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

//  static void pushWeb(BuildContext context, String title, String url) {
//    pushPage(context, WebPage(title: title, url: url));
//  }
}
