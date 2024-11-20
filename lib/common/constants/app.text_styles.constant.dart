import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // HEADLINES
  static TextStyle headlineLarge(BuildContext context) {
    return GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.headlineLarge);
  }

  static TextStyle headlineMedium(BuildContext context) {
    return GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.headlineMedium);
  }

  static TextStyle headlineSmall(BuildContext context) {
    return GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.headlineSmall);
  }

  // TITLES
  static TextStyle titleLarge(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.titleLarge);
  }

  static TextStyle titleMedium(BuildContext context) {
    return GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.titleMedium);
  }

  static TextStyle titleSmall(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.titleSmall);
  }

  // BODY
  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.bodyLarge);
  }

  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.bodyMedium);
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.bodySmall);
  }

  // LABELS
  static TextStyle labelLarge(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.labelLarge);
  }

  static TextStyle labelMedium(BuildContext context) {
    return GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.labelMedium);
  }

  static TextStyle labelSmall(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.labelSmall);
  }

  // FORM FIELDS
  static TextStyle labelTextFormField(BuildContext context) {
    return GoogleFonts.inter(textStyle: Theme.of(context).textTheme.labelLarge).copyWith(
      //fontSize: 16.0,
    );
    //textStyle: TextStyle(fontSize: 16.0));
  }
}
