class Trip {
  int? tripId;
  int? driverId;
  String? driverName;
  String? driverPhoneNumber;
  int? supervisorId;
  String? supervisorName;
  String? supervisorPhoneNumber;
  String? origin;
  String? destination;
  String? type;
  String? amount;
  String? weight;
  String? date;
  String? startTime;
  String? endTime;
  String? subject;
  String? description;
  String? status;

  Trip(
      {this.tripId,
        this.driverId,
        this.driverName,
        this.driverPhoneNumber,
        this.supervisorId,
        this.supervisorName,
        this.supervisorPhoneNumber,
        this.origin,
        this.destination,
        this.type,
        this.amount,
        this.weight,
        this.date,
        this.startTime,
        this.endTime,
        this.subject,
        this.description,
        this.status});

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      tripId: json['tripId'],
      driverId: json['driverId'],
      driverName: json['driverName'],
      driverPhoneNumber: json['driverPhoneNumber'],
      supervisorId: json['supervisorId'],
      supervisorName: json['supervisorName'],
      supervisorPhoneNumber: json['supervisorPhoneNumber'],
      origin: json['origin'],
      destination: json['destination'],
      type: json['type'],
      amount: json['amount'],
      weight: json['weight'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      subject: json['subject'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'driverId': driverId,
      'driverName': driverName,
      'driverPhoneNumber': driverPhoneNumber,
      'supervisorId': supervisorId,
      'supervisorName': supervisorName,
      'supervisorPhoneNumber': supervisorPhoneNumber,
      'origin': origin,
      'destination': destination,
      'type': type,
      'amount': amount,
      'weight': weight,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'subject': subject,
      'description': description,
      'status': status
    };
  }

  @override
  String toString() {
    return 'Trip{tripId: $tripId, driverId: $driverId, driverName: $driverName, driverPhoneNumber: $driverPhoneNumber, supervisorId: $supervisorId, supervisorName: $supervisorName, supervisorPhoneNumber: $supervisorPhoneNumber, origin: $origin, destination: $destination, type: $type, amount: $amount, weight: $weight, date: $date, startTime: $startTime, endTime: $endTime, subject: $subject, description: $description, status: $status}';
  }
}
