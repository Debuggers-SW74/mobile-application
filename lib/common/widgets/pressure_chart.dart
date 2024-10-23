import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PressureChart extends StatelessWidget {
  const PressureChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 350,
                color: Colors.blue,
                width: 50,
                borderRadius: BorderRadius.circular(25),
              ),
            ],
          ),
        ],
        titlesData: const FlTitlesData(show: true),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}