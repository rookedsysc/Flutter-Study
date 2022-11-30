import 'package:drift/drift.dart';

class Diary extends Table {
  TextColumn get title => text()();
  TextColumn get content => text()();
  DateTimeColumn get date => dateTime()();
}
