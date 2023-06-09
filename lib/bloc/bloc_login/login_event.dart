part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed(this.username, this.password);

  @override
  String toString() =>
      'LoginButtonPressed(username: $username, password: $password)';
  @override
  List<Object> get props => [username, password];
}
