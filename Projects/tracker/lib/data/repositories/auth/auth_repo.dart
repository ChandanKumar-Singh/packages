import 'package:ext_plus/ext_plus.dart';
import 'package:tracker/data/models/index.dart';
import 'index.dart';

class AuthRepo {
  AuthRepo._();
  static final AuthRepo instance = AuthRepo._();

  Future<AuthResult> loginWithSocialAuth(SocialAuth socialAuth) async {
    await socialAuth.loggout();
    AuthResult result = await socialAuth.login();
    logg(result.toString(), name: runtimeType);
    return result;
  }

  Future<AuthResult> loginWithCredentials(String email, String password) async {
    AuthResult result = await EmailAuth(email, password).login();
    logg(result.toString(), name: runtimeType);
    return result;
  }

  Future<bool> login(dynamic type, {String? email, String? password}) async {
    bool isSuccess = false;
    AppUser? user;
    String? message;
    try {
      logg('$type Login started', name: runtimeType);
      final result = type is SocialAuth
          ? await loginWithSocialAuth(type)
          : await loginWithCredentials(email!, password!);
      user = AppUser()
        ..email = result.user?.email
        ..name = result.user?.name
        ..id = result.user?.uid
        ..token = result.user?.uid
        ..photoUrl = result.user?.photoUrl
        ..phoneNumber = result.user?.phoneNumber
        ..authProviderName = result.user?.authProviderName;

      isSuccess = result.success;
      message = result.message;
      if (isSuccess) {
        successToast(message);
        await UserRepository.instance.setCurrentUser(user);
      } else {
        isSuccess = false;
        errorToast(message);
      }
    } catch (e, st) {
      isSuccess = false;
      logg('Login failed', name: runtimeType, error: e, stackTrace: st);
      errorToast(message ?? 'Login failed');
    } finally {}
    return isSuccess;
  }

  Future<bool> logOut() async {
    return await UserRepository.instance.getCurrentUser().then((user) async {
      if (user == null) {
        warningToast('You are not logged in');
        return false;
      }
      switch (user.authProviderName) {
        case 'google':
          await GoogleAuth().loggout();
          break;
        case 'email':
          await EmailAuth(user.email!, user.token!).loggout();
          break;
        default:
          break;
      }
      await UserRepository.instance.removeCurrentUser();
      successToast('Logged out successfully');
      return true;
    });
  }
}
