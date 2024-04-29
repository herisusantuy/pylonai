import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pylonai_app/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Text('List of Employee'),
              Builder(
                builder: (context) {
                  final users = context.select(
                    (AuthenticationBloc bloc) => bloc.state.users,
                  );
                  return users!.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            itemCount: users.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return ListTile(
                                title: Text('${index + 1}. ${user.name}'),
                              );
                            },
                          ),
                        )
                      : const Text("No Users");
                },
              ),
              ElevatedButton(
                child: const Text('Download CSV'),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
