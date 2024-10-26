import 'package:flutter/material.dart';
import 'package:movil_application/common/widgets/pressure_chart.dart';
import 'package:movil_application/common/widgets/temperature_chart.dart';

class TripReportPage extends StatelessWidget {
  const TripReportPage({super.key});

  void _sendAlert() {
    print("¡Alerta enviada!");
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
       body: Padding( )
	 padding: const EdgeInsets.all(16.0), 
         child: Column(
	    crossAxisAlignment: CrossAxisAlignment.start,
	    children: [
		    Text(
	              'Datos del Sensor',
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
	              child: ElevatedButton(
	                onPressed: _sendAlert,
	                style: ElevatedButton.styleFrom(
	                  backgroundColor: Colors.red, 
	                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
	                  shape: RoundedRectangleBorder(
	                    borderRadius: BorderRadius.circular(30),
	                  ),
	                ),
	                child: Text(
	                  'Enviar Alerta',
	                  style: TextStyle(fontSize: 18),
	                ),
	              ),
	            ),
	    ]	 
	 )
	  );
  }
}
