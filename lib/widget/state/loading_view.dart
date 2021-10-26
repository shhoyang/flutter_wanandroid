import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/style/colors.dart';
import 'package:flutter_wanandroid/style/space.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';

class LoadingView extends StatelessWidget {
  final String text;

  LoadingView({Key key, this.text = Strings.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitWave(
          size: 32.0,
          color: HColors.loading,
        ),
        Space.v8,
        Text(
          text,
          style: TextStyles.bodyText1(context).copyWith(
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
