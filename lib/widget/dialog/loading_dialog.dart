import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:flutter_wanandroid/style/colors.dart';

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key key, this.text = Strings.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new Container(
          width: 128.0,
          height: 128.0,
          child: LoadingView(text: text),
          decoration: ShapeDecoration(
            color: HColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
