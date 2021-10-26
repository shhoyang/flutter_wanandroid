/// @Author: Yang Shihao
/// @Date: 2021-01-06

/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/app_init.dart';
import 'package:flutter_wanandroid/page/home_page.dart';
import 'package:flutter_wanandroid/routes/pages.dart';
import 'package:flutter_wanandroid/style/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInit.init();
  runApp(MyApp());
  if (Platform.isAndroid) {
    /// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    /// SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wan Android',
      home: HomePage(),
      theme: appThemeData(context),
      initialRoute: '/',
      getPages: GetPages.pages,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            _hideKeyboard(context);
          },
          child: child,
        ),
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }
}

/// flutter packages pub run build_runner watch
/// flutter packages pub run build_runner watch --delete-conflicting-outputs
