import 'package:fastporte/models/entities/driver.dart';
import 'package:fastporte/models/entities/vehicle.dart';

class RequestService {
  final String origin;
  final String destination;
  final String typeOfService;
  final String date;
  final String startTime;
  final String endTime;
  final int amount;
  final String currency;
  final String description;
  final String status;
  final String createdAt;
  final String updatedAt;

  final Driver driver;
  final Vehicle vehicle;


  RequestService({
    required this.origin,
    required this.destination,
    required this.typeOfService,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.currency,
    this.description = '',
    required this.status,
    required this.createdAt,
    required this.updatedAt,

    required this.driver,
    required this.vehicle,
  });

  factory RequestService.fromJson(Map<String, dynamic> json) {
    return RequestService(
      origin: json['origin'],
      destination: json['destination'],
      typeOfService: json['typeOfService'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      amount: json['amount'],
      currency: json['currency'],
      description: json['description'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      driver: Driver.fromJson(json['driver']),
      vehicle: Vehicle.fromJson(json['vehicle']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'destination': destination,
      'typeOfService': typeOfService,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'amount': amount,
      'currency': currency,
      'description': description,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'driver': driver.toJson(),
      'vehicle': vehicle.toJson(),
    };
  }
}