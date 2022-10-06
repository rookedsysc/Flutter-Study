import 'package:drift/drift.dart';

class Schedules extends Table {
  // PRIMARY KEY
  // 함수를 return 해주기 때문에 ()를 한 번 더 붙여줘야 함.
  // autoIncrement() : 숫자 자동으로 늘려줌.
  IntColumn get id => integer().autoIncrement()();

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
  // clientDafault는 기본으로 지정해줄 값을 넣어주면 됨. 여기서는 return이 dateTime.now()
  // 즉, createdAt에 dateTime.now()가 들어가게 됨. (임의적으로 넣을수도 있음.)
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
}
