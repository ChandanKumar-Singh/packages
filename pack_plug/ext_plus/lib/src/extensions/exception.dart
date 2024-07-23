import 'package:ext_plus/ext_plus.dart';

abstract class BaseException implements Exception {
  final String message;
  StackTrace? stackTrace;

  BaseException([this.message = 'Unknown exception', this.stackTrace]) {
    stackTrace ??= StackTrace.current;
  }

  @override
  String toString() {
    return '$runtimeType: $message \n$stackTrace';
  }
}

class UnKnonwException implements BaseException {
  @override
  final String message;
  @override
  StackTrace? stackTrace;

  UnKnonwException([this.message = 'Unknown exception', this.stackTrace]);
}

class UnhandledException implements BaseException {
  @override
  final String message;
  @override
  StackTrace? stackTrace;

  UnhandledException([this.message = 'Not implemented', this.stackTrace]);
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
    if (log) loggError(e.toString(), stackTrace: stackTrace);
    return defaultValue;
  }
}
