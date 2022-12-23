
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

// 로그인 정보를 담고 있는 클래스 
@JsonSerializable()
class LoginResponse {
  final String refershToken;
  final String accessToken;

  LoginResponse({
    required this.refershToken,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}