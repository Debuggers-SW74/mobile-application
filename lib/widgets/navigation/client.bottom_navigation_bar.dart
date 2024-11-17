// import 'package:fastporte_mobile_app/common/constants/app.colors.constant.dart';
// import 'package:fastporte_mobile_app/common/constants/app.constraints.constant.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ClientBottomNavigationBar extends StatefulWidget {
//   const ClientBottomNavigationBar({super.key});
//
//   @override
//   State<ClientBottomNavigationBar> createState() => _ClientBottomNavigationBarState();
// }
//
// class _ClientBottomNavigationBarState extends State<ClientBottomNavigationBar> {
//   //late NavigationModel navigationModel;
//
//   @override
//   Widget build(BuildContext context) {
//     final navigationModel = Provider.of<NavigationModel>(context);
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: navigationModel.selectedIndex, //_selectedMenuIndex,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
//         BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
//         BottomNavigationBarItem(icon: Icon(Icons.work_outline_rounded), label: "Contracts"),
//         BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: "Notifications"),
//         BottomNavigationBarItem(icon: Icon(Icons.menu_outlined), label: "More"),
//       ],
//       onTap: (index) {
//         setState(() {
//           //_selectedMenuIndex = index;
//           navigationModel.setIndex(index);
//         });
//       },
//       //backgroundColor: AppColors.primary,
//       iconSize: AppConstrainsts.iconSizeMedium,
//       selectedItemColor: AppColors.primary,
//       selectedLabelStyle: const TextStyle(
//         //color: AppColors.onPrimary,
//           fontSize: AppConstrainsts.textSizeNavigationNormal,
//           fontWeight: FontWeight.bold
//       ),
//       unselectedItemColor: AppColors.noFocus,
//       unselectedLabelStyle: const TextStyle(
//         //color: AppColors.onPrimary,
//         fontSize: AppConstrainsts.textSizeNavigationSmall,
//       ),
//     );
//   }
// }
