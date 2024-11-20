import 'package:fastporte/screens/navigation/supervisor.navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class SupervisorMainScreen extends StatefulWidget {
  const SupervisorMainScreen({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('SupervisorMainScreen'));

  final StatefulNavigationShell navigationShell;

  @override
  State<SupervisorMainScreen> createState() => _SupervisorMainScreenState();
}

class _SupervisorMainScreenState extends State<SupervisorMainScreen> {
  var logger = Logger();

  bool _shouldShowNavigationBar(BuildContext context) {

    // Obtiene la ubicación actual
    final location = GoRouter.of(context).routeInformationProvider.value.uri.path;
    logger.i('Location: $location');
    // Lista de rutas donde no se debe mostrar el NavigationBar
    const routesWithoutNavigationBar = ['/supervisor/home/profile', '/supervisor/more/profile'];
    return !routesWithoutNavigationBar.contains(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SupervisorNavigationBar(navigationShell: widget.navigationShell),
      body: SafeArea(top: false, child: widget.navigationShell),
    );
  }
}
