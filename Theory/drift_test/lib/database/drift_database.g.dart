// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class DiaryData extends DataClass implements Insertable<DiaryData> {
  final String title;
  final String content;
  final DateTime date;
  const DiaryData(
      {required this.title, required this.content, required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  DiaryCompanion toCompanion(bool nullToAbsent) {
    return DiaryCompanion(
      title: Value(title),
      content: Value(content),
      date: Value(date),
    );
  }

  factory DiaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryData(
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  DiaryData copyWith({String? title, String? content, DateTime? date}) =>
      DiaryData(
        title: title ?? this.title,
        content: content ?? this.content,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('DiaryData(')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, content, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryData &&
          other.title == this.title &&
          other.content == this.content &&
          other.date == this.date);
}

class DiaryCompanion extends UpdateCompanion<DiaryData> {
  final Value<String> title;
  final Value<String> content;
  final Value<DateTime> date;
  const DiaryCompanion({
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.date = const Value.absent(),
  });
  DiaryCompanion.insert({
    required String title,
    required String content,
    required DateTime date,
  })  : title = Value(title),
        content = Value(content),
        date = Value(date);
  static Insertable<DiaryData> custom({
    Expression<String>? title,
    Expression<String>? content,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (date != null) 'date': date,
    });
  }

  DiaryCompanion copyWith(
      {Value<String>? title, Value<String>? content, Value<DateTime>? date}) {
    return DiaryCompanion(
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryCompanion(')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $DiaryTable extends Diary with TableInfo<$DiaryTable, DiaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [title, content, date];
  @override
  String get aliasedName => _alias ?? 'diary';
  @override
  String get actualTableName => 'diary';
  @override
  VerificationContext validateIntegrity(Insertable<DiaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DiaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaryData(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $DiaryTable createAlias(String alias) {
    return $DiaryTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $DiaryTable diary = $DiaryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [diary];
}
