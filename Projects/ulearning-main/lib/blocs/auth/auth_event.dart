part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthEmailChanged extends AuthEvent {
  final String email;

  const AuthEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  const AuthPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class AuthLoginSubmitted extends AuthEvent {
  final AuthProviderInterface provider;

  const AuthLoginSubmitted(this.provider);

  @override
  List<Object?> get props => [provider];
}

class AuthRegisterSubmitted extends AuthEvent {
  final AuthProviderInterface provider;

  const AuthRegisterSubmitted(this.provider);

  @override
  List<Object?> get props => [provider];
}

class AuthLogoutSubmitted extends AuthEvent {
  final AuthProviderInterface provider;

  const AuthLogoutSubmitted(this.provider);

  @override
  List<Object?> get props => [provider];
}
