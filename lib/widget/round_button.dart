import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/style/style.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-15

class RoundButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color textColor;
  final Color color;
  final double radius;
  final GestureTapCallback? onTap;

  RoundButton(this.text,
      {Key? key,
      this.width = double.infinity,
      this.height = 40.0,
      this.radius = 4.0,
      this.textColor = HColors.textWhite,
      this.color = HColors.primary,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 40.0,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyles.button(context).copyWith(color: textColor),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
      onTap: onTap,
    );
  }
}
