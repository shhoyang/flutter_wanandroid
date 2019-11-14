import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/search_result_bloc.dart';
import 'package:flutter_wanandroid/page/search_result_page.dart';
import 'package:flutter_wanandroid/page/web_page.dart';

class NavigatorUtils {
  static void pushPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
}
