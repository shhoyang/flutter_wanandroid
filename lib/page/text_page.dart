import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/style/colors.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-07

class TextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildType(context, Theme.of(context).textTheme.headline1),
            _buildType(context, Theme.of(context).textTheme.headline2),
            _buildType(context, Theme.of(context).textTheme.headline3),
            _buildType(context, Theme.of(context).textTheme.headline4),
            _buildType(context, Theme.of(context).textTheme.headline5),
            _buildType(context, Theme.of(context).textTheme.headline6),
            _buildType(context, Theme.of(context).textTheme.subtitle1),
            _buildType(context, Theme.of(context).textTheme.subtitle2),
            _buildType(context, Theme.of(context).textTheme.bodyText1),
            _buildType(context, Theme.of(context).textTheme.bodyText2),
            _buildType(context, Theme.of(context).textTheme.caption),
            _buildType(context, Theme.of(context).textTheme.button),
            _buildType(context, Theme.of(context).textTheme.overline),
            _buildType2(context, Theme.of(context).textTheme.headline4),
            _buildType2(context, Theme.of(context).textTheme.headline5),
            _buildType2(context, Theme.of(context).textTheme.headline6),
            _buildType2(context, Theme.of(context).textTheme.subtitle1),
            _buildType2(context, Theme.of(context).textTheme.subtitle2),
            _buildType2(context, Theme.of(context).textTheme.bodyText1),
            _buildType2(context, Theme.of(context).textTheme.bodyText2),
            _buildType2(context, Theme.of(context).textTheme.caption),
            _buildType2(context, Theme.of(context).textTheme.button),
            _buildType2(context, Theme.of(context).textTheme.overline),
          ],
        ),
      ),
    );
  }

  Widget _buildType(BuildContext context, TextStyle? textStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hellow world，您好世界", style: textStyle),
        Text("$textStyle", style: Theme.of(context).textTheme.caption),
        Container(width: double.infinity, height: 1.0, color: HColors.primary),
      ],
    );
  }

  Widget _buildType2(BuildContext context, TextStyle? textStyle) {
    return Text("Hellow world，您好世界", style: textStyle);
  }
}
