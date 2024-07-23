import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import '/utils/extentions/index.dart';

StorageService storageService = StorageService();

class StorageService {
  static final StorageService _instance = StorageService._internal();
  static late SharedPreferences _prefs;

  factory StorageService() => _instance;

  static StorageService get instance => _instance;

  StorageService._internal() {
    init().then((_) => log('StorageService initialized from instance',
        name: 'StorageService'));
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic data) async {
    if (data is String) {
      await _prefs.setString(key, data);
    } else if (data is int) {
      await _prefs.setInt(key, data);
    } else if (data is bool) {
      await _prefs.setBool(key, data);
    } else if (data is double) {
      await _prefs.setDouble(key, data);
    } else if (data is List<String>) {
      await _prefs.setStringList(key, data);
    } else if (data is List<int>) {
      await _prefs.setStringList(key, data.map((e) => e.toString()).toList());
    } else if (data is List<bool>) {
      await _prefs.setStringList(key, data.map((e) => e.toString()).toList());
    } else if (data is List<double>) {
      await _prefs.setStringList(key, data.map((e) => e.toString()).toList());
    } else if (data is Map) {
      await _prefs.setString(key, jsonEncode(data));
    } else {
      throw UnhandledException('Invalid data type');
    }
  }

  static dynamic get(String key) => _prefs.get(key);

  static Future<void> remove(String key) async => await _prefs.remove(key);

  static bool containsKey(String key) => _prefs.containsKey(key);

  static String getString(String key, [String defaultValue = '']) =>
      _prefs.getString(key) ?? defaultValue;

  static int getInt(String key, [int defaultValue = 0]) =>
      _prefs.getInt(key) ?? defaultValue;

  static bool getBool(String key, [bool defaultValue = false]) =>
      _prefs.getBool(key) ?? defaultValue;

  static double getDouble(String key, [double defaultValue = 0.0]) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  static List<String> getStringList(String key,
          [List<String> defaultValue = const []]) =>
      _prefs.getStringList(key) ?? defaultValue;

  static List<int> getIntList(String key,
          [List<int> defaultValue = const []]) =>
      _prefs.getStringList(key)?.map((e) => int.tryParse(e) ?? 0).toList() ??
      defaultValue;

  static List<bool> getBoolList(String key,
          [List<bool> defaultValue = const []]) =>
      _prefs.getStringList(key)?.map((e) => e.toBool()).toList() ??
      defaultValue;

  static List<double> getDoubleList(String key,
          [List<double> defaultValue = const []]) =>
      _prefs
          .getStringList(key)
          ?.map((e) => double.tryParse(e) ?? 0.0)
          .toList() ??
      defaultValue;

  static Map<String, dynamic> getMap(String key,
          [Map<String, dynamic> defaultValue = const {}]) =>
      jsonDecode(_prefs.getString(key) ?? '{}') as Map<String, dynamic>;
}
