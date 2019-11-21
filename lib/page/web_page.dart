import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String url;

  WebPage({Key key, this.title = "", this.url}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(widget.title),
      body: IndexedStack(
        children: <Widget>[
          Center(
            child: LoadingView(),
          ),
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {},
            onPageFinished: (s) {
              setState(() {
                _index = 1;
              });
            },
            initialUrl: widget.url,
          ),
        ],
        index: _index,
      ),
    );
  }
}
