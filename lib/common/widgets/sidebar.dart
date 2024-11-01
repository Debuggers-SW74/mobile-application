import 'package:flutter/material.dart';
import 'package:movil_application/alert_systems/presentation/trip_report_page.dart';
import 'package:movil_application/common/widgets/home.dart';
import 'package:movil_application/profile_management/pages/login_page.dart';

class Sidebar extends StatelessWidget {

  final String currentRoute;

  const Sidebar({super.key, required  this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú Principal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const Text('Home'),
            selected: currentRoute == 'home',
            onTap: () {
              if (currentRoute != 'home') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              if (currentRoute != 'notifications') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TripReportPage()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.car_crash),
            title: const Text('Trips'),
            onTap: () {
              // Acción para configuración
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support'),
            onTap: () {
              // Acción para configuración
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
