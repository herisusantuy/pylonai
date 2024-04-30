import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pylonai_app/authentication/bloc/authentication_bloc.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Builder(
            builder: (context) {
              final users = context.select(
                (AuthenticationBloc bloc) => bloc.state.users,
              );
              return users!.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        itemCount: users.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            title: Text(
                                '${index + 1}. ${user.name.toCapitalized()}'),
                          );
                        },
                      ),
                    )
                  : const Text("No Users");
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size?>(
                          const Size(200.0, 50.0)),
                    ),
                    child: const Text('Download CSV'),
                    onPressed: () {
                      List<String> header = [];
                      header.add('No.');
                      header.add('Name');
                      header.add('Email');
                      header.add('Role');
                      List<List<String>> listOfLists = [];
                      final users = state.users ?? [];
                      for (final (index, user) in users.indexed) {
                        listOfLists.add([
                          (index + 1).toString(),
                          user.name.toCapitalized(),
                          user.email,
                          user.role
                        ]);
                      }
                      exportCSV.myCSV(header, listOfLists);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
