import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/style/colors.dart';

abstract class TextStyles {
  /// NAME        COLOR        SIZE    WEIGHT    SPACING    ORIGIN NAME
  /// title     0xdd000000   20.0    500       0.0        headline6
  /// subtitle1 0xdd000000   16.0    400       0.0        subtitle1
  /// subtitle2 0xff000000   14.0    500       0.0        subtitle2
  /// bodyText1 0xdd000000   14.0    400       0.0        bodyText2
  /// bodyText2 0xdd000000   14.0    500       0.0        bodyText1
  /// caption   0x8a000000   12.0    400       0.0        caption
  /// button    0xdd000000   14.0    500       0.0        button
  /// overline  0xff000000   10.0    400       0.0        overline
  ///
  static TextStyle title1(BuildContext context) => Theme.of(context)
      .textTheme
      .headline6
      .copyWith(color: HColors.textTitle, fontSize: 16.0);

  static TextStyle title2(BuildContext context) =>
      Theme.of(context).textTheme.headline6.copyWith(
          color: HColors.textTitle,
          fontSize: 16.0,
          fontWeight: FontWeight.bold);

  static TextStyle subtitle1(BuildContext context) => Theme.of(context)
      .textTheme
      .subtitle1
      .copyWith(color: HColors.textSubtitle, fontSize: 14.0);

  static TextStyle subtitle2(BuildContext context) => Theme.of(context)
      .textTheme
      .subtitle2
      .copyWith(fontWeight: FontWeight.bold);

  static TextStyle bodyText1(BuildContext context) =>
      Theme.of(context).textTheme.bodyText2;

  static TextStyle bodyText2(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyText1
      .copyWith(fontWeight: FontWeight.bold);

  static TextStyle caption(BuildContext context) =>
      Theme.of(context).textTheme.caption.copyWith(color: HColors.textExtra);

  static TextStyle button(BuildContext context) =>
      Theme.of(context).textTheme.button;

  static TextStyle overline(BuildContext context) =>
      Theme.of(context).textTheme.overline;
}
