import 'dart:async';
import 'package:dio/dio.dart';

import 'package:user_repository/src/models/models.dart';

import 'domain/user_response.dart';

final dio = Dio();

class UserRepository {
  Future<UserResponse?> getUser() async {
    var response = await dio.get('https://api.escuelajs.co/api/v1/users/2');
    return UserResponse.fromJson(response.data);
  }

  Future<List<UserResponse>> getUsers() async {
    var response = await dio.get('https://api.escuelajs.co/api/v1/users');
    final users = response.data as List;
    return users.map((e) => UserResponse.fromJson(e)).toList();
  }
}
