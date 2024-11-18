class Threshold {
  final int id;
  final String sensorType;
  final double maxThreshold;
  final double minThreshold;
  final int tripId;

  Threshold(
      {required this.id,
      required this.sensorType,
      required this.maxThreshold,
      required this.minThreshold,
      required this.tripId});

  factory Threshold.fromJson(Map<String, dynamic> json) {
    return Threshold(
      id: json['id'],
      sensorType: json['sensorType'],
      maxThreshold: json['maxThreshold'],
      minThreshold: json['minThreshold'],
      tripId: json['tripId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sensorType': sensorType,
      'maxThreshold': maxThreshold,
      'minThreshold': minThreshold,
      'tripId': tripId
    };
  }

  @override
  String toString() {
    return 'Threshold{id: $id}';
  }
}
