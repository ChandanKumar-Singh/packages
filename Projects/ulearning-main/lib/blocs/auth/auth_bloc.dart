import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/providers/providers.dart';
import '/services/auth_service.dart';
import '/views/pages/index.dart';
import '../../repository/auth_repository.dart';
import '../../model/user_model.dart';
import '../../routes/index.dart';
import '../../utils/extentions/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();
  final AuthService authService = AuthService.instance;

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
      final res = await authRepository.login(event.provider,
          email: state.email, password: state.password);
      if (res.$1) {
        authService.saveAuthToLocal(res.$2, '');
      }
      emit(state.copyWith(
          status: res.$1 ? AuthStatus.success : AuthStatus.failure,
          user: res.$2,
          message: res.$3 ?? 'Login successful'));
      goTo(LandingPage.routeName);
    } on UnhandledException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onRegisterSubmitted(
      AuthRegisterSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final res = await authRepository.register(event.provider as EmailAuth,
          email: state.email, password: state.password);
      if (res.$1) {
        authService.saveAuthToLocal(res.$2, '');
      }
      emit(state.copyWith(
          status: res.$1 ? AuthStatus.success : AuthStatus.failure,
          user: res.$2,
          message: res.$3 ?? 'Registration successful'));
      goTo(LandingPage.routeName);
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onLogoutSubmitted(
      AuthLogoutSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final res = await authRepository.logout(event.provider);
      emit(state.copyWith(
          status: res.$1 ? AuthStatus.success : AuthStatus.failure,
          user: res.$2,
          message: res.$3 ?? 'You have been logged out'));
      goTo(LoginPage.routeName);
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

}
