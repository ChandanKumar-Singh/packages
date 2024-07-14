import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'channel_1_method_channel.dart';

abstract class Channel_1Platform extends PlatformInterface {
  /// Constructs a Channel_1Platform.
  Channel_1Platform() : super(token: _token);

  static final Object _token = Object();

  static Channel_1Platform _instance = MethodChannelChannel_1();

  /// The default instance of [Channel_1Platform] to use.
  ///
  /// Defaults to [MethodChannelChannel_1].
  static Channel_1Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Channel_1Platform] when
  /// they register themselves.
  static set instance(Channel_1Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
