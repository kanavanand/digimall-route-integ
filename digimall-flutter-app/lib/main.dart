import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/constants/configs.dart';
import 'package:prachar/injection.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/services/local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  await LocalNotification.createNotificationChannel();
  await Firebase.initializeApp();
  runApp(const AppWidget());
}
