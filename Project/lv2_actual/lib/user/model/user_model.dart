import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/common/utils/data_utils.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imageUrl;
  UserModel({required this.id, required this.username, required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
