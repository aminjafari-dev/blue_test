import 'package:blue_test/features/bluetooth_devices/presentation/getx/blue_controller.dart';
import 'package:blue_test/features/csv_file/presentation/getx/csv_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

import '../../../csv_file/presentation/pages/chart_view.dart';

class DevicesList extends StatelessWidget {
  DevicesList({super.key});

  final CSVController csvController = Get.put(CSVController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlueController>(
        init: BlueController(),
        initState: (v) {},
        builder: (controller) {
          csvController.loadCsvData();
          return Scaffold(
            appBar: AppBar(
              title: const Text("bluetooth low energy scanner"),
              centerTitle: true,
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<bool>(
                    stream: controller.flutterBlue.isScanning,
                    builder: (context, snapshot) {
                      return FloatingActionButton(
                        onPressed: () {
                          if (snapshot.data != null && !snapshot.data!) {
                            controller.scanDevices();
                          }
                        },
                        child: snapshot.data != null && snapshot.data!
                            ? const CircularProgressIndicator()
                            : const Icon(Icons.search),
                      );
                    }),
                const SizedBox(width: 50),
                FloatingActionButton(
                  heroTag: "navigate",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>const ChartView()),
                    );
                  },
                  child: const Text(".CSV"),
                ),
              ],
            ),
            body: StreamBuilder<List<ScanResult>>(
                stream: controller.flutterBlue.scanResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                             const Text("Bluetooth is:  "),
                              Text(controller.bluetoothOn ? "On" : "Off"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(data.device.name),
                                    subtitle: Text(data.device.id.id),
                                    trailing: Text(
                                      data.rssi.toString(),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(" No Device Found,\nplease turn on your\n             GPS"),
                    );
                  }
                }),
          );
        });
  }
}
