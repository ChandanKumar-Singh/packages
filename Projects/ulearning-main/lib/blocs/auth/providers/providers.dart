import '../../../model/index.dart';
import '../../../utils/index.dart';
export 'email.dart';
export 'facebook.dart';
export 'apple.dart';
export 'google.dart';

abstract class AuthProviderInterface {
  String get providerName;

  Future<AuthResult> login();

  Future<AuthResult> loggout();

  Future<AuthResult> forgotPassword();

  Future<AuthResult> changePassword();
}

abstract class SocialAuthProvider extends AuthProviderInterface {
  @override
  Future<AuthResult> login();

  @override
  Future<AuthResult> loggout();

  @override
  Future<AuthResult> forgotPassword();

  @override
  Future<AuthResult> changePassword();
}

mixin SocialAuthLoggging on AuthProviderInterface {
  @override
  Future<AuthResult> login() async {
    logg('Starting loggin process', name: runtimeType);
    final result = await super.login();
    logg('Loggin process completed', name: runtimeType);
    return result;
  }

  @override
  Future<AuthResult> loggout() async {
    logg('Starting loggout process', name: runtimeType);
    final result = await super.loggout();
    logg('Loggout process completed', name: runtimeType);
    return result;
  }

  @override
  Future<AuthResult> forgotPassword() async {
    logg('Starting forgotPassword process', name: runtimeType);
    final result = await super.forgotPassword();
    logg('ForgotPassword process completed', name: runtimeType);
    return result;
  }

  @override
  Future<AuthResult> changePassword() async {
    logg('Starting changePassword process', name: runtimeType);
    final result = await super.changePassword();
    logg('ChangePassword process completed', name: runtimeType);
    return result;
  }
}
