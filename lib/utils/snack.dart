import 'package:flutter/material.dart';

class Snack {
  static void show(BuildContext context, String content) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}
