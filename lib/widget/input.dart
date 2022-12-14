import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/style/colors.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class Input extends StatefulWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? labelText;
  final String? helpText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  Input(
      {Key? key,
      required this.controller,
      this.prefixIcon,
      this.labelText,
      this.helpText,
      this.obscureText = false,
      this.validator})
      : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: TextStyle(color: HColors.textWhite, height: 1.2),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: HColors.white,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: HColors.textWhite),
        hintText: widget.helpText,
        helperStyle: TextStyle(color: HColors.textWhite),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                color: HColors.white,
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: HColors.white)),
      ),
      validator: widget.validator,
    );
  }
}
