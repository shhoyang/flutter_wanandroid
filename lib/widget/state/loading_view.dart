import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wanandroid/constant/h_colors.dart';
import 'package:flutter_wanandroid/widget/space.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new SpinKitWave(
          size: 32.0,
          color: Color(HColors.loading),
        ),
        Space.v8,
        Text("正在加载..."),
      ],
    );
  }
}
