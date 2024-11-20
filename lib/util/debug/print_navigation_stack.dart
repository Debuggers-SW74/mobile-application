
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void printNavigationStack(BuildContext context) {
  // Obtén el estado actual del GoRouter
  final goRouter = GoRouter.of(context);
  final location = goRouter.routeInformationProvider.value.uri.path;

  // Imprime la ubicación actual
  print('Current location: $location');

  // Imprime todas las rutas en el stack
  for (var route in goRouter.routerDelegate.currentConfiguration.routes) {
    _printRoute(route, '|');
  }
}

void _printRoute(RouteBase route, String indent) {
  if (route is GoRoute) {
    print('${indent}GoRoute: ${route.path}');
    for (var subRoute in route.routes) {
      _printRoute(subRoute, '$indent-');
    }
  } else if (route is ShellRouteBase) {
    //print('${indent}ShellRouteBase');
    for (var subRoute in route.routes) {
      //_printRoute(subRoute, '$indent-');
    }
  }
}