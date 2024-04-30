import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pylonai_app/login/domain/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final dio = Dio();

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    var response = await dio.post(
      'https://api.escuelajs.co/api/v1/auth/login',
      data: jsonEncode(body),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (response.statusCode == 201) {
      _controller.add(AuthenticationStatus.authenticated);
      var data = LoginResponse.fromJson(response.data);
      await prefs.setString('accessToken', data.accessToken);
      await prefs.setString('refreshToken', data.refreshToken);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<Response> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    var avatar = 'https://picsum.photos/800';
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar
    };

    var response = await dio.post('https://api.escuelajs.co/api/v1/users/',
        data: jsonEncode(body),
        options: Options(
          headers: {'content-Type': 'application/json'},
        ));
    return response;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
