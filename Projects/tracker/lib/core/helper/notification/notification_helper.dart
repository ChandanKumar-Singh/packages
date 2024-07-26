import 'dart:convert';

import 'package:ext_plus/ext_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tracker/core/helper/index.dart';

class NotificationHelper {
  NotificationHelper._() {
    initializeNotifications();
  }
  NotificationHelper get instance => _instance;
  static final NotificationHelper _instance = NotificationHelper._();
  factory NotificationHelper() => _instance;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel highImportanceChannel;

  bool isFlutterLocalNotificationsInitialized = false;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final String highImportanceChannelId = 'high_importance_channel';
  final String highImportanceChannelName = 'High Importance Notifications';
  final String highImportanceChannelDescription =
      'This channel is used for important notifications.';

  Future<void> initializeNotifications() async {
    if (isFlutterLocalNotificationsInitialized) return;
    printF("initializeNotifications...", name: runtimeType);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await SpHelper.instance.init();
    bool hasNotificationPermission = getBoolAsync('notification_permission');
    if (!hasNotificationPermission) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    /// highImportanceChannelId
    await initializeHighImportanceChannel();
    isFlutterLocalNotificationsInitialized = true;
    printF("initializeNotifications done ✅", name: runtimeType);
  }

  /// show high importance notification
  void showHighImportanceNotification(String title,
      {String? body, MapType? data}) {
    const id = 0;
    showNotification(id, title, highImportanceChannel, body: body, data: data);
  }

  /// Show a notification with the given [id], [title], [channel], [body], and [data].
  void showNotification(
    int id,
    String title,
    AndroidNotificationChannel channel, {
    String? body,
    MapType? data,
  }) async {
    log("showNotification: $title $body");
    final platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: channel.importance,
        priority: Priority.high,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher",
      ),
    );
    String? payload = data != null ? jsonEncode(data) : null;

    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> initializeHighImportanceChannel() async {
    printF("initializeHighImportanceChannel...", name: runtimeType);
    highImportanceChannel = AndroidNotificationChannel(
      highImportanceChannelId,
      highImportanceChannelName,
      description: highImportanceChannelDescription,
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(highImportanceChannel);

    printF("initializeHighImportanceChannel done ✅", name: runtimeType);
  }
}
