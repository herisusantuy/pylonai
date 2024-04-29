part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.user, this.users});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(List<UserResponse> users)
      : this._(status: AuthenticationStatus.authenticated, users: users);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserResponse? user;
  final List<UserResponse>? users;

  @override
  List<Object> get props => [status];
}
