import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/models/entities/alert.model.dart';
import 'package:fastporte/screens/driver/trip_data/pressure_chart.dart';
import 'package:fastporte/screens/driver/trip_data/temperature_chart.dart';
import 'package:fastporte/services/alert/alert.service.dart';
import 'package:fastporte/services/sensor-data/sensor-data.service.dart';
import 'package:fastporte/services/threshold/threshold.service.dart';
import 'package:fastporte/services/trip/trip.service.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';

import '../../../models/entities/trip.model.dart';
import '../../../widgets/app_bar/logged.app_bar.dart';
import '../../../models/entities/threshold.model.dart' as th;

class SupervisorCurrentTripDataScreen extends StatefulWidget {
  const SupervisorCurrentTripDataScreen({super.key});

  @override
  State<SupervisorCurrentTripDataScreen> createState() =>
      _SupervisorCurrentTripDataScreenState();
}

class _SupervisorCurrentTripDataScreenState
    extends State<SupervisorCurrentTripDataScreen> {
  bool _activeTripExists = false;

  final ThresholdService _thresholdService = ThresholdService();
  final TripService _tripService = TripService();
  final AlertService _alertService = AlertService();
  final SensorDataService _sensorDataService = SensorDataService();

  String? _selectedOption;
  double? minThreshold = 0.0;
  double? maxThreshold = 0.0;
  late Future<List<th.Threshold>> _thresholdlist;
  late Future<Trip> _activeTrip;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      List<Trip> trips =
          await _tripService.getTripsBySupervisorIdAndStatusId(2);

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

  void _sendAlert() {
    // Create an alert object
    _activeTrip.then((trip) {
      final alert = AlertCreate(
        tripId: trip.tripId!,
        sensorType: _selectedOption,
        timestamp: DateTime.now().toIso8601String(),
      );

      _sensorDataService.getByTripId(trip.tripId!).then((sensorData) {
        if (sensorData.isNotEmpty) {
          if (_selectedOption == "SENSOR_GAS") {
            alert.value = sensorData.last.gasValue?.toDouble();
          } else if (_selectedOption == "SENSOR_TEMPERATURE") {
            alert.value = sensorData.last.temperatureValue?.toDouble();
          } else if (_selectedOption == "SENSOR_PRESSURE") {
            alert.value = sensorData.last.pressureValue?.toDouble();
          } else if (_selectedOption == "SENSOR_HUMIDITY") {
            alert.value = sensorData.last.humidityValue?.toDouble();
          }

          _alertService.create(alert);
        } else {
          print('No sensor data available for the trip.');
        }
      }).catchError((error) {
        print('Error fetching sensor data: $error');
      });
    }).catchError((error) {
      print('Error fetching active trip: $error');
    });
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Center(
                      child: DropdownButton<String>(
                        value: _selectedOption,
                        hint: const Text("Select an option"),
                        items: [
                          "SENSOR_GAS",
                          "SENSOR_TEMPERATURE",
                          "SENSOR_PRESSURE",
                          "SENSOR_HUMIDITY"
                        ]
                            .map((option) => DropdownMenuItem<String>(
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
                            final threshold = thresholds
                                .firstWhere((t) => t.sensorType == value);
                            setState(() {
                              minThreshold = threshold.minThreshold;
                              maxThreshold = threshold.maxThreshold;
                            });
                          }
                        },
                      ),
                    ),

                    Center(
                      child: CustomElevatedButton(
                        onPressed: _sendAlert,
                        text: "Send Alert",
                        type: ButtonType.error,
                      ),
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
