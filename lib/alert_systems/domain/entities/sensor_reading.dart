class SensorReading {
  final double temperature;
  final double humidity;
  final double pressure;
  final bool gasLeak;

  SensorReading({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.gasLeak,
  });
}
