import 'package:flutter/material.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:
        HomeScreen()
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Diary 등록 팝업
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                //Dialog Main Title
                title: Column(
                  children: <Widget>[
                    Text("Dialog"),
                  ],
                ),
                //
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 저장 버튼 누르면 다이어리 저장
                      // TextFormField - 입력창
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: '제목을 입력하세요',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: '내용을 입력하세요',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("저장"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      body: Center(
        child: const Text("Hello World"),
      ),
    );
  }
}
