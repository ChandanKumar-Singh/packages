import '/constants/index.dart';
import '/model/index.dart';
import '/services/firebase_profile_service.dart';
import '/utils/extentions/index.dart';
import '/utils/index.dart';

import 'storage.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  AuthUser? _authUser;
  AuthUser? get authUser => _authUser;

  String authorizationToken = '';
  void setAuthorizationToken(String token) => authorizationToken = token;

  AuthUser? setAuthUser(AuthUser? user) => _authUser = user;

  Future<void> loadAuthSetup() async {
    try {
      _authUser = AuthUser.fromMap(StorageService.getMap(Prefs.USER));
    } catch (e) {
      logg('loadAuthSetup: $e');
      _authUser = null;
    }
    logg('authUser: $_authUser');
    if (_authUser == null || _authUser!.uid.isNullOrEmpty) {
      clearAuthSetup();
      return;
    }
    FirebaseProfileService.getProfile(_authUser!.uid!)
        .then((value) => saveAuthToLocal(value, authorizationToken));
    authorizationToken = StorageService.getString(Prefs.TOKEN);
  }

  Future<void> saveAuthToLocal(AuthUser? user, String token) async {
    await StorageService.saveData(Prefs.USER, user?.toMap());
    await StorageService.saveData(Prefs.TOKEN, authorizationToken);
  }

  Future<void> clearAuthSetup() async {
    _authUser = null;
    authorizationToken = '';
    await StorageService.remove(Prefs.USER);
    await StorageService.remove(Prefs.TOKEN);
  }

  bool get isAuth => _authUser != null;
}
