import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;

  UserResponse(
      this.id, this.email, this.password, this.name, this.role, this.avatar);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson(Map<String, String> body) =>
      _$UserResponseToJson(this);
}
