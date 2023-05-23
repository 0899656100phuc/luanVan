part of 'authen_bloc.dart';

abstract class AuthenState extends Equatable {}

class AuthenInitial extends AuthenState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class authSuccsess extends AuthenState {
  final bool login;
  authSuccsess(this.login);
  @override
  // TODO: implement props
  List<Object?> get props => [login];
}

class authenLoading extends AuthenState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class authFails extends AuthenState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class authError extends AuthenState {
  final String error;

  authError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
