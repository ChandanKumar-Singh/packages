import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fiddler_network_override/fiddler_network_override_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFiddlerNetworkOverride platform = MethodChannelFiddlerNetworkOverride();
  const MethodChannel channel = MethodChannel('fiddler_network_override');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
