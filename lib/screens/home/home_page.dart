// import 'package:fastporte_mobile_app/common/constants/type_user.enum.dart';
// import 'package:fastporte_mobile_app/screens/client/main.screen.dart';
// import 'package:fastporte_mobile_app/screens/driver/home/home.screen.dart';
// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final UserType userType = ModalRoute.of(context)!.settings.arguments as UserType;
//
//     Widget homeWidget;
//
//     switch (userType) {
//       case UserType.client:
//         homeWidget = const ClientMainScreen();
//         break;
//       case UserType.driver:
//         homeWidget = const DriverHomeScreen();
//         break;
//       default:
//         homeWidget = const ClientMainScreen();
//         break;
//     }
//
//     // return ChangeNotifierProvider(
//     //   create: (context) => NavigationModel(),
//     //   child: homeWidget,
//     // );
//
//     return homeWidget;
//   }
// }
