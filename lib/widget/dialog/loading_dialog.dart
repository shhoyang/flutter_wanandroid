import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:flutter_wanandroid/style/colors.dart';

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key? key, this.text = Strings.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const constantMap = const {
      2: 'helium',
      10: 'neon',
      18: 'argon',
    };
    constantMap[1] = "1";

    return Material(
      type: MaterialType.transparency,
      child:  Center(
        child:  Container(
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
