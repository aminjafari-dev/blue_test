import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BlueController extends GetxController {
  BlueController() {
    scanDevices();
  }
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool bluetoothOn = false;
  Future scanDevices() async {
    var blePermission = await Permission.bluetoothScan.status;
    checkBluetoothStatus();
    if (blePermission.isDenied) {
      await getPermission();
      startScan();
    } else {
      startScan();
    }
  }

  void startScan() {
    flutterBlue.startScan(timeout: const Duration(seconds: 5));
  }

  Future<bool> getPermission() async {
    if (!await Permission.bluetoothScan.request().isGranted ||
        !await Permission.bluetoothConnect.request().isGranted ||
        !await Permission.location.request().isGranted) {
      return false;
    } else {
      return true;
    }
  }

  void checkBluetoothStatus() {
    flutterBlue.state.listen((event) {
      if (event == BluetoothState.off) {
        bluetoothOn = false;
        update();
      }
      if (event == BluetoothState.on) {
        bluetoothOn = true;
        update();
      }
    });
  }
}
