import 'channel_1_platform_interface.dart';
export 'src/MyTimer.dart';

class Channel_1 {
  Future<String?> getPlatformVersion() {
    return Channel_1Platform.instance.getPlatformVersion();
  }
}
