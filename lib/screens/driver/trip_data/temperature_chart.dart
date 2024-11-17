import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          // Línea de temperatura
          LineChartBarData(
            isCurved: true,
            color: Colors.red,
            spots: [
              FlSpot(0, 20), // 0:00 - 20°C
              FlSpot(1, 22), // 1:00 - 22°C
              FlSpot(2, 21), // 2:00 - 21°C
              FlSpot(3, 19), // 3:00 - 19°C
              FlSpot(4, 18), // 4:00 - 18°C
              FlSpot(5, 17), // 5:00 - 17°C
              FlSpot(6, 16), // 6:00 - 16°C
              FlSpot(7, 18), // 7:00 - 18°C
              FlSpot(8, 21), // 8:00 - 21°C
              FlSpot(9, 24), // 9:00 - 24°C
              FlSpot(10, 26), // 10:00 - 26°C
              FlSpot(11, 28), // 11:00 - 28°C
              FlSpot(12, 30), // 12:00 - 30°C
              FlSpot(13, 31), // 13:00 - 31°C
              FlSpot(14, 29), // 14:00 - 29°C
              FlSpot(15, 27), // 15:00 - 27°C
              FlSpot(16, 25), // 16:00 - 25°C
              FlSpot(17, 24), // 17:00 - 24°C
              FlSpot(18, 23), // 18:00 - 23°C
              FlSpot(19, 22), // 19:00 - 22°C
              FlSpot(20, 21), // 20:00 - 21°C
              FlSpot(21, 20), // 21:00 - 20°C
              FlSpot(22, 19), // 22:00 - 19°C
              FlSpot(23, 18), // 23:00 - 18°C
            ],
            dotData: FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}°C'); // Mostrar temperatura en °C
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}:00'); // Mostrar horas
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}