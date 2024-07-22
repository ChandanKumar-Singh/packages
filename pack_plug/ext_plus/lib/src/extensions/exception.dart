import 'package:ext_plus/ext_plus.dart';

class UnKnonwException implements Exception {
  final String message;
  StackTrace? stackTrace;

  @pragma("vm:entry-point")
  UnKnonwException([this.message = 'Unknown exception', this.stackTrace]) {
    stackTrace ??= StackTrace.current;
  }

  @override
  String toString() {
    return '$runtimeType: $message \n$stackTrace';
  }
}

T? tryCatch<T>(T Function() function, {T? defaultValue, bool log = true}) {
  try {
    return function();
  } catch (e, stackTrace) {
    if (log) logg(e.toString(), stackTrace: stackTrace);
    return defaultValue;
  }
}

Future<T?> tryCatchAsync<T>(Future<T> Function() function,
    {T? defaultValue, bool log = true}) async {
  try {
    return await function();
  } catch (e, stackTrace) {
    if (log) logg(e.toString(), stackTrace: stackTrace);
    return defaultValue;
  }
}
