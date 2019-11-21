import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key key, this.text = "正在加载..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 120,
          height: 120,
          child: new Container(
            child: LoadingView(text: text),
            decoration: ShapeDecoration(
              color: HColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
