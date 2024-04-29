import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      this.id, this.email, this.password, this.name, this.avatar, this.role);

  final int id;
  final String email;
  final String password;
  final String name;
  final String avatar;
  final String role;

  @override
  List<Object> get props => [id, email, password, name, avatar, role];

  static const user = User(24, "john.doe@gmail.com", "23433", "John Doe",
      'https://i.imgur.com/yhW6Yw1.jpg', 'customer');
}
