import 'package:flutter/material.dart';

void main() {
  runApp(
    // Materail App은 반드시 들어가야 함. 국룰임.
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    ),
  );
}

