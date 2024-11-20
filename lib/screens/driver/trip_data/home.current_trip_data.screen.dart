import 'dart:async';

import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/screens/driver/trip_data/pressure_chart.dart';
import 'package:fastporte/screens/driver/trip_data/temperature_chart.dart';
import 'package:fastporte/services/alert/alert.service.dart';
import 'package:fastporte/services/threshold/threshold.service.dart';
import 'package:fastporte/services/trip/trip.service.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';

import '../../../models/entities/trip.model.dart';
import '../../../widgets/app_bar/logged.app_bar.dart';
import '../../../models/entities/threshold.model.dart' as th;

class DriverCurrentTripDataScreen extends StatefulWidget {
  const DriverCurrentTripDataScreen({super.key});

  @override
  State<DriverCurrentTripDataScreen> createState() =>
      _DriverCurrentTripDataScreenState();
}

class _DriverCurrentTripDataScreenState
    extends State<DriverCurrentTripDataScreen> {
  bool _activeTripExists = false;

  final ThresholdService _thresholdService = ThresholdService();
  final TripService _tripService = TripService();

  String? _selectedOption;
  double? minThreshold = 0.0;
  double? maxThreshold = 0.0;
  late Future<List<th.Threshold>> _thresholdlist;
  late Future<Trip> _activeTrip;
  final AlertService _alertService = AlertService();
  late Timer _timer; // Timer para actualizaciones automáticas
  List<int> showAlertsIdx = [];

  @override
  void initState() {
    super.initState();
    _initializeData().then((_) {
      _checkAlerts();
      _startAutoRefresh();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar el Timer cuando el widget se destruye
    super.dispose();
  }

  // Función para iniciar actualizaciones automáticas cada 30 segundos
  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkAlerts();
    });
  }

  void _checkAlerts() async {
    try {
      _activeTrip.then((trip) {
        _alertService.getByTripId(trip.tripId!).then((alerts) {
          if (alerts.isNotEmpty) {
            final showedAlerts = alerts.where((alert) {
              return DateTime.parse(alert.sensorData!.timestamp!).isAfter(
                      DateTime.now().subtract(const Duration(seconds: 40))) &&
                  !showAlertsIdx.contains(alert.id!);
            }).toList();

            showedAlerts.sort((a, b) {
              return DateTime.parse(b.sensorData!.timestamp!)
                  .compareTo(DateTime.parse(a.sensorData!.timestamp!));
            });

            for (var alert in showedAlerts) {
              if (!showAlertsIdx.contains(alert.id!)) {
                showAlertsIdx.add(alert.id!);
              }
            }

            if (showedAlerts.isNotEmpty) {
              final alert = showedAlerts[0];
              // Aquí puedes hacer algo con la primera alerta si es necesario

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    title: const Text(
                      'Alert',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text(
                      'Alert: ${alert.message}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white), // Texto blanco
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            print('No alerts found');
          }
        });
      });
    } catch (e) {
      print('Error checking alerts: $e');
    }
  }

  Future<void> _initializeData() async {
    try {
      List<Trip> trips = await _tripService.getTripsByDriverIdAndStatusId(2);

      if (trips.isEmpty) {
        setState(() {
          _activeTripExists = false;
        });
      } else {
        final trip = trips[0];
        _activeTrip = Future.value(trip);

        List<th.Threshold> thresholds =
            await _thresholdService.getByTripId(trip.tripId!);

        if (thresholds.isNotEmpty) {
          setState(() {
            _activeTripExists = true;
            _selectedOption = thresholds[0].sensorType;
            minThreshold = thresholds[0].minThreshold;
            maxThreshold = thresholds[0].maxThreshold;
            _thresholdlist = Future.value(thresholds);
          });
        }
      }
    } catch (e) {
      print('Error during initialization: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoggedAppBar(
        title: 'Current Trip Data',
        backLeading: true,
      ),
      body: _activeTripExists ? _activeTripData() : _noActiveTripData(),
    );
  }

  Widget _activeTripData() {
    return FutureBuilder<Trip>(
      future: _activeTrip,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final trip = snapshot.data!;
          return ScreenTemplate(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sensor information',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    // Line chart for temperature
                    SizedBox(
                      height: 400,
                      child: TemperatureChart(tripId: trip.tripId!),
                    ),

                    // Bar chart for pressure
                    SizedBox(
                      height: 200,
                      child: PressureChart(tripId: trip.tripId!),
                    ),

                    // Additional widgets (e.g., Threshold Setup)
                    Column(
                      children: [
                        ExpansionTile(
                          title: const Text(
                            "Threshold Setup",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            labelText: minThreshold.toString(),
                                          ),
                                          readOnly: true,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Flexible(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            labelText: maxThreshold.toString(),
                                          ),
                                          readOnly: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButton<String>(
                                    value: _selectedOption,
                                    hint: const Text("Select an option"),
                                    items: ["SENSOR_GAS", "SENSOR_TEMPERATURE"]
                                        .map((option) =>
                                            DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(option),
                                            ))
                                        .toList(),
                                    onChanged: (value) async {
                                      if (value != null) {
                                        setState(() {
                                          _selectedOption = value;
                                        });

                                        final thresholds = await _thresholdlist;
                                        final threshold = thresholds.firstWhere(
                                            (t) => t.sensorType == value);
                                        setState(() {
                                          minThreshold = threshold.minThreshold;
                                          maxThreshold = threshold.maxThreshold;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No active trip found.'));
        }
      },
    );
  }

  ScreenTemplate _noActiveTripData() {
    return ScreenTemplate(
      children: [
        Text(
          'There is no active trip at the moment.',
          style: AppTextStyles.headlineMedium(context),
        ),
      ],
    );
  }
}
