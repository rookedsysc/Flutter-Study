

import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';
 
// 다음 페이지 요청하는 경우 after 값과 counter 값을 전달함
@JsonSerializable()
class PaginationParams {
  final String? after;
  final int? count;

  const PaginationParams({this.after, this.count});
  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);

  PaginationParams copyWith({String? after, int? count}) {
    return PaginationParams(
      after: after ?? this.after,
      count: count ?? this.count,
    );
  }
}