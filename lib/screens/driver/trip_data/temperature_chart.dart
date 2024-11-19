import 'dart:async'; // Para usar Timer
import 'package:fastporte/models/entities/sensor_data.model.dart';
import 'package:fastporte/services/sensor-data/sensor-data.service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatefulWidget {
  final int tripId;

  const TemperatureChart({super.key, required this.tripId});

  @override
  State<TemperatureChart> createState() => _TemperatureChart();
}

class _TemperatureChart extends State<TemperatureChart> {
  final SensorDataService _sensorDataService = SensorDataService();
  late Timer _timer; // Timer para actualizaciones automáticas

  List<FlSpot> _temperatureSpots = [];
  List<FlSpot> _humiditySpots = [];
  List<String> _xLabels = []; // Etiquetas dinámicas del eje X

  List<SensorData>? sensorData;

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

  // Función para cargar datos de temperatura y humedad
  void _initializeData() async {
    try {
      // Obtener datos del servicio
      List<SensorData> sensorData =
          await _sensorDataService.getByTripId(widget.tripId);

      if (sensorData.isNotEmpty) {
        this.sensorData = sensorData;

        print('Datos cargados: ${sensorData.length} registros');

        setState(() {
          _temperatureSpots = sensorData
              .asMap()
              .entries
              .map((entry) => FlSpot(
                    entry.key.toDouble(), // Índice escalado
                    (entry.value.temperatureValue ?? 0)
                        .toDouble(), // Manejo de nulos
                  ))
              .toList();

          _humiditySpots = sensorData
              .asMap()
              .entries
              .map((entry) => FlSpot(
                    entry.key.toDouble(),
                    (entry.value.humidityValue ?? 0).toDouble(),
                  ))
              .toList();

          _xLabels = sensorData
              .map((data) {
                try {
                  // Convertir el timestamp en un formato legible
                  final parsedTimestamp = DateTime.parse(data.timestamp ?? '');
                  return TimeOfDay.fromDateTime(parsedTimestamp)
                      .format(context);
                } catch (e) {
                  // Si hay un error en el timestamp, usar la hora actual como fallback
                  return TimeOfDay.fromDateTime(DateTime.now()).format(context);
                }
              })
              .take(10)
              .toList();
        });
      }
    } catch (e) {
      print('Error al cargar datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Encabezados del gráfico
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Temperature: ${sensorData?[sensorData!.length - 1].temperatureValue} C", // Ejemplo de encabezado de temperatura
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Humidity: ${sensorData?[sensorData!.length - 1].humidityValue}", // Ejemplo de encabezado de humedad
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        // Contenedor del gráfico
        Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                // Línea para los datos de temperatura
                LineChartBarData(
                  isCurved: true,
                  color: Colors.red,
                  spots:
                      _temperatureSpots, // Usar los datos dinámicos de temperatura
                  dotData: const FlDotData(show: false),
                  barWidth: 3,
                ),
                // Línea para los datos de humedad
                LineChartBarData(
                  isCurved: true,
                  color: Colors.blue,
                  spots: _humiditySpots, // Usar los datos dinámicos de humedad
                  dotData: const FlDotData(show: false),
                  barWidth: 3,
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index % 2 == 0 &&
                          index >= 0 &&
                          index < _xLabels.length) {
                        return Text(
                          _xLabels[index],
                          style: const TextStyle(fontSize: 12),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                          '${value.toInt()}°C'); // Eje izquierdo: Temperatura
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
              ),
              minY: 0, // Mínimo del eje Y
              maxY: 100,
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(show: true),
            ),
          ),
        ),
      ],
    );
  }
}
