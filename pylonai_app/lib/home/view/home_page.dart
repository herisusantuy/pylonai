import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pylonai_app/authentication/bloc/authentication_bloc.dart';
import 'package:pylonai_app/home/view/home_body.dart';
import 'package:user_repository/user_repository.dart';

import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: const Text(
            'List of Employee',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: BlocProvider(
          create: (context) => HomeBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context)),
          child: const HomeBody(),
        ),
      ),
    );
  }
}
