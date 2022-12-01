import 'package:drift/drift.dart';
import 'package:drift_test/database/drift_database.dart';
import 'package:drift_test/model/diary.dart';

part 'diary_dao.g.dart';

// Access할 테이블 선택
@DriftAccessor(tables: [Diary])
class DiaryDao extends DatabaseAccessor<LocalDatabase> with _$DiaryDaoMixin {
  // Accessor 생성자
  DiaryDao(LocalDatabase db) : super(db);

  // 전체 다이어리 관측
  Stream<List<DiaryData>> watchAllDiaries() => select(diary).watch();

  // 다이어리 추가
  Future<int> createDiary(DiaryCompanion data) => into(diary).insert(data);
}