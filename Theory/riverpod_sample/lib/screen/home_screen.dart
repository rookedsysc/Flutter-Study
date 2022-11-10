import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/screen/state_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'HomeScreen',
        body: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StateRiverpodScreen()));
                },
                child: Text("State Riverpod Screen"))
          ],
        ));
  }
}
