import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fiddler_network_override_method_channel.dart';

abstract class FiddlerNetworkOverridePlatform extends PlatformInterface {
  /// Constructs a FiddlerNetworkOverridePlatform.
  FiddlerNetworkOverridePlatform() : super(token: _token);

  static final Object _token = Object();

  static FiddlerNetworkOverridePlatform _instance = MethodChannelFiddlerNetworkOverride();

  /// The default instance of [FiddlerNetworkOverridePlatform] to use.
  ///
  /// Defaults to [MethodChannelFiddlerNetworkOverride].
  static FiddlerNetworkOverridePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FiddlerNetworkOverridePlatform] when
  /// they register themselves.
  static set instance(FiddlerNetworkOverridePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
