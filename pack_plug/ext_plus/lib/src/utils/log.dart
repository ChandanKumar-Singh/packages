import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

const String _tagColor = '\x1B[30m';
const String _errorColor = '\x1B[31m';
const String _warningColor = '\x1B[33m';
const String _debugColor = '\x1B[34m';
const String _verboseColor = '\x1B[35m';
const String _wtfColor = '\x1B[36m';
const String _whiteColor = '\x1B[37m';
const String _resetColor = '\x1B[0m';
const String _cyanColor = '\x1B[36m';

const String arrowDown = '⤵';
const String arrowUp = '⤴';

void logg(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name,
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  log(message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name == null ? '' : name.toString(),
      zone: zone,
      error: error,
      stackTrace: stackTrace);
}

void printF(dynamic object, {dynamic name}) {
  if (!kDebugMode) return;
  if (kIsWeb) {
    printLongData(object.toString(), tag: name.toString());
  } else {
    printLongData(object, tag: name.toString());
  }
}

void printLongData(String data, {int chunkSize = 5000, String? tag}) {
  if (tag != null) print('[$_tagColor$tag$_resetColor] --- $arrowDown');
  // Calculate the number of chunks needed
  int numChunks = (data.length / chunkSize).ceil();

  for (int i = 0; i < numChunks; i++) {
    // Calculate the start and end indices for each chunk
    int start = i * chunkSize;
    int end = start + chunkSize;

    // Make sure the end index doesn't exceed the data length
    if (end > data.length) {
      end = data.length;
    }

    // Print each chunk
    /// apply white color to the data
    print('$_whiteColor${data.substring(start, end)}$_resetColor');
  }
  print('--- $arrowUp ');
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
  if (!kDebugMode) return;
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.e(error, stackTrace: stackTrace);
}

void loggInfo(
  Object message, {
  int? count = 0,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  if (!kDebugMode) return;
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.i(message);
}

void loggWarning(
  Object message, {
  int? count = 0,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  if (!kDebugMode) return;
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.w(message);
}

void loggDebug(
  Object message, {
  int count = 0,
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  dynamic name = '',
  Zone? zone,
}) {
  if (!kDebugMode) return;
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
  if (!kDebugMode) return;
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
  if (!kDebugMode) return;
  Logger logger = Logger(printer: PrettyPrinter(methodCount: count));
  logger.wtf(message);
}
