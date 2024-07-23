import 'package:ext_plus/ext_plus.dart';
import '/data/models/index.dart';
import '../../../business_logics/blocs/index.dart';
import 'index.dart';

class AuthRepo {
  AuthRepo._();
  static final AuthRepo instance = AuthRepo._();

  Future<AuthResult> login(AuthProviderInterface provider,
      {String? email, String? password}) async {
    bool isSuccess = false;
    AuthUser? user;
    String? message;
    try {
      AuthResult result = await provider.login();
      logg('$provider Login started', name: runtimeType);
      // final result = provider is SocialAuthProvider
      //     ? await loginWithSocialAuth(provider)
      //     : await loginWithCredentials(email!, password!);
      // user = AuthUser()
      //   ..email = result.user?.email
      //   ..name = result.user?.name
      //   ..uid = result.user?.uid
      //   ..primaryId = result.user?.uid
      //   ..photoUrl = result.user?.photoUrl
      //   ..phoneNumber = result.user?.phoneNumber
      //   ..authProviderName = result.user?.authProviderName;
      message = result.message;
      if (result.success && result.user != null) {
        await UserRepository.instance.setCurrentUser(result.user!);
        successToast(message ?? 'Login success');
        isSuccess = true;
      } else {
        errorToast(message ?? 'Login failed');
      }
    } catch (e, st) {
      String? message;
      if (e is BaseException) {
        message = e.message;
      }
      logg('Login failed', name: runtimeType, error: e, stackTrace: st);
      errorToast(message ?? 'Login faileds');
    } finally {}
    return AuthResult(isSuccess, message.validate(), user);
  }

  Future<AuthResult> register(EmailAuth provider,
      {String? email, String? password}) async {
    AuthResult result = await provider.login();
    // if (result.success) {
    //   await FirebaseProfileService.createProfile(
    //       result.user!.uid.validate(), result.user!.toMap());
    // }
    return result;
  }

  Future<AuthResult> logOut(AuthProviderInterface provider) async {
    AuthResult result = await provider.loggout();
    await UserRepository.instance.removeCurrentUser();
    return result;
  }
}
