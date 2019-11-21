import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/search_result_bloc.dart';
import 'package:flutter_wanandroid/page/search_result_page.dart';
import 'package:flutter_wanandroid/page/web_page.dart';
import 'package:flutter_wanandroid/widget/dialog/loading_dialog.dart';

class NavigatorUtils {
  static void pushPage(BuildContext context, Widget page, {String name}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: name == null ? null : RouteSettings(name: name),
            builder: (context) => page));
  }

  static void pushSearchResult(BuildContext context, String keyWord) {
    pushPage(
      context,
      BlocProvider<SearchResultBloc>(
        bloc: SearchResultBloc(keyWord),
        child: SearchResultPage(keyWord: keyWord),
      ),
    );
  }

  static void pushWeb(BuildContext context, String title, String url) {
    pushPage(context, WebPage(title: title, url: url));
  }

  static void showLoadingDialog(BuildContext context,
      [String text = "正在加载..."]) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(text: text);
        });
  }
}
