import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';

class MenuView extends StatelessWidget {
  final String icon;

  final String label;

  final VoidCallback onPressed;

  MenuView({Key key, this.icon, this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.0,
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Space.h8,
            Image.asset(
              CommonUtils.getImage(icon),
              width: 28.0,
              height: 28.0,
            ),
            Space.h8,
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: HColors.black, fontSize: 14.0),
              ),
            ),
            Icon(Icons.keyboard_arrow_right,color: HColors.darkGray),
            Space.h8,
          ],
        ),
        onTap: onPressed,
      ),
    );
  }
}
