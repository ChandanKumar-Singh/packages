import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fiddler_network_override_platform_interface.dart';

part 'utils/fiddler_config_manager.dart';
part 'ui/proxy_input_sheet.dart';
part 'utils/http_override.dart';

const String _fiddlerProxyKey = 'fiddler_proxy';
const String _fiddlerEnableKey = 'fiddler_enabled';

class FiddlerNetworkOverride {
  static FiddlerNetworkOverride? _instance;

  static FiddlerNetworkOverride get instance {
    _instance ??= FiddlerNetworkOverride._();
    return _instance!;
  }

  FiddlerNetworkOverride._();

  Future<String?> getPlatformVersion() {
    return FiddlerNetworkOverridePlatform.instance.getPlatformVersion();
  }

  Future<bool> isProxyEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_fiddlerEnableKey) ?? false;
  }

  Future<void> enableFiddlerIfConfigured() async {
    final isEnabled = await isProxyEnabled();
    print("Fiddler isProxyEnabled: $isEnabled");
    if (!isEnabled) return;
    final proxy = await FiddlerConfigManager.getProxyFromSharedPrefs();
    if (proxy != null && proxy.isNotEmpty) {
      HttpOverrides.global = FiddlerNetworkOverrideClass(proxy);
      print("Fiddler proxy enabled: $proxy");
    } else {
      print("Fiddler config not found or invalid. Skipping proxy setup.");
    }
  }

  void showProxyInputSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ProxyInputSheet(),
    );
  }
}
