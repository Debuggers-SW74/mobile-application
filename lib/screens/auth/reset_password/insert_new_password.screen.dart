import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/util/validators/input.validators.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/elevated_button/template.button_style.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:fastporte/widgets/text_field/custom.text_form_field.dart';
import 'package:fastporte/widgets/text_field/template.input_decoration.dart';
import 'package:fastporte/widgets/text_field/template.prefix_icon.dart';
import 'package:fastporte/widgets/text_field/template.suffix_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InsertNewPassword extends StatefulWidget {
  const InsertNewPassword({super.key});

  @override
  State<InsertNewPassword> createState() => _InsertNewPasswordState();
}

class _InsertNewPasswordState extends State<InsertNewPassword> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  String? _passwordError;
  String? _confirmPasswordError;

  bool passwordTouched = false;
  bool confirmPasswordTouched = false;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isInsertNewPasswordFormValid() {
    setState(() {
      _passwordError = InputValidators.validatePassword(_passwordController.text);
      _confirmPasswordError =
          InputValidators.validateConfirmPassword(_passwordController.text, _confirmPasswordController.text);
    });

    return _passwordError == null && _confirmPasswordError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(backLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0, bottom: 16.0, right: 60.0, left: 60.0),
            child: Center(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Image.asset(
                      'assets/images/fastporte-logo.png',
                      height: 60,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Text(
                      'Insert Your New Password',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineMedium(context),
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Text(
                      'Type in a new password different from the old one and repeat to validate',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomTextFormField(
                      labelText: 'Password',
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      errorText: _passwordError,
                      errorMaxLines: 2,
                      prefixIcon: Icons.lock_outline_rounded,
                      suffixIcon:
                          _passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      onPressedSuffixIcon: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      obscureText: !_passwordVisible,
                      onChanged: (value) => {
                        setState(() {
                          _passwordError = null;
                        })
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomTextFormField(
                      labelText: 'Confirm Password',
                      focusNode: _confirmPasswordFocusNode,
                      controller: _confirmPasswordController,
                      errorText: _confirmPasswordError,
                      prefixIcon: Icons.lock_outline_rounded,
                      suffixIcon:
                          _confirmPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      onPressedSuffixIcon: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                      obscureText: !_confirmPasswordVisible,
                      onChanged: (value) => {
                        setState(() {
                          _confirmPasswordError = null;
                        })
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomElevatedButton(
                      text: 'Change Password',
                      type: ButtonType.primary,
                      onPressed: () {
                        _handleResetPassword(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleResetPassword(BuildContext context) {
    if (!isInsertNewPasswordFormValid()) {
      //TODO: Quitar el !
      // TODO: Implement password change logic
      if (true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully!'),
            backgroundColor: AppColors.secondary,
          ),
        );
        context.goNamed(AppRoutes.login);
      }
      // ignore: dead_code
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
