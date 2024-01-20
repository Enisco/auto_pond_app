// ignore_for_file: depend_on_referenced_packages

import 'package:auto_pond_app/presentation/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class AutoPondApp extends StatelessWidget {
  const AutoPondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Bin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const AutoPondPageView(),
    );
  }
}
