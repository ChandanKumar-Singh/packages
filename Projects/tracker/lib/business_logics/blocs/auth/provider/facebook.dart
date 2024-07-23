part of 'provider.dart';

class FacebookAuth extends SocialAuthProvider {
  @override
  Future<AuthResult> login() {
    throw UnKnonwException();
  }

  @override
  Future<AuthResult> changePassword() {
    throw UnimplementedError();
  }

  @override
  Future<AuthResult> forgotPassword() {
    throw UnimplementedError();
  }

  @override
  Future<AuthResult> loggout() {
    throw UnimplementedError();
  }

  @override
  String get providerName => throw UnimplementedError();
}
