import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_lab/const/colors.dart';
import 'package:scheduler_lab/datebase/drift_database.dart';
import 'package:scheduler_lab/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // flutter가 준비가 될 때까지 기다릴 수 있음.
  // 원래는 runApp을 실행할 때 실행되지만 그 이전에 실행해줄 코드가 있을 때 사용
  WidgetsFlutterBinding.ensureInitialized();
  // Date 포맷을 초기화 해줌. ko_KR을 사용하기 위해서
  await initializeDateFormatting();

  // DB 쿼리 있는 Class
  final database = LocalDatabase();

  final colors = await database.getCategoryColors();
  if(colors.isEmpty) {
    for(String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          // insert 해주는 모든 값들은 Value() 안에서 넣어줘야 함.
          hexCode: Value(hexCode),
        )
      );
    }
  }
  print('---------- GET COLORS ------------');
  print(('CategoryColors : ${await database.getCategoryColors()}'));

  runApp(MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.dark(
      primary: PRIMARY_COLOR
    ), fontFamily: 'Dongle'),
    home: HomeScreen(),
  ));
}
