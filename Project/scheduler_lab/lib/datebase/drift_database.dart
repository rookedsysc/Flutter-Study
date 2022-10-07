import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheduler_lab/model/category_color.dart';
import 'package:scheduler_lab/model/schedule.dart';
import 'package:scheduler_lab/model/category_color.dart';
import 'package:path/path.dart' as p;
import 'package:scheduler_lab/model/schedule_with_color.dart';

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

  // watch로 값을 받아주면 schedules table이 바뀔 때마다 yeild로 데이터를 return 해줌.
  // 메모리 낭비 방지를 막기 위해서 DB에서 데이터를 선택할 때 filter를 걸어줌.
  //Stream<List<Schedule>> watchSchedules(DateTime selectedDay) {
    /* final query = select(schedules);
    query.where((tbl) => tbl.date.equals(selectedDay)); // 쿼리를 먼저 필터링 해줌.
    return query.watch(); // 필터링 된 query에다가 watch() 함수 실행 */

    /* ..의 의미는 함수를 실행할 결과값을 return 해주는게 아니라 함수가 실행할 대상을 return 해주게 됨.
    즉, 해당 구문에서는 where이 실행이 된 대상 select(schedules)를 Return 받은 것임.
    where는 return 값 없이 문자열을 필터링 해주는 기능만 하므로 watch()를 통해서 지속적으로 해당 값을 모니터링 해줄 수 없음.*/
   // return (select(schedules)..where((tbl) => tbl.date.equals(selectedDay))).watch();
  //}

  // join 구현
  Stream<List<ScheduleWithColor>> watchSchedules(DateTime selectedDay) {
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);
    query.where(schedules.date.equals(selectedDay));
    return  query.watch().map(
            (rows) => rows.map( // 모든 Schedules 다 불러옴.
              // 각 Schedule별 멤버에 접근해서 SchduleWithColor Class에 맞춰서 데이터 넣어줌.
                (row) => ScheduleWithColor(
                    schedule: row.readTable(schedules),
                    categoryColor: row.readTable(categoryColors),
                ),
            ).toList(), // 모든 데이터 처리 끝나면 List 형식으로 return.
        );
  }

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

