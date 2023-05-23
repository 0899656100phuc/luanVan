import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../service/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthService authService;
  LoginBloc(this.authService) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await authService.login(event.username, event.password);
        if (token != null) {
          emit(LoginSuccess(token: token));
        } else {
          print('đang nhập thất bại');
          emit(LoginFaild());
        }
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
