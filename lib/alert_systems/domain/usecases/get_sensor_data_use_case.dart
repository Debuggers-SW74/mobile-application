import 'package:movil_application/alert_systems/domain/entities/sensor_reading.dart';

class GetSensorDataUseCase {
  Future<SensorReading> execute() async {
    // Simula la obtención de datos del sensor.
    return SensorReading(
      temperature: 16,
      humidity: 40,
      pressure: 350,
      gasLeak: false,
    );
  }
}