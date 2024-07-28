import 'package:tracker/core/helper/socket/socket_impl.dart';

class SocketManager extends SocketImpl {
  static SocketManager? _instance;
  static SocketManager get instance => _instance!;

  /// Factory constructor
  factory SocketManager(String url) {
    _instance ??= SocketManager._internal(url);
    return _instance!;
  }

  /// Private constructor
  SocketManager._internal(super.url);

  @override
  void dispose() {
    super.dispose();
    _instance = null;
  }
}
