import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/style/colors.dart';

ThemeData appThemeData(BuildContext context) => ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            minWidth: 32.0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: HColors.white,
            elevation: 1.0,
            iconTheme: Theme.of(context).iconTheme.copyWith(color: HColors.black),
            actionsIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: HColors.black),
            centerTitle: true,
          ),
    );
