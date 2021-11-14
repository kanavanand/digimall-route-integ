import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static const new_order_notification_channel = AndroidNotificationChannel(
    'new_order_noti',
    'New Order Notification',
    'New Order Notifications',
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound('new_order_noti'),
    ledColor: Colors.red,
    enableLights: true,
  );
  static const new_order_notification_details = AndroidNotificationDetails(
    'new_order_noti',
    'New Order Notification',
    'New Order Notifications',
    priority: Priority.max,
    importance: Importance.max,
    ledOffMs: 50,
    ledOnMs: 500,
    sound: RawResourceAndroidNotificationSound('new_order_noti'),
    ledColor: Colors.red,
    enableLights: true,
  );
  static Future<void> createNotificationChannel() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationChannel androidNotificationChannel =
        new_order_notification_channel;
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }
}
