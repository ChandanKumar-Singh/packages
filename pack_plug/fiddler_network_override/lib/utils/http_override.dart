part of '../fiddler_network_override.dart';

class FiddlerNetworkOverrideClass extends HttpOverrides {
  final String proxy;

  FiddlerNetworkOverrideClass(this.proxy);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    client.findProxy = (uri) {
      if (_isProxyReachable(proxy)) {
        return "PROXY $proxy";
      } else {
        debugPrint("[Fiddler] Proxy unreachable. Falling back to DIRECT.");
        return "DIRECT";
      }
    };

    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    return client;
  }

  bool _isProxyReachable(String proxy) {
    final parts = proxy.split(':');
    if (parts.length != 2) return false;
    final host = parts[0];
    final port = int.tryParse(parts[1]);
    if (host.isEmpty || port == null) return false;
    return true;
  }
}
