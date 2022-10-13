import 'package:flutter/material.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Snackbar Sample'),
          ),
          body: SnackBarPage(),
        ),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: const Text('Snack bar render successful'),
              action: SnackBarAction(
                label: 'Undo', // Snackbar의 Label에 표시될 이름
                onPressed: () {}, // Label(Undo) 눌렀을 때 실행될 함수
              ),
            );
            // 위젯 트리에서 Snackbar Messenger 찾고 그걸 이용해서 Snackbar 보여줌
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Text('Render Snack Bar')),
    );
  }
}
