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
	    ]	 
	 )
	  );
  }
}
