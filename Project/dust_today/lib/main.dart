import 'package:dust_today/model/stat_model.dart';
import 'package:dust_today/screen/test_screen/test_screen.dart';
import 'package:dust_today/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = 'test';

void main() async {
  await Hive.initFlutter();

  // 데이터를 담는 박스 생성
  await Hive.openBox(testBox);

  // Hive Adapter 사용하기
  // <generic>(생성된 Adapter)
  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  // item Code별로 Box 생성
  for(ItemCode itemCode in ItemCode.values) {
    // 좀 더 세부적으로 StatModel의 값들만 넣어줄 것이라고 정의
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: HomeScreen(),
    ),
  );
}

