import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_test/database/diary_dao.dart';
import 'package:drift_test/model/diary.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

@DriftDatabase(tables: [
  // 괄호 없이 type 선언하듯이 넣어줘야 함
  Diary, // 위에서 구성한 테이블
], daos: [
  // 괄호 없이 type 선언하듯이 넣어줘야 함
  DiaryDao, // 위에서 구성한 DAO
])

// _$LocalDatabase 파일은 drift_database.g.dart 파일에 생성될 거임
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// 하드 드라이브의 어떤 위치에다가 DB를 저장할건지 명시해줌
LazyDatabase _openConnection() {
  return LazyDatabase(() async{
    // os에서 app별로 사용할 수 있는 위치를 지정해주는데 이를 가져오는 것임
    final dbFolder = await getApplicationDocumentsDirectory();
    // 무조건 dart io import
    // join은 경로를 붙여주는 거임 (위에서 구한 경로 + 내가 정한 파일 이름)
    final file = File(p.join(dbFolder.path, "db.sqlist"));
    return NativeDatabase(file);
  });
}