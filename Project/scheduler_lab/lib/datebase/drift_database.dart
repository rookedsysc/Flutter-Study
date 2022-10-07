import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheduler_lab/model/category_color.dart';
import 'package:scheduler_lab/model/schedule.dart';
import 'package:scheduler_lab/model/category_color.dart';
import 'package:path/path.dart' as p;


// private 값까지 불러올 수 있음.
// drift를 통해서 db와 연결을 할 때 연결이 있는 파일에서 part 선언을 해줘야함. {파일명}.g.dart
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)

// 상속받는 class는 drift_database.g.dart에서 생성이 될 예정임.
class LocalDatabase extends _$LocalDatabase{
  LocalDatabase() : super(_openConnection());

  // SchedulesCompanion 안에다가 값을 넣어줘야지 insert할 수 있음.
  // insert를 하면 자동으로 ID값(Primary Key)을 return 받을 수 있음.
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);
  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  // watch로 값을 받아주면 Schedule이 바뀔 때 yeild로 데이터를 return 해줌.
  Stream<List<Schedule>> watchSchedules() =>
      select(schedules).watch();

  // Code Generator로 db를 생성하고 나서 override 해줘야 함.
  // DB의 구조가 바뀔 때마다 변경되는 데이터 베이스 구조 Version임.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async{
    // 앱 전용으로 사용할 수 있는 폴더의 위치를 가져옴.
    final dbFolder = await getApplicationDocumentsDirectory();
    // path / '파일명'을 통해서 db를 만들 파일을 생성해줌.
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    // DB 생성 및 return
    return NativeDatabase(file);
  });
}

