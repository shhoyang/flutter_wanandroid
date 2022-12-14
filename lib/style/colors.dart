import 'package:flutter/material.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

abstract class HColors {
  /// 按颜色
  static const Color primary = Color(0xFF2196F3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grayWhite = Color(0xFFF0F0F0);
  static const Color whiteSmoke = Color(0xFFF5F5F5);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF757575);
  static const Color gray = Color(0xFF808080);
  static const Color orangeRed = Color(0xFFFF4500);
  static const Color transparent = Color(0x00000000);

  ///文字
  static const Color textPrimary = primary;
  static const Color textBlack = black;
  static const Color textDarkGray = darkGray;
  static const Color textWhite = white;
  static const Color textTitle = Color(0xFF353535);
  static const Color textSubtitle = Color(0xFF888888);
  static const Color textExtra = Color(0xFFB2B2B2);
  static const Color textLink = Color(0xFF576B95);
  static const Color textRed = Color(0xFFE64340);

  /// 按功能-------------------------------------

  /// 底部导航
  static const Color navTabNormal = textDarkGray;
  static const Color navTabActive = textPrimary;
  static const Color favoriteUn = Color(0xFFBFBFBF);
  static const Color favoriteEd = Color(0xFF7CC1FA);

  /// tabLayout
  static const Color tabNormal = textDarkGray;
  static const Color tabActive = textPrimary;

  static const Color line = Color(0xFFD3D3D3);

  static const Color loading = primary;
  static const Color hotWord = Color(0xFF586C94);
  static const Color tag = orangeRed;
}
