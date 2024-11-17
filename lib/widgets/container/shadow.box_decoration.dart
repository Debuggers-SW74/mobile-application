//retornar un box decoration

import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:flutter/material.dart';

BoxDecoration shadowBoxDecoration() {
  return BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppConstrainsts.borderRadius),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 0),
        blurStyle: BlurStyle.outer,
      ),
    ],
  );
}
