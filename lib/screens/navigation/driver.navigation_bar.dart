import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DriverNavigationBar extends StatefulWidget {
  const DriverNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<DriverNavigationBar> createState() => _DriverNavigationBarState();
}

class _DriverNavigationBarState extends State<DriverNavigationBar> {
  //int _selectedMenuIndex = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: AppColors.surface,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: AppColors.primary,
            );
          }
          return const IconThemeData(
            color: AppColors.noFocus,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.primary,
              fontSize: AppConstrainsts.textSizeNavigationNormal,
              fontWeight: FontWeight.bold,
            );
          }
          return const TextStyle(
            color: AppColors.noFocus,
            fontSize: AppConstrainsts.textSizeNavigationSmall,
          );
        }),
      ),
      child: NavigationBar(
        surfaceTintColor: AppColors.primary,
        //indicatorColor: AppColors.primary.withOpacity(0.2),
        onDestinationSelected: (index) {
          // setState(() {
          //   _selectedMenuIndex = index;
          // });
          _goBranch(index);
        },
        selectedIndex: widget.navigationShell.currentIndex,
        //_selectedMenuIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          /*NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: "Search",
          ),*/
          NavigationDestination(
            icon: Icon(Icons.local_taxi_outlined),
            selectedIcon: Icon(Icons.local_taxi),
            label: "Trips",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_support_rounded),
            selectedIcon: Icon(Icons.contact_support_outlined),
            label: "Support",
          ),
        ],
      ),
    );
  }
}
