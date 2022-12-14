import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/style/text_styles.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Strings.noData,
        style: TextStyles.bodyText1(context).copyWith(fontSize: 12.0),
      ),
    );
  }
}
