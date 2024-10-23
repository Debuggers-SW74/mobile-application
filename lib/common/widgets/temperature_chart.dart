import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.red,
            spots: [
              const FlSpot(0, 15),
              const FlSpot(6, 20),
              const FlSpot(12, 30),
              const FlSpot(18, 25),
              const FlSpot(23, 16),
            ],
          ),
        ],
        titlesData: const FlTitlesData(show: true),
        gridData: const FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}