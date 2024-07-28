import 'package:ext_plus/ext_plus.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'dart:async';

abstract class SocketImpl {
  socket_io.Socket? _socket;
  String _serverUrl = 'http://your-server-url';
  final Duration _reconnectDelay = const Duration(seconds: 5);

  /// Private constructor
  SocketImpl(String url) {
    _serverUrl = url;
    _initializeSocket();
  }

  void _initializeSocket() {
    _socket = socket_io.io(
        _serverUrl,
        socket_io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Node.js
            .enableForceNew()
            .setReconnectionAttempts(5)
            .build());

    _socket!.on('connect', (_) {
      printF('Socket connected');
    });

    _socket!.on('disconnect', (_) {
      printF('Socket disconnected');
      _attemptReconnect();
    });

    _socket!.on('connect_error', (error) {
      printF('Socket connection error: $error');
      _attemptReconnect();
    });

    _socket!.on('error', (error) {
      printF('Socket error: $error');
    });

    _socket!.on('reconnect', (_) {
      printF('Socket reconnected');
    });
  }

  void _attemptReconnect() {
    Future.delayed(_reconnectDelay, () {
      if (_socket != null && !_socket!.connected) {
        _socket!.connect();
      }
    });
  }

  void emit(String event, [dynamic data]) {
    _socket?.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void off(String event) {
    _socket?.off(event);
  }

  void dispose() {
    _socket?.disconnect();
    _socket = null;
  }
}
