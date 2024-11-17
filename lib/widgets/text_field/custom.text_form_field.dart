import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/widgets/text_field/template.input_decoration.dart';
import 'package:fastporte/widgets/text_field/template.prefix_icon.dart';
import 'package:fastporte/widgets/text_field/template.prefix_text.dart';
import 'package:fastporte/widgets/text_field/template.suffix_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String labelText;

  /*decoration*/
  final String? errorText;
  final int? errorMaxLines;
  final String? prefixText;
  final String? counterText;
  final TextStyle? counterStyle;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onPressedSuffixIcon;

  /*--*/
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final bool? readOnly;
  final bool? enabled;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomTextFormField({
    super.key,
    this.focusNode,
    this.controller,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.keyboardType,
    required this.labelText,
    this.errorText,
    this.errorMaxLines,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.onPressedSuffixIcon,
    this.inputFormatters,
    this.obscureText,
    this.readOnly,
    this.enabled,
    this.onChanged,
    this.onTap,
    this.counterText,
    this.counterStyle,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.keyboardType,
      style: AppTextStyles.labelTextFormField(context),
      decoration: templateInputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: AppTextStyles.labelTextFormField(context),
        errorText: widget.errorText,
        errorMaxLines: widget.errorMaxLines,
        prefixIcon: widget.prefixIcon != null
            ? TemplatePrefixIcon(iconData: widget.prefixIcon!)
            : widget.prefixText != null
                ? TemplatePrefixText(text: widget.prefixText!)
                : null,
        suffixIcon: widget.suffixIcon != null
            ? TemplateSuffixIcon(iconData: widget.suffixIcon!, onPressed: widget.onPressedSuffixIcon)
            : null,
        counterText: widget.counterText,
        counterStyle: widget.counterStyle,
      ),
      inputFormatters: widget.inputFormatters ?? [],
      obscureText: widget.obscureText ?? false,
      readOnly: widget.readOnly ?? false,
      enabled: widget.enabled ?? true,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
    );
  }
}
