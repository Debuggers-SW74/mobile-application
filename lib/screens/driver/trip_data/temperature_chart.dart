import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Título del gráfico
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Temperature: 16°C", // Valor actual de la temperatura
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Humidity: Dry", // Valor actual de la humedad
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 300,
          padding: const EdgeInsets.all(8),
          child: LineChart(
            LineChartData(
              maxX: 16,
              minX: 9,
              lineBarsData: [
                // Línea de temperatura
                LineChartBarData(
                  isCurved: true,
                  color: Colors.red,
                  spots: [
                    const FlSpot(9, 24),
                    const FlSpot(10, 26),
                    const FlSpot(11, 28),
                    const FlSpot(12, 30),
                    const FlSpot(13, 31),
                    const FlSpot(14, 29),
                    const FlSpot(15, 27),
                    const FlSpot(16, 25),
                  ],
                  dotData: const FlDotData(show: false),
                  barWidth: 3,
                ),
                // Línea de humedad
                LineChartBarData(
                  isCurved: true,
                  color: Colors.blue,
                  spots: [
                    const FlSpot(9, 55),
                    const FlSpot(10, 50),
                    const FlSpot(11, 45),
                    const FlSpot(12, 40),
                    const FlSpot(13, 35),
                    const FlSpot(14, 30),
                    const FlSpot(15, 25),
                    const FlSpot(16, 20),
                  ],
                  dotData: const FlDotData(show: false),
                  barWidth: 3,
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()}°C'); // Eje izquierdo: Temperatura
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()}%'); // Eje derecho: Humedad
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 2, // Mostrar etiquetas cada 6 horas
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()}:00', style: const TextStyle(fontSize: 12));
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(show: true),
            ),
          ),
        ),
      ],
    );
  }
}