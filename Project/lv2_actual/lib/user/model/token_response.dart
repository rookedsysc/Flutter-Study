import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';


// refreshToken을 이용해서 받아오는 accessToken을 담고 있는 클래스
@JsonSerializable()
class TokenResponse{
  final String accessToken;
  TokenResponse({
    required this.accessToken
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

}