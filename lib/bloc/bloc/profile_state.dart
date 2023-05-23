part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> data;

  ProfileLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class ProfileLoading extends ProfileState {}
