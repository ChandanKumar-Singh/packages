import 'dart:math';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../ext_plus.dart';

class MyDateUtils {
  static Duration? durationDifference(String? start, String? end) {
    if (start == null || end == null) {
      return null;
    }
    final startDate = DateTime.tryParse(start);
    final endDate = DateTime.tryParse(end);
    if (startDate == null || endDate == null) {
      return null;
    }
    return endDate.difference(startDate);
  }

  static DateTime todayDate = DateTime.now();

  static bool isTodayAfterDate(DateTime val) => val.isAfter(todayDate);

  static String formatDateAsToday(dynamic dt,
      {String? format, bool getToday = false, String defaultValue = '---'}) {
    DateTime? dateTime = dt is DateTime ? dt : DateTime.tryParse(dt ?? '');
    if (dateTime == null) return defaultValue;
    final now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return getToday ? 'Today' : formatDate(dateTime, format: "jm");
    } else if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day - 1) {
      return "Yesterday";
    } else {
      return formatDate(dateTime, format: format ?? "dd MMMM yyyy");
    }
  }

  static String getTimeDifference(dynamic d) {
    DateTime? date = d is DateTime ? d : DateTime.tryParse(d);
    if (date != null) {
      final now = DateTime.now();
      final difference = now.difference(date);
      if (difference.inDays > 365) {
        return '${difference.inDays ~/ 365} years ago';
      } else if (difference.inDays > 30) {
        return '${difference.inDays ~/ 30} months ago';
      } else if (difference.inDays > 7) {
        return '${difference.inDays ~/ 7} weeks ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inSeconds > 0) {
        return '${difference.inSeconds} seconds ago';
      } else {
        return 'Just now';
      }
    }
    return 'Invalid Date';
  }

  static String formatDate(dynamic dateTime,
      {String? format, String defaultValue = '---'}) {
    final formatter = DateFormat(format ?? 'dd MMM yyyy');
    return tryCatch<String>(() => formatter.format(
            dateTime is DateTime ? dateTime : DateTime.parse(dateTime))) ??
        defaultValue;
  }

  static DateTime randomDate([int days = 365]) {
    final random = Random();
    final currentDate = DateTime.now();
    final daysToSubtract = random.nextInt(days);
    final newDate = currentDate.subtract(Duration(days: daysToSubtract));
    return newDate;
  }

  static bool isSameDay(dynamic date1, dynamic date2) {
    DateTime _date1 = date1 is DateTime ? date1 : DateTime.parse(date1);
    DateTime _date2 = date2 is DateTime ? date2 : DateTime.parse(date2);
    return _date1.year == _date2.year &&
        _date1.month == _date2.month &&
        _date1.day == _date2.day;
  }

  static Map<String, DateTime> weekBounds(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek =
        date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return {'start': startOfWeek, 'end': endOfWeek};
  }

  static Map<String, DateTime> monthBounds(DateTime date) {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    return {'start': startOfMonth, 'end': endOfMonth};
  }

  static Map<String, DateTime> yearBounds(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final endOfYear = DateTime(date.year + 1, 1, 0);
    return {'start': startOfYear, 'end': endOfYear};
  }

  static DateTime convertToTimeZone(DateTime dateTime, String timeZone) {
    tz.initializeTimeZones();
    final location = tz.getLocation(timeZone);
    final tzDateTime = tz.TZDateTime.from(dateTime, location);
    return tzDateTime.toLocal();
  }

  static DateTime? parseDate(String dateStr, {String? format = 'yyyy-MM-dd'}) {
    try {
      final formatter = DateFormat(format);
      return formatter.parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  static String dateDifferenceInUnits(
      DateTime startDate, DateTime endDate, String unit) {
    final difference = endDate.difference(startDate);
    switch (unit.toLowerCase()) {
      case 'days':
        return '${difference.inDays} days';
      case 'hours':
        return '${difference.inHours} hours';
      case 'minutes':
        return '${difference.inMinutes} minutes';
      case 'seconds':
        return '${difference.inSeconds} seconds';
      default:
        return 'Invalid unit';
    }
  }

  static int getWeekOfYear(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final days = date.difference(startOfYear).inDays;
    return ((days / 7).ceil());
  }

  static bool isDateInRange(
      DateTime date, DateTime startDate, DateTime endDate) {
    return date.isAfter(startDate) && date.isBefore(endDate);
  }

  static int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
