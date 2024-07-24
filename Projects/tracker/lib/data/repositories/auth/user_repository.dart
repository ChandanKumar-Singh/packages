import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/foundation.dart';
import '/core/index.dart';
import '/data/services/database/firebase_database.dart';

import '../../models/index.dart';

sealed class UserRepositoryImpl {
  Future<AuthUser?> getCurrentUser();
  Future<AuthUser?> refreshCurrentUser();
  Future<void> setCurrentUser(AuthUser user, {bool remote = false});
  Future<void> removeCurrentUser();
  bool isUserLoggedIn();
  String getAuthToken();
  Future<void> setAuthToken(String token);
  Future<void> removeAuthToken();
}

class UserRepository extends ChangeNotifier implements UserRepositoryImpl {
  AuthUser? _currentUser;
  AuthUser? get currentUser => _currentUser;
  UserRepository._();
  static final UserRepository instance = UserRepository._();

  @override
  String getAuthToken() {
    return getStringAsync(StorageConstants.authToken);
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    _currentUser = tryCatch<AuthUser?>(
        () => AuthUser.fromJson(SpHelper.instance.getUser().validate()));
    notifyListeners();
    return _currentUser;
  }

  @override
  Future<AuthUser?> refreshCurrentUser() async {
    await tryCatchAsync(() async {
      String id = getAuthToken();
      if (id.isEmpty) return null;
      logg('refreshCurrentUser $id', name: runtimeType);
      AuthUser? user = await FirebaseDb().getUserData(id);
      if (user != null) await setCurrentUser(user, remote: true);
    });
    await getCurrentUser();
    return _currentUser;
  }

  @override
  bool isUserLoggedIn() {
    bool res = getBoolAsync(StorageConstants.isLogin, defaultValue: false) &&
        getAuthToken().isNotEmpty;
    if (res && _currentUser == null) getCurrentUser();
    return res;
  }

  @override
  Future<void> removeAuthToken() async {
    removeKey(StorageConstants.authToken);
  }

  @override
  Future<void> removeCurrentUser() async {
    removeKey(StorageConstants.user);
    removeKey(StorageConstants.authToken);
  }

  @override
  Future<void> setAuthToken(String token) async {
    await setValue(StorageConstants.authToken, token);
  }

  @override
  Future<void> setCurrentUser(AuthUser user, {bool remote = false}) async {
    if (!remote) {
      await FirebaseDb().setUserData(user.uid.validate(), user.toJson());
    }
    await Future.wait([
      SpHelper.instance.saveUser(user.toJson()),
      setAuthToken(user.uid.validate()),
      setValue(StorageConstants.isLogin, true),
    ]);
    _currentUser = user;
    notifyListeners();
  }
}
