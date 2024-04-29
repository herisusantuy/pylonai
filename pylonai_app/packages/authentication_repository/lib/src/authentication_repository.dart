import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:pylonai_app/login/domain/login_response.dart';

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
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    var name = username;
    var avatar = 'https://picsum.photos/800';
    print(username);
    print(email);
    print(password);
    var response = await dio.post('https://api.escuelajs.co/api/v1/users/',
        data: {name: name, email: email, password: password, avatar: avatar},
        options: Options(
          headers: {'content-Type': 'application/json'},
        ));
    print(response.data);
    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
