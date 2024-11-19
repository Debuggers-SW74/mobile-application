
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/util/validators/input.validators.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:fastporte/widgets/text_field/custom.text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../providers/registration.provider.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({super.key});

  @override
  State<AccountInformationPage> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformationPage> {
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  void _validateForm() {
    setState(() {
      _passwordError = InputValidators.validatePassword(_passwordController.text);
      _confirmPasswordError =
          InputValidators.validateConfirmPassword(_passwordController.text, _confirmPasswordController.text);
      _emailError = InputValidators.validateEmail(_emailController.text);
    });
  }

  bool isAccountInformationFormValid() {
    _validateForm();

    return _passwordError == null && _confirmPasswordError == null && _emailError == null;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(backLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 16.0, right: 50.0, left: 50.0),
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
                      'Almost done!',
                      style: AppTextStyles.headlineMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Text(
                      'Please fill in your account information to complete the registration process.',
                      style: AppTextStyles.bodyMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomTextFormField(
                      labelText: 'Email',
                      controller: _emailController,
                      errorText: _emailError,
                      prefixIcon: Icons.alternate_email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => {
                        setState(() {
                          _emailError = null;
                        })
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomTextFormField(
                      labelText: 'Password',
                      controller: _passwordController,
                      errorText: _passwordError,
                      prefixIcon: Icons.lock_outline_rounded,
                      suffixIcon:
                          _passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      onPressedSuffixIcon: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      obscureText: !_passwordVisible,
                      onChanged: (value) {
                        setState(() {
                          _passwordError = null;
                        });
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomTextFormField(
                      labelText: 'Confirm Password',
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
                      onChanged: (value) {
                        setState(() {
                          _confirmPasswordError = null;
                        });
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingSmall),
                    CustomElevatedButton(
                      text: 'Continue',
                      type: ButtonType.primary,
                      onPressed: () {
                        _handleCreateAccount(context);
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

  void _handleCreateAccount(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context, listen: false);

    if (isAccountInformationFormValid()) {
      registrationProvider.setAccountInformation(
        _emailController.text,
        _passwordController.text,
      );
      context.goNamed(AppRoutes.registerPersonalInformation);

    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('An error occurred. Please try again.'),
      //     backgroundColor: AppColors.error,
      //   ),
      // );

    }
  }
}
