import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/riverpod/provider_observer.dart';
import 'package:riverpod_sample/screen/home_screen.dart';

void main() {
  runApp(
    ProviderScope( // Provider 쓸라면 Provider Scope가 상위에 존재해야 함
    observers: [
      // Provider Scope 하위에 있는 모든 Provider들이 호출될 때 실행함
      Logger(),
    ],
    child: const MaterialApp(
      home: HomeScreen(),
    ),
  ));
}
