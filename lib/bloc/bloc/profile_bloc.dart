import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../service/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileUser profileUser;
  ProfileBloc(this.profileUser) : super(ProfileInitial()) {
    on<FetchProfileUser>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await profileUser.fetchProfileUser();
        emit(ProfileLoaded(profile));
      } catch (e) {}
    });
  }
}
