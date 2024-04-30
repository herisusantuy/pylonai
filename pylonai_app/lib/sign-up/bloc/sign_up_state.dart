part of 'sign_up_bloc.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Name name;
  final Email email;
  final Password password;
  final bool isValid;

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Name? name,
    Email? email,
    Password? password,
    bool? isValid,
  }) {
    return SignUpState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, name, email, password];
}
