import 'package:fastporte/screens/navigation/driver.navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ClientMainScreen'));

  final StatefulNavigationShell navigationShell;

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {
  var logger = Logger();

  bool _shouldShowNavigationBar(BuildContext context) {
    
    // Obtiene la ubicación actual
    final location = GoRouter.of(context).routeInformationProvider.value.uri.path;
    logger.i('Location: $location');
    // Lista de rutas donde no se debe mostrar el NavigationBar
    const routesWithoutNavigationBar = ['/client/home/profile', '/client/more/profile'];
    return !routesWithoutNavigationBar.contains(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DriverNavigationBar(navigationShell: widget.navigationShell),
      body: SafeArea(top: false, child: widget.navigationShell),
    );
  }
}
