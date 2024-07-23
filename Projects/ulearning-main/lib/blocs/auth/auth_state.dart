part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

@immutable
class AuthState extends Equatable {
  final AuthStatus status;
  final String email;
  final String password;
  final AuthUser? user;
  final String? message;

  const AuthState({
    this.status = AuthStatus.initial,
    this.email = '',
    this.password = '',
    this.user,
    this.message,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? email,
    String? password,
    AuthUser? user,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, email, password, user, message];
}
