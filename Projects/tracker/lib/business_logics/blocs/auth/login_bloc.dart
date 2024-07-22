import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/presentation/routes/index.dart';

import '../../../data/repositories/auth/auth_repo.dart';
import '../../../data/repositories/auth/social/social_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<EmailLoginEvent>(_handleLogin);
    on<SocialLoginEvent>(_handleLogin);
  }

  void _handleLogin(LoginEvent event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    var res = await AuthRepo.instance.login(
      event is SocialLoginEvent ? event.socialAuth : null,
      email: state.email,
      password: state.password,
    );
    if (res) {
      emit(const LoginSuccess());
      routeTo(Routes.home, replace: true);
      2000.delay.then((_) => redirectTo());
    } else {
      emit(const LoginFailure(error: 'Login failed'));
    }
  }
}
