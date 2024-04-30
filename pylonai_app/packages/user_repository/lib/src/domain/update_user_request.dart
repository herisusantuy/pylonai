import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  final String? email;
  final String? password;
  final String? name;
  final String? role;

  UpdateUserRequest(this.email, this.password, this.name, this.role);

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson(Map<String, String> body) =>
      _$UpdateUserRequestToJson(this);
}
