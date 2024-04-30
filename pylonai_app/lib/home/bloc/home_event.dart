part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeNameChanged extends HomeEvent {
  const HomeNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class HomeEmailChanged extends HomeEvent {
  const HomeEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class HomePasswordChanged extends HomeEvent {
  const HomePasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class HomeSelectedUserChanged extends HomeEvent {
  const HomeSelectedUserChanged(this.selectedUser);

  final UserResponse selectedUser;

  @override
  List<Object> get props => [selectedUser];
}

final class HomeSubmitted extends HomeEvent {
  const HomeSubmitted();
}
