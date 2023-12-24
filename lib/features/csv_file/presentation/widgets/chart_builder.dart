import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartBuilder extends StatelessWidget {
  const ChartBuilder({super.key, required this.spots});
  final List<FlSpot> spots;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots:  spots..sort((a, b) => a.x.compareTo(b.x)),
              
              dotData: const FlDotData(show: false),
              isCurved: false
            ),
          ],
        ),
      ),
    );
  }
}
