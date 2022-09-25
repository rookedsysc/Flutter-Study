import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TestWidget(label: 'label1'),
            const TestWidget(label: 'label2'), // const 붙이고 밑줄 없어짐, const 지정된 widget은 build를 다시 실행하지 않음.
            ElevatedButton(
              onPressed: () {
                // build가 다시 실행이 됨. (label1, label2다 실행됨.)
                setState(() {

                });
              },
              child: const Text(
                '빌드',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String label;

  const TestWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$label build 실행');
    return Container(
      child: Text(
        label,
      ),
    );
  }
}
