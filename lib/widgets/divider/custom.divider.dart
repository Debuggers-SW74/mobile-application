import 'package:flutter/material.dart';

import '../../common/constants/app.colors.constant.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 48,
      thickness: 1.0,
      color: AppColors.primary,
    );
  }
}