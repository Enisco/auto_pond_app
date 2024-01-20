import 'package:auto_pond_app/auto_pond_app.dart';
import 'package:auto_pond_app/presentation/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final controller = Get.put(AutoPondController());
  controller.mqttConnect();
  runApp(const AutoPondApp());
}
