import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String url;

  WebPage({Key key, this.title = "", this.url}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(widget.title),
      body: Container(),
    );
  }
}
