import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

void logg(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  log(message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name.toString(),
      zone: zone,
      error: error,
      stackTrace: stackTrace);
}

void printF(dynamic object) {
  if (kDebugMode) {
    if (kIsWeb) {
      logg(object.toString(), name: 'printF');
    } else {
      print(object);
    }
  }
}

void loggError(
  Object error, {
  int? count,
  StackTrace? stackTrace,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.e(error, stackTrace: stackTrace);
}

void loggInfo(
  Object message, {
  int? count,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.i(message);
}

void loggWarning(
  Object message, {
  int? count,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.w(message);
}

void loggDebug(
  Object message, {
  int? count,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.d(message);
}

void loggVerbose(
  Object message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
  int? count,
}) {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.v(message);
}

void loggWTF(
  Object message, {
  int? count,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.wtf(message);
}
