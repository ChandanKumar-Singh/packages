import 'package:flutter_test/flutter_test.dart';
import 'package:fiddler_network_override/fiddler_network_override.dart';
import 'package:fiddler_network_override/fiddler_network_override_platform_interface.dart';
import 'package:fiddler_network_override/fiddler_network_override_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFiddlerNetworkOverridePlatform
    with MockPlatformInterfaceMixin
    implements FiddlerNetworkOverridePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FiddlerNetworkOverridePlatform initialPlatform = FiddlerNetworkOverridePlatform.instance;

  test('$MethodChannelFiddlerNetworkOverride is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFiddlerNetworkOverride>());
  });

  test('getPlatformVersion', () async {
    FiddlerNetworkOverride fiddlerNetworkOverridePlugin = FiddlerNetworkOverride.instance;
    MockFiddlerNetworkOverridePlatform fakePlatform = MockFiddlerNetworkOverridePlatform();
    FiddlerNetworkOverridePlatform.instance = fakePlatform;

    expect(await fiddlerNetworkOverridePlugin.getPlatformVersion(), '42');
  });
}
