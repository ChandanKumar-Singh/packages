import 'dart:convert';

import 'package:ext_plus/ext_plus.dart';

class SpHelper {
  /// [prefs] is the instance of SharedPreferences
  SharedPreferences? prefs;
  SpHelper._privateConstructor() {
    logg('from constructor', name: runtimeType);
  }

  /// `instance` is the single instance of this class
  static final SpHelper instance = SpHelper._privateConstructor();
  factory SpHelper() => instance;

  /// `init` is used to initialize the SharedPreferences
  Future<void> init() async {
    logg('from init', name: runtimeType);
    if (prefs != null) return;
    await getSharedPref()
        .then((v) => prefs = v)
        .then((_) => logg('Initialized 🫙', name: runtimeType));
  }

  /// `saveUser` is used to save the user data
  Future<void> saveUser(Map<String, dynamic> data) async {
    await setValue(StorageConstants.user, data);
  }

  /// `getUser` is used to get the user data
  Map<String, dynamic>? getUser() {
    var data = getStringAsync(StorageConstants.user, defaultValue: '{}');
    logg('getUser: $data', name: runtimeType);
    return jsonDecode(data) as Map<String, dynamic>?;
  }

  /// navigation
  void setRedirection(String path) =>
      setValue(StorageConstants.redirectTo, path);
  String getRedirection() => getStringAsync(StorageConstants.redirectTo);
}

class StorageConstants {
  static const String user = 'user';
  static const String isLogin = 'isLogin';
  static const String authToken = 'authToken';

  static const String redirectTo = 'redirectTO';
}
