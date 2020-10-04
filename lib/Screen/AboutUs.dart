import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF670e1e),
        title: const Text('Brand Story'),
      ),
      body:  WebView(
          initialUrl: 'http://portal.mbj.in/about',
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          }
      ),
    );
  }
}
