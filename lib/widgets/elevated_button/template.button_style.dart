import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:flutter/material.dart';

ButtonStyle templateButtonStyle({
  required ButtonType type,
}) {
  Color color;
  Color onColor;
  Color colorPressed;

  switch (type) {
    case ButtonType.primary:
      color = AppColors.primary;
      onColor = AppColors.onPrimary;
      colorPressed = AppColors.primaryPressed;
      break;
    case ButtonType.secondary:
      color = AppColors.secondary;
      onColor = AppColors.onSecondary;
      colorPressed = AppColors.secondaryPressed;
      break;
    case ButtonType.error:
      color = AppColors.error;
      onColor = AppColors.onError;
      colorPressed = AppColors.errorPressed;
      break;
    default:
      color = AppColors.primary;
      onColor = AppColors.onPrimary;
      colorPressed = AppColors.primaryPressed;
  }

  return ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>( 
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.disabled;
        }
        return color;
      },
    ),
    // fixedSize: WidgetStateProperty.all<Size>(
    //   const Size(double.infinity, 52.0),
    // ),
    // padding: WidgetStateProperty.all<EdgeInsets>(
    //   const EdgeInsets.symmetric(vertical: 10.0),
    // ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstrainsts.borderRadius),
      ),
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return colorPressed;
        }
        return color;
      },
    ),
  );
}
