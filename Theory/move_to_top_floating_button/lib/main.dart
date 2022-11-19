import 'package:flutter/material.dart';

GlobalKey customContainerKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final List<int> numbers = List.generate(100, (index) => index);

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Scrollable.ensureVisible(customContainerKey.currentContext!);
      },

      ),
      body: SingleChildScrollView(
        child: Column(
          children: numbers.map((e) => renderColorContainer(color: rainbowColors[e % rainbowColors.length], index: e),).toList(),
        ),
      ),
    );
  }

  Widget renderColorContainer(
      {required Color color, required int index, double? height}) {
    return Container(
      key: index == 0 ? customContainerKey : Key(index.toString()),
      height: height ?? 200,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 30.0),
        ),
      ),
    );
  }
}

const rainbowColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];


