class SensorData {
  int? tripId;
  int? temperatureValue;
  int? humidityValue;
  bool? pressureValue;
  int? gasValue;
  String? timestamp;

  SensorData(
      {this.tripId,
        this.temperatureValue,
        this.humidityValue,
        this.pressureValue,
        this.gasValue,
        this.timestamp});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      tripId: json['tripId'],
      temperatureValue: json['temperatureValue'],
      humidityValue: json['humidityValue'],
      pressureValue: json['pressureValue'],
      gasValue: json['gasValue'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'temperatureValue': temperatureValue,
      'humidityValue': humidityValue,
      'pressureValue': pressureValue,
      'gasValue': gasValue,
      'timestamp': timestamp,
    };
  }
}
