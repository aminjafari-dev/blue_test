import 'package:blue_test/features/csv_file/presentation/getx/csv_controller.dart';
import 'package:blue_test/features/csv_file/presentation/widgets/chart_builder.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ChartView extends StatefulWidget {
  ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CSVController>(
        init: CSVController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  ChartBuilder(
                    spots: [
                      for (int i = 0; i < controller.timeValues.length; i++)
                        FlSpot(controller.timeValues[i].toDouble(),
                            controller.ecgValues[i].toDouble())
                    ],
                  ),
                  ChartBuilder(
                    spots: [
                      for (int i = 0; i < controller.timeValues.length ; i++)
                        FlSpot(controller.timeValues[i].toDouble(),
                            controller.irValues[i].toDouble())
                    ],
                  ),
                  ChartBuilder(
                    spots: [
                      for (int i = 0; i < controller.timeValues.length; i++)
                        FlSpot(controller.timeValues[i].toDouble(),
                            controller.redValues[i].toDouble())
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
