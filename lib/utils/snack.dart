import 'package:flutter/material.dart';

class Snack {
  static void show(BuildContext? context, String content) {
    if (context == null) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
