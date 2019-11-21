import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';

class LoadingView extends StatelessWidget {
  final String text;

  LoadingView({Key key, this.text = "正在加载..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitWave(
          size: 32.0,
          color: HColors.loading,
        ),
        Space.v8,
        Text(
          text,
          style: TextStyle(
            color: HColors.black,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
