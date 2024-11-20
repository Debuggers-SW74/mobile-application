import 'package:flutter/material.dart';

import '../../common/constants/app.colors.constant.dart';
import '../../common/constants/app.constraints.constant.dart';

class CustomDetailRichText extends StatelessWidget {
  const CustomDetailRichText({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: AppConstrainsts.textSizeSmall,
          color: AppColors.onSurface,
        ),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: AppColors.onSurface.withOpacity(0.6)),
          ),
          TextSpan(
            text: description,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}