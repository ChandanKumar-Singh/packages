import '../../../model/index.dart';
import '../../../utils/extentions/index.dart';
import 'providers.dart';

class FacebookAuth extends SocialAuthProvider {
  @override
  Future<AuthResult> login() {
    throw UnhandledException('Not implemented');
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
  // TODO: implement providerName
  String get providerName => throw UnimplementedError();
}
