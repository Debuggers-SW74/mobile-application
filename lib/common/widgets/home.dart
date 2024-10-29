import 'package:flutter/material.dart';
import 'package:movil_application/common/widgets/sidebar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.local_shipping_sharp, color: Colors.white),
            SizedBox(width: 10),
            Text("Home")
          ],
        ),
        backgroundColor: Colors.blue,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            child: Text('JP'),
          ),
          )
        ],
      ),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hi, Juan!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('View History'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Trips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildTripCard('Juan Perez', 'La Marina, San Miguel', 'Marañón, Los Olivos'),
                  _buildTripCard('Juan Perez', 'La Marina, San Miguel', 'Marañón, Los Olivos'),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(String driver, String from, String to) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person, size: 30),
            ),
            const SizedBox(width: 20),

            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Driver: $driver',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text('From: $from'),
                Text('To: $to'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

