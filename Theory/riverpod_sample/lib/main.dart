import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/screen/home_screen.dart';

void main() {
  runApp(
    const ProviderScope( // Provider 쓸라면 Provider Scope가 상위에 존재해야 함
    child: MaterialApp(
      home: HomeScreen(),
    ),
  ));
}
