import 'package:blue_test/getx/blue_controller.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlueController>(
        init: BlueController(),
      
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("bluetooth low energy scanner"),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => controller.scanDevices(),
                child: const Icon(Icons.search)),
            body: Center(
              child: StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
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
                          });
                    } else {
                      return const Center(
                        child: Text("No Device Found"),
                      );
                    }
                  }),
            ),
          );
        });
  }
}
