// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';
// import 'package:logger/logger.dart';

// class BackButtonHandler extends StatefulWidget {
//   final Widget child;
//   final StatefulNavigationShell navigationShell;

//   const BackButtonHandler({
//     super.key,
//     required this.child,
//     required this.navigationShell,
//   });

//   @override
//   State<BackButtonHandler> createState() => _BackButtonHandlerState();
// }

// class _BackButtonHandlerState extends State<BackButtonHandler> {
  
//   var logger = Logger();
  
//   @override
//   Widget build(BuildContext context) {

// logger.i('BackButtonHandler: build');

//     return WillPopScope(
//       onWillPop: () async {
//         logger.i('BackButtonHandler: onWillPop');
//         _onWillPop(context);
//         return false;
//       },
//       // canPop: false,
//       // onPopInvoked: (didPop) async {    
//       //   logger.i('BackButtonHandler: onPopInvoked $didPop');

//       //   if (didPop) {
//       //     return;
//       //   }
      
//       //   _onWillPop(context);
//       // },


//       // onPopInvoked: (didPop) async {
//       //   debugPrint('BackButtonHandler: onPopInvoked $didPop');
//       //   debugPrint(
//       //       'BackButtonHandler: currentIndex -> ${widget.navigationShell.currentIndex}');

//       //   if (didPop) return;

//       //   if (widget.navigationShell.currentIndex != 0) {
//       //     widget.navigationShell.goBranch(0);
//       //   } else {
//       //     final shouldPop = await showDialog<bool>(
//       //       context: context,
//       //       builder: (context) => AlertDialog(
//       //         title: const Text('¿Deseas salir de la aplicación?'),
//       //         actions: [
//       //           TextButton(
//       //             onPressed: () => Navigator.pop(context, false),
//       //             child: const Text('No'),
//       //           ),
//       //           TextButton(
//       //             onPressed: () => Navigator.pop(context, true),
//       //             child: const Text('Sí'),
//       //           ),
//       //         ],
//       //       ),
//       //     );
//       //     if (shouldPop ?? false) {
//       //       SystemNavigator.pop();
//       //     }
//       //   }
//       // },
//       child: widget.child,
//     );
//   }

//   void _onWillPop(BuildContext context) {
//     if (widget.navigationShell.currentIndex != 0) {
//       // Si no estamos en la pestaña home, volvemos a ella
//       widget.navigationShell.goBranch(0);
//     } else {
//       // Si ya estamos en home, permitimos que se cierre la app
//       SystemNavigator.pop();
//     }
//   }
// }