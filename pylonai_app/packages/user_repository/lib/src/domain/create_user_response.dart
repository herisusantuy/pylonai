import 'package:json_annotation/json_annotation.dart';

part 'create_user_response.g.dart';

@JsonSerializable()
class CreateUserResponse {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String createdAt;
  final String updatedAt;

  CreateUserResponse(this.id, this.email, this.password, this.name, this.role,
      this.avatar, this.createdAt, this.updatedAt);

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateUserResponseFromJson(json);

  Map<String, dynamic> toJson(Map<String, String> body) =>
      _$CreateUserResponseToJson(this);
}
