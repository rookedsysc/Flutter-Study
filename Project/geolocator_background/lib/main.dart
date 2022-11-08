import 'package:flutter/material.dart';
import 'package:geolocator_background/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(brightness: Brightness.dark),
    )
  );
}