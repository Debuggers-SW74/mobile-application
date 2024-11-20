import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/widgets/elevated_button/template.button_style.dart';
import 'package:flutter/material.dart';
import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;
  final bool isEnabled;

  const CustomElevatedButton({
    super.key,
   
    required this.text,
    required this.type,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    Color colorPressed;
    Color onColor;

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


    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: templateButtonStyle(type: type),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.labelLarge(context).copyWith(color: onColor),
      ),
    );
  }
}
