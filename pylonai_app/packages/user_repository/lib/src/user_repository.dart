import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:user_repository/src/models/models.dart';

import 'domain/user_response.dart';

final dio = Dio();

class UserRepository {
  Future<UserResponse?> getUser(int id) async {
    final prefs = await SharedPreferences.getInstance();
    var accessToken = await prefs.getString('accessToken');
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer ${accessToken}";
    var response = await dio.get('https://api.escuelajs.co/api/v1/users/$id');
    return UserResponse.fromJson(response.data);
  }

  Future<List<UserResponse>> getUsers() async {
    var response = await dio.get('https://api.escuelajs.co/api/v1/users');
    final users = response.data as List;
    return users.map((e) => UserResponse.fromJson(e)).toList();
  }
}
