import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          color: Colors.green,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        tooltip: 'Toggle Opacity',
        child: const Icon(Icons.flip),
      )
      ,
    );
  }

}
