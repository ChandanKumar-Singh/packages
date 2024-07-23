import 'package:equatable/equatable.dart';
import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/presentation/routes/index.dart';

import '../../../data/models/index.dart';
import '../../../data/repositories/auth/auth_repo.dart';
import 'provider/provider.dart';
export 'provider/provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<AuthLogoutSubmitted>(_onLogoutSubmitted);
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email, status: AuthStatus.initial));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password, status: AuthStatus.initial));
  }

  Future<void> _onLoginSubmitted(
      AuthLoginSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final res = await AuthRepo.instance
          .login(event.provider, email: state.email, password: state.password);
      emit(state.copyWith(
          status: res.success ? AuthStatus.success : AuthStatus.failure,
          user: res.user,
          message: res.message));
      routeTo(Routes.home, replace: true);
      2000.delay.then((_) => redirectTo());
    } on UnKnonwException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onRegisterSubmitted(
      AuthRegisterSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      // final res = await AuthRepo.instance.register(event.provider as EmailAuth,
      //     email: state.email, password: state.password);
      // if (res.success) {
      //   authService.saveAuthToLocal(res.user, '');
      // }
      // emit(state.copyWith(
      //     status: res.success ? AuthStatus.success : AuthStatus.failure,
      //     user: res.user,
      //     message: res.message ?? 'Registration successful'));
      // goTo(LandingPage.routeName);
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onLogoutSubmitted(
      AuthLogoutSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final res = await AuthRepo.instance.logOut(event.provider);
      emit(state.copyWith(
          status: res.success ? AuthStatus.success : AuthStatus.failure,
          user: res.user,
          message: res.message));
      routeTo(Routes.login, replace: true);
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  // void _handleLogin(AuthEvent event, Emitter<AuthState> emit) async {
  //   emit(const LoginLoading());
  //   var res = await AuthRepo.instance.login(
  //     event is SocialLoginEvent ? event.socialAuth : null,
  //     email: state.email,
  //     password: state.password,
  //   );
  //   if (res) {
  //     emit(const LoginSuccess());
  //     routeTo(Routes.home, replace: true);
  //     2000.delay.then((_) => redirectTo());
  //   } else {
  //     emit(const LoginFailure(error: 'Login failed'));
  //   }
  // }
}
