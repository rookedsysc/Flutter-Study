import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/common/utils/data_utils.dart';

part 'user_model.g.dart';

// 현재 로그인의 상태 값을 담기 위한 클래스
// CursorPaginationBase와 같은 개념임
abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;
  UserModelError({required this.message});
}

class UserModelLoading extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase{
  final String id;
  final String username;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imageUrl;
  UserModel({required this.id, required this.username, required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
