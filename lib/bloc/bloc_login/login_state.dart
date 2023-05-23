part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  String token;
  LoginSuccess({
    required this.token,
  });
}

class LoginFaild extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);

  @override
  String toString() => 'LoginFailure(error: $error)';
  @override
  List<Object> get props => [error];
}
