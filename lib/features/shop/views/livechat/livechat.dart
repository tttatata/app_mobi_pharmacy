import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final String title = "Online Agent";
  final String selectedUrl = "https://yoururl.com"; // URL hợp lệ
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int position = 1;
  final key = UniqueKey();

  void doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  void startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        title: Text(
          'Live chat',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
      body: IndexedStack(
        index: position,
        children: <Widget>[
          WebView(
            initialUrl:
                'https://tawk.to/chat/663b931907f59932ab3d5416/1htcbd7me',
            javascriptMode: JavascriptMode.unrestricted,
            key: key,
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
