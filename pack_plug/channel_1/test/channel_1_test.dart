import 'package:flutter_test/flutter_test.dart';
import 'package:channel_1/channel_1.dart';
import 'package:channel_1/channel_1_platform_interface.dart';
import 'package:channel_1/channel_1_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockChannel_1Platform
    with MockPlatformInterfaceMixin
    implements Channel_1Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Channel_1Platform initialPlatform = Channel_1Platform.instance;

  test('$MethodChannelChannel_1 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelChannel_1>());
  });

  test('getPlatformVersion', () async {
    Channel_1 channel_1Plugin = Channel_1();
    MockChannel_1Platform fakePlatform = MockChannel_1Platform();
    Channel_1Platform.instance = fakePlatform;

    expect(await channel_1Plugin.getPlatformVersion(), '42');
  });
}
