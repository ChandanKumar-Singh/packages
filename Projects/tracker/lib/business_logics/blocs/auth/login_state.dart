part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  final String email;
  final String password;

  const LoginState({
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    String? email,
    String? password,
  });
}

class LoginInitial extends LoginState {
  const LoginInitial({
    super.email,
    super.password,
  });

  @override
  LoginInitial copyWith({
    String? email,
    String? password,
  }) {
    return LoginInitial(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginLoading extends LoginState {
  const LoginLoading({
    super.email,
    super.password,
  });

  @override
  LoginLoading copyWith({
    String? email,
    String? password,
  }) {
    return LoginLoading(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginSuccess extends LoginState {
  const LoginSuccess({
    super.email,
    super.password,
  });

  @override
  LoginSuccess copyWith({
    String? email,
    String? password,
  }) {
    return LoginSuccess(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({
    required this.error,
    super.email,
    super.password,
  });

  @override
  LoginFailure copyWith({
    String? email,
    String? password,
    String? error,
  }) {
    return LoginFailure(
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
