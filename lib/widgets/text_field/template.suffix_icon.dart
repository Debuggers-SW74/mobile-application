import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:flutter/material.dart';

class TemplateSuffixIcon extends StatelessWidget {

  final IconData iconData;
  final Color iconColor;
  final Function()? onPressed;


  const TemplateSuffixIcon({
    required this.iconData,
    this.iconColor = Colors.black,
    this.onPressed,
    super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData, color: iconColor, size: AppConstrainsts.iconSizeMedium),
      onPressed: onPressed,
    );
  }
}

