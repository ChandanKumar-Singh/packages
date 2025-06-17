part of '../fiddler_network_override.dart';

class FiddlerConfigManager {
  static const String _configPath =
      '/storage/emulated/0/root/fiddler/config.json';

  /// Attempts to read proxy config from the file.
  static Future<String?> getProxyFromConfig() async {
    try {
      final file = File(_configPath);
      if (!await file.exists()) {
        if (kDebugMode)
          print("FiddlerConfigManager file not found: $_configPath");
        return null;
      }

      final content = await file.readAsString();
      final Map<String, dynamic> jsonData = json.decode(content);
      print("FiddlerConfigManager jsonData: $jsonData");

      if (jsonData.containsKey('proxy')) {
        return jsonData['proxy'] as String;
      }
    } catch (e) {
      print("FiddlerConfigManager error: $e");
    }
    return null;
  }

  /// Attempts to read proxy from SharedPreferences
  static Future<String?> getProxyFromSharedPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final proxy = prefs.getString(_fiddlerProxyKey);
      if (proxy == null || proxy.isEmpty) return null;
      if (kDebugMode) {
        print("FiddlerConfigManager shared prefs: $proxy");
      }
      return proxy;
    } catch (e) {
      print("FiddlerConfigManager shared prefs error: $e");
      return null;
    }
  }
}
