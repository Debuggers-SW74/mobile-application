import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0F15A3);
  static const Color secondary = Color(0xFF5ED6AD);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFDE1919);
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onSurface = Colors.black;
  static const Color onError = Colors.white;

  static const Color noFocus = Colors.grey;
  static const Color primaryPressed = Color(0xFF141cd9);
  static const Color secondaryPressed = Color(0xFF4ec8a1);
  static const Color errorPressed = Color(0xFFc51f1f);

  static const Color disabled = Color(0xFFE0E0E0);

  //Info tag colors
  static Color infoTagDriver = AppColors.secondary.withOpacity(0.6);
  static Color infoTagVehicleDetail = AppColors.primary.withOpacity(0.6);
  static Color infoTagVehicleColor = Colors.grey[300]!;
  static Color infoTagRating = Colors.amber[300]!;
  static Color infoTagLicensePlate = Colors.blue[200]!;
  static Color infoTagCapacity = Colors.deepOrange[200]!;


}