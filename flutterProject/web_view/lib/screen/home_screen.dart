import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? controller;
  final homeUrl = 'https://rookedsysc.github.io';

  // const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar 넣기
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Rookedsysc\'s Blog'),
        centerTitle: true,

        // App Bar에 아이콘 만들어줌
        actions: [IconButton(onPressed: () { // Icon onPressed 동작시 실행할 함수
          if (controller == null) {
            return;
          } else {
            // 절대로 null 값이 들어갈 수 없다는 것을 알려줌.
            controller!.loadUrl(homeUrl);
          }
        }, icon: Icon(
          Icons.home,
        ))],
      ),
      body: SafeArea(
        child: WebView(
          // WebView에서 할 동작을 Controller에 정의해주고 실행시켜줌.
          onWebViewCreated: (WebViewController controller) {
            this.controller = controller;
          },
          initialUrl: homeUrl,
          // 기본 값은 disable로 javascript를 못 읽어오게 되어있음.
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
