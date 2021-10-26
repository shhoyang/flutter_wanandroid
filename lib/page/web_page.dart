import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String url;

  WebPage({Key key, this.title = "", this.url}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final Completer<WebViewController> _completer = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        widget.title,
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _completer.complete(webViewController);
        },
      ),
    );
  }
}
