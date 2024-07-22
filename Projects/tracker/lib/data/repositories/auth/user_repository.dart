import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:tracker/core/index.dart';

import '../../models/index.dart';

sealed class UserRepositoryImpl {
  Future<AppUser?> getCurrentUser();
  Future<void> setCurrentUser(AppUser user, {bool remote = false});
  Future<void> removeCurrentUser();
  bool isUserLoggedIn();
  String getAuthToken();
  Future<void> setAuthToken(String token);
  Future<void> removeAuthToken();
}

class UserRepository extends ChangeNotifier implements UserRepositoryImpl {
  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  UserRepository._();
  static final UserRepository instance = UserRepository._();

  @override
  String getAuthToken() {
    return getStringAsync(StorageConstants.authToken);
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    _currentUser = tryCatch<AppUser?>(
        () => AppUser.fromJson(SpHelper.instance.getUser().validate()));
    notifyListeners();
    return _currentUser;
  }

  @override
  bool isUserLoggedIn() {
    return getBoolAsync(StorageConstants.isLogin, defaultValue: false) &&
        SpHelper.instance.getUser().validate().isNotEmpty;
  }

  @override
  Future<void> removeAuthToken() async {
    removeKey(StorageConstants.authToken);
  }

  @override
  Future<void> removeCurrentUser() async {
    removeKey(StorageConstants.user);
  }

  @override
  Future<void> setAuthToken(String token) async {
    await setValue(StorageConstants.authToken, token);
  }

  @override
  Future<void> setCurrentUser(AppUser user, {bool remote = false}) async {
    await Future.wait([
      SpHelper.instance.saveUser(user.toJson()),
      setAuthToken(user.token.validate()),
      setValue(StorageConstants.isLogin, true),
    ]);
    _currentUser = user;
    notifyListeners();
  }
}
