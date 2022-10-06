import 'package:drift/drift.dart';

class Schedules extends Table {
  // PRIMARY KEY
  // 함수를 return 해주기 때문에 ()를 한 번 더 붙여줘야 함.
  IntColumn get id => integer()();

  // 내용
  TextColumn get content => text()();

  // 일정 날짜
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get starttime => integer()();

  // 끝 시간
  IntColumn get endTime => integer()();

  // category Color Table ID
  IntColumn get colorId => integer()();

  // 생성날짜
  DateTimeColumn get createdAt => dateTime()();
}
