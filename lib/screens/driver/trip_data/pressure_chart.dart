import 'dart:async';

import 'package:fastporte/models/entities/sensor_data.model.dart';
import 'package:fastporte/services/sensor-data/sensor-data.service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PressureChart extends StatefulWidget {
  final int tripId;

  const PressureChart({super.key, required this.tripId});

  @override
  State<PressureChart> createState() => _PressureChart();
}

class _PressureChart extends State<PressureChart> {
  final SensorDataService _sensorDataService = SensorDataService();
  late Timer _timer; // Timer para actualizaciones automáticas

  List<SensorData>? sensorData;
  int? heightPressure;

  @override
  void initState() {
    super.initState();
    _initializeData(); // Cargar datos iniciales
    _startAutoRefresh(); // Iniciar actualizaciones automáticas cada 30 segundos
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar el Timer cuando el widget se destruye
    super.dispose();
  }

  // Función para iniciar actualizaciones automáticas cada 30 segundos
  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _initializeData();
    });
  }

  void _initializeData() async {
    try {
      // Obtener datos del servicio
      List<SensorData> sensorData =
          await _sensorDataService.getByTripId(widget.tripId);

      if (sensorData.isNotEmpty) {
        this.sensorData = sensorData;

        print('Datos cargados: ${sensorData.length} registros');

        setState(() {
          heightPressure = sensorData[0].pressureValue;
        });
      }
    } catch (e) {
      print('Error al cargar datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 255,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: heightPressure?.toDouble() ?? 0, // Altura de la barra
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
                interval: 55, // Intervalos en el eje izquierdo
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
              return const FlLine(
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
