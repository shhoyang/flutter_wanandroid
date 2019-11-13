import 'package:flutter/cupertino.dart';

class Space {
  static Widget h8 = SizedBox(width: 8.0);
  static Widget h16 = SizedBox(width: 16.0);

  static Widget v8 = SizedBox(height: 8.0);

  static Widget getH(double w) {
    return SizedBox(width: w);
  }

  static Widget getV(double h) {
    return SizedBox(height: h);
  }
}
