part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState(
      {this.status = FormzSubmissionStatus.initial,
      this.name = const Name.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.isValid = false,
      this.selectedUser});

  final FormzSubmissionStatus status;
  final Name name;
  final Email email;
  final Password password;
  final bool isValid;
  final UserResponse? selectedUser;

  HomeState copyWith({
    FormzSubmissionStatus? status,
    Name? name,
    Email? email,
    Password? password,
    bool? isValid,
    UserResponse? selectedUser,
  }) {
    return HomeState(
        status: status ?? this.status,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        selectedUser: selectedUser ?? this.selectedUser);
  }

  @override
  List<Object> get props => [status, name, email, password];
}
