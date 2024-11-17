import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:flutter/material.dart';

InputDecoration templateInputDecoration({
  String? labelText,
  String? errorText,
  String? prefixText,
  String? helperText,
  String? hintText,
  String? counterText,
  TextStyle? labelStyle,
  int? errorMaxLines,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Widget? prefix,
  Widget? counter,
  TextStyle? counterStyle,

}) {
  return InputDecoration(
    labelText: labelText,
    errorText: errorText,
    prefixText: prefixText,
    helperText: helperText,
    hintText: hintText,
    counterText: counterText,
    counter: counter,
    labelStyle: labelStyle,
    errorMaxLines: errorMaxLines,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    prefix: prefix,
    counterStyle: counterStyle,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstrainsts.borderRadius),
      borderSide: const BorderSide(color: AppColors.noFocus, width: AppConstrainsts.borderWidth),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstrainsts.borderRadius),
      borderSide: const BorderSide(
        color: AppColors.noFocus,
        width: AppConstrainsts.borderWidth,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstrainsts.borderRadius),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: AppConstrainsts.focusedBorderWidth,
      ),
    ),
  );
}
