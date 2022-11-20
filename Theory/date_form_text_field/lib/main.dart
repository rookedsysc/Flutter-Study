import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen(),);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myController = TextEditingController();
  RegExp regExp = RegExp(r'([01][0-9]|2[0-3]):([0-5][0-9])'); // hh:mm
  String inputTime = 'Hi';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: myController,
                  onChanged: (text) {
                    setState(() {
                      if (regExp.hasMatch(text)){
                        print(text);
                        int indexRegExp = text.indexOf(regExp);
                        if(indexRegExp != 0) {
                          // 첫 글자가 정규식에 해당 안되면 첫 글자 ~ 정규식 앞 글자까지 다 지움
                          inputTime = text.replaceRange(0, indexRegExp - 1, '');
                        } else {
                          inputTime = text;
                        }
                        myController.text = text.replaceAll(regExp, "");
                      }
                    });
                  },
                ),
              ),
            ),
            Text(inputTime, style: const TextStyle(color: Colors.blue),),
          ],
        ),
      ),
    );
  }
}

