import '../../../model/index.dart';
import '../../../utils/extentions/index.dart';
import 'providers.dart';

class AppleAuth extends SocialAuthProvider {
  @override
  Future<AuthResult> login() {
    throw UnhandledException();
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
