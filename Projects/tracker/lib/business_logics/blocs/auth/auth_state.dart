part of 'auth_bloc.dart';

// @immutable
// abstract class AuthState {
//   final String email;
//   final String password;

//   const AuthState({
//     this.email = '',
//     this.password = '',
//   });

//   AuthState copyWith({
//     String? email,
//     String? password,
//   });
// }

/*
class LoginInitial extends AuthState {
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

class LoginLoading extends AuthState {
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

class LoginSuccess extends AuthState {
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

class LoginFailure extends AuthState {
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

*/
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
