import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/page_params/WebParams.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final Completer<WebViewController> _completer = Completer();

  @override
  Widget build(BuildContext context) {
    var webParams = ModalRoute.of(context)?.settings.arguments as WebParams?;
    return Scaffold(
      appBar: SimpleAppBar(
        webParams?.title ?? "",
      ),
      body: WebView(
        initialUrl: webParams?.url ?? "",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _completer.complete(webViewController);
        },
      ),
    );
  }
}
