import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/style/style.dart';

class SimpleAppBar extends AppBar {
  SimpleAppBar(String titleText,
      {List<Widget>? menus, PreferredSizeWidget? bottom})
      : super(
          title: Text(
            titleText,
            style: TextStyle(
              color: HColors.textBlack,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: menus,
          bottom: bottom,
          toolbarHeight: Dimens.titleHeight,
        );
}
