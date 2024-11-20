class Alert {
  int? id;
  String? alertLevel;
  String? message;
  SensorData? sensorData;

  Alert({this.id, this.alertLevel, this.message, this.sensorData});

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'],
      alertLevel: json['alertLevel'],
      message: json['message'],
      sensorData: json['sensorData'] != null
          ? SensorData.fromJson(json['sensorData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alertLevel': alertLevel,
      'message': message,
      'sensorData':
          sensorData?.toJson(), // Llama al método toJson() de SensorData
    };
  }
}

class SensorData {
  String? sensorType;
  double? value;
  String? timestamp;
  int? tripId;

  SensorData({this.sensorType, this.value, this.timestamp, this.tripId});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      sensorType: json['sensorType'],
      value: json['value'],
      timestamp: json['timestamp'],
      tripId: json['tripId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensorType': sensorType,
      'value': value,
      'timestamp': timestamp,
      'tripId': tripId,
    };
  }
}

class AlertCreate {
  String? sensorType;
  double? value;
  String? timestamp;
  int? tripId;

  AlertCreate({this.sensorType, this.value, this.timestamp, this.tripId});

  factory AlertCreate.fromJson(Map<String, dynamic> json) {
    return AlertCreate(
      sensorType: json['sensorType'],
      value: json['value'],
      timestamp: json['timestamp'],
      tripId: json['tripId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensorType': sensorType,
      'value': value,
      'timestamp': timestamp,
      'tripId': tripId,
    };
  }
}
