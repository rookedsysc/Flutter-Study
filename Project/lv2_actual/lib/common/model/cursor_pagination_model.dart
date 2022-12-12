import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;
  CursorPaginationError({required this.message});
}

class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  // 클래스가 Generic Type을 parameter로 받을 경우 해당 타입으로 직렬화함
  genericArgumentFactories: true,
)
// 외부에서 generic을 지정해주기 위해 <T>를 사용
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;
  
  CursorPagination({
    required this.meta,
    required this.data,
  });

  // copyWith
  CursorPagination<T> copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
  // 여기서 의미하는 this는 instance를 의미
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$CursorPaginationToJson(this, toJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
  Map<String, dynamic> toJson() => _$CursorPaginationMetaToJson(this);
}

// CursorPaginationRefetching is CursorPaginationBase // true
// 새로 고침할 때
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서 추가 데이터를 요청할 때
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
