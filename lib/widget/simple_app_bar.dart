import 'package:flutter/material.dart';

class SimpleAppBar extends AppBar {

  final String titleText;
  final List<Widget> menus;

  SimpleAppBar(this.titleText, {this.menus})
      : super(centerTitle: true, title:  Text(titleText), actions: menus);
}
