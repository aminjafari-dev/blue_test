import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BlueController extends GetxController {
  BlueController() {
    scanDevices();
  }
  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future scanDevices() async {
    
    var blePermission = await Permission.bluetoothScan.status;

    if (blePermission.isDenied) {
      if (await Permission.bluetoothScan.request().isGranted) {
        if (await Permission.bluetoothConnect.request().isGranted) {
          flutterBlue.startScan(timeout: Duration(seconds: 5));
          flutterBlue.stopScan();
        }
      }
    } else {
      flutterBlue.startScan(timeout: Duration(seconds: 5));
      flutterBlue.stopScan();
    }
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
