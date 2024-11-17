import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/screens/driver/trip_data/pressure_chart.dart';
import 'package:fastporte/screens/driver/trip_data/temperature_chart.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/button_type.enum.dart';
import '../../../widgets/app_bar/logged.app_bar.dart';

class DriverCurrentTripDataScreen extends StatefulWidget {
  const DriverCurrentTripDataScreen({super.key});

  @override
  State<DriverCurrentTripDataScreen> createState() => _DriverCurrentTripDataScreenState();
}

class _DriverCurrentTripDataScreenState extends State<DriverCurrentTripDataScreen> {
  late bool _activeTripExists;

  void _sendAlert() {
    print("¡Alerta enviada!");

  }

  @override
  Widget build(BuildContext context) {
    _activeTripExists = true;

    return Scaffold(
      appBar: const LoggedAppBar(title: 'Current Trip Data', backLeading: true,),
      body: _activeTripExists ? _activeTripData() : _noActiveTripData(),
    );
  }

  Widget _activeTripData() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ScreenTemplate(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sensor data',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Gráfico de lineas para temperatura
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TemperatureChart(),
                ),
                SizedBox(height: 20),

                // Gráfico de barras para presión de gas
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: PressureChart(),
                ),
                SizedBox(height: 20),

                // Botón de enviar alerta
                Center(
                  child: CustomElevatedButton(
                    onPressed: _sendAlert,
                    text: 'Send Alert',
                    type: ButtonType.error,
                  )
                ),
              ],
            ),
          ),
        ],
      )
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
