import 'package:flutter/material.dart';
import 'package:scheduler_lab/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // flutter가 준비가 될 때까지 기다릴 수 있음.
  // 원래는 runApp을 실행할 때 실행되지만 그 이전에 실행해줄 코드가 있을 때 사용
  WidgetsFlutterBinding.ensureInitialized();
  // Date 포맷을 초기화 해줌. ko_KR을 사용하기 위해서
  await initializeDateFormatting();

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Dongle'),
    home: HomeScreen(),
  ));
}
