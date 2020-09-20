import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF670e1e),
        title: const Text('Terms & Conditions'),
      ),
      body:  WebView(
          initialUrl: 'http://portal.mbj.in/terms-and-condition',
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          }
      ),

    );
  }
}
