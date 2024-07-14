import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'channel_1_platform_interface.dart';

/// An implementation of [Channel_1Platform] that uses method channels.
class MethodChannelChannel_1 extends Channel_1Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('channel_1');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
