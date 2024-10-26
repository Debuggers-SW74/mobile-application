import 'package:flutter/material.dart';
import 'package:movil_application/alert_systems/presentation/trip_report_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Opcional: Quita el banner de debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TripReportPage(), // Llamando la página principal
    );
  }
}
