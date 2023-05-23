import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../service/auth_service.dart';

part 'authen_event.dart';
part 'authen_state.dart';

class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  AuthService authService;
  AuthenBloc(this.authService) : super(AuthenInitial()) {
    on<authFetchEvent>((event, emit) async {
      emit(authenLoading());
      try {
        final isLogin = await authService.isLoggedIn();
        if (isLogin) {
          emit(authSuccsess(isLogin));
        } else {
          emit(authFails());
        }
      } catch (e) {
        emit(authError(e.toString()));
      }
    });
  }
}
