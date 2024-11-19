import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/screens/driver/trip_data/pressure_chart.dart';
import 'package:fastporte/screens/driver/trip_data/temperature_chart.dart';
import 'package:fastporte/services/threshold/threshold.service.dart';
import 'package:fastporte/services/trip/trip.service.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:fastporte/widgets/text_field/custom.text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/button_type.enum.dart';
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
  late bool _activeTripExists = true;

  final ThresholdService _thresholdService = ThresholdService();
  final TripService _tripService = TripService();

  // Variable para almacenar la opción seleccionada
  String? _selectedOption;
  double? minThreshold = 0.0;
  double? maxThreshold = 0.0;
  late Future<List<th.Threshold>> _thresholdlist;
  late Trip _activeTrip;

  void _sendAlert() {
    print("¡Alerta enviada!");
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      // Obtener los viajes activos
      List<Trip> trips = await _tripService.getTripsBySupervisorIdAndStatusId(2);

      if (trips.isEmpty) {
        setState(() {
          _activeTripExists = false;
        });
      } else {
        _activeTrip = trips[0];

        // Obtener los thresholds para el viaje activo
        List<th.Threshold> thresholds =
            await _thresholdService.getByTripId(_activeTrip.tripId!);

        if (thresholds.isNotEmpty) {
          if (mounted) {
            setState(() {
              _activeTripExists = true;
              _selectedOption = thresholds[0].sensorType;
              minThreshold = thresholds[0].minThreshold;
              maxThreshold = thresholds[0].maxThreshold;
              _thresholdlist = Future.value(thresholds);
            });
          }
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
    final List<String> _options = [
      "SENSOR_GAS",
      "SENSOR_TEMPERATURE",
      "SENSOR_PRESSURE",
      "SENSOR_HUMIDITY"
    ];

    return Container(
        padding: const EdgeInsets.all(4.0),
        child: ScreenTemplate(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sensor information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Gráfico de lineas para temperatura
                  SizedBox(
                    height: 400,
                    child: TemperatureChart(tripId: _activeTrip.tripId ?? 0,),
                  ),

                  // Gráfico de barras para presión de gas
                  const SizedBox(
                    height: 200,
                    child: PressureChart(),
                  ),

                  Column(
                    children: [
                      // Expansion Tile para mostrar/ocultar contenido
                      ExpansionTile(
                        title: const Text(
                          "Threshold Setup",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          // Contenido interno del ExpansionTile
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Campo de entrada para Min
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: CustomTextFormField(
                                        labelText: minThreshold.toString(),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Campo de entrada para Max
                                    Flexible(
                                      child: CustomTextFormField(
                                        labelText: maxThreshold.toString(),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 10,
                                  ),
                                  child: DropdownButton<String>(
                                    value: _selectedOption,
                                    hint: const Text("Select an option"),
                                    items: _options.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedOption = newValue;
                                        print(_selectedOption);

                                        // Busca el Threshold correspondiente en la lista
                                        _thresholdlist.then((thresholds) {
                                          final threshold =
                                              thresholds.firstWhere((t) =>
                                                  t.sensorType ==
                                                  _selectedOption);

                                          // Actualiza los valores de min y max
                                          minThreshold = threshold.minThreshold;
                                          maxThreshold = threshold.maxThreshold;
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                  // Botón de enviar alerta
                  Center(
                      child: CustomElevatedButton(
                    onPressed: _sendAlert,
                    text: 'Send Alert',
                    type: ButtonType.error,
                  )),
                ],
              ),
            ),
          ],
        ));
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
