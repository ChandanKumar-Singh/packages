import 'dart:async';
import 'dart:developer';

import '/utils/index.dart';

class Logging {
  Logging._();

  static final Logging instance = Logging._();
}

void logg(
  String? message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  log(message ?? '',
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name.toString(),
      zone: zone,
      error: error,
      stackTrace: stackTrace);
}
