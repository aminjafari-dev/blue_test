import 'package:blue_test/features/bluetooth_devices/presentation/pages/devices_list.dart';
import 'package:blue_test/features/csv_file/presentation/pages/chart_view.dart';
import 'package:blue_test/features/bluetooth_devices/presentation/getx/blue_controller.dart';
import 'package:blue_test/features/csv_file/presentation/getx/csv_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DevicesList(),
    );
  }
}
