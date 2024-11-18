import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PressureChart extends StatelessWidget {
  const PressureChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 500,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 350, // Altura de la barra
                  color: Colors.blue.withOpacity(0.7),
                  width: 120,
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.blue.shade900, // Borde más oscuro
                    width: 2,
                  ),
                ),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 100, // Intervalos en el eje izquierdo
                reservedSize: 60,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()} bar',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return const Text(
                    'Pressure',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 0.5,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}