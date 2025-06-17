import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fiddler_network_override_platform_interface.dart';

/// An implementation of [FiddlerNetworkOverridePlatform] that uses method channels.
class MethodChannelFiddlerNetworkOverride extends FiddlerNetworkOverridePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fiddler_network_override');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
