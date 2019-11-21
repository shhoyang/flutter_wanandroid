import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/page/home_page.dart';
import 'package:flutter_wanandroid/user_manager.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp() : super() {
    requestPermission();
  }

  Future requestPermission() async {
//    Map<PermissionGroup, PermissionStatus> permissions =
//        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
//
//    // 申请结果
//    PermissionStatus permission = await PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.storage);
//
//    if (permission == PermissionStatus.granted) {
//    } else {
//      Fluttertoast.showToast(msg: "权限申请被拒绝");
//    }

    Directory appDocDir = await getApplicationDocumentsDirectory();

    print(appDocDir.path);
  }

  _initUser() {
    UserManager.getInstance().login();
  }

  @override
  Widget build(BuildContext context) {
    _initUser();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
//      initialRoute: "/",
      routes: {
        "home": (ctx) => HomePage(),
      },
      home: HomePage(),
    );
  }
}

/// flutter packages pub run build_runner watch
