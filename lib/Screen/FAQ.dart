import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}
class _FAQState extends State<FAQ> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF670e1e),
        title: const Text('FAQS'),
      ),
      body: WebView(
          initialUrl: 'http://portal.mbj.in/faq',
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          }
      ),
    );
  }
}