import 'package:flutter/material.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  BaseStatefulPage({Key key}) : super(key: key);

  @override
  _BaseStatefulPageState createState() => _BaseStatefulPageState();

  Widget build(BuildContext context);
}

class _BaseStatefulPageState extends State<BaseStatefulPage> {
  _BaseStatefulPageState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: widget.build(context),
    );
  }
}
