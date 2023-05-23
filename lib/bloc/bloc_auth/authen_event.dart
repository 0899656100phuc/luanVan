part of 'authen_bloc.dart';

abstract class AuthenEvent extends Equatable {
  const AuthenEvent();

  @override
  List<Object> get props => [];
}

class authFetchEvent extends AuthenEvent {}
