
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();
  static var random = Random();
  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
        "@mipmap/ic_launcher",
      ),
      iOS: IOSInitializationSettings(),
    );
    _notificationPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      int id = random.nextInt(pow(2, 31) - 1);
      // int id2 = random.nextInt(pow(2, 31) - 1);
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "swift",
          "swift_channel",
          "swift notification channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(
          presentSound: true,
          presentBadge: true,
        ),
      );
      await _notificationPlugin.show(
        id,
        message.data["title"],
        message.data["body"],
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
