import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar 넣기
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Rookedsysc\'s Blog'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://rookedsysc.github.io',
            // 기본 값은 disable로 javascript를 못 읽어오게 되어있음.
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
