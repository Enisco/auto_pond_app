import 'package:auto_pond_app/auto_pond_app.dart';
import 'package:auto_pond_app/presentation/controller.dart';
import 'package:auto_pond_app/services/background_services.dart';
import 'package:auto_pond_app/services/local_notif_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  LocalNotificationServices localNotificationServices =
      LocalNotificationServices();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // ignore: prefer_const_constructors
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  localNotificationServices.initializeNotificationServices();
  BackgroundService backgroundService = BackgroundService();
  backgroundService.initializeBackgroundService();

  final controller = Get.put(AutoPondController());
  controller.mqttConnect();
  runApp(const AutoPondApp());
}
