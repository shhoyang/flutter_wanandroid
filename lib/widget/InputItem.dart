import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';

class InputItem extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labelText;
  final bool obscureText;

  InputItem(
      {Key key,
      this.controller,
      this.prefixIcon,
      this.labelText,
      this.obscureText})
      : super(key: key);

  @override
  _InputItemState createState() => _InputItemState();
}

class _InputItemState extends State<InputItem> {

  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: TextStyle(color: HColors.loginInput),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: HColors.loginInput,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: HColors.loginInput),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                color: HColors.loginInput,
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HColors.loginInput)),
      ),
    );
  }
}
