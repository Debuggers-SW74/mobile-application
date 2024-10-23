import 'package:flutter/material.dart';
import 'package:movil_application/common/widgets/pressure_chart.dart';
import 'package:movil_application/common/widgets/temperature_chart.dart';

class TripReportPage extends StatelessWidget {
  const TripReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sensor Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 300, // Ajusta según sea necesario
              child: TemperatureChart(),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 300, // Ajusta según sea necesario
              child: PressureChart(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('SEND ALERT'),
            ),
          ],
        ),
      ),
    );
  }
}