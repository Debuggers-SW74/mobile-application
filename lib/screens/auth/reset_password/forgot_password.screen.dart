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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FocusNode _emailFocusNode = FocusNode();

  String? _emailError;

  final TextEditingController _emailController = TextEditingController();

  bool isForgotPasswordFormValid() {
    setState(() {
      _emailError = InputValidators.validateEmail(_emailController.text);
    });

    return _emailError == null;
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();

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
            padding: const EdgeInsets.only(top: 120.0, bottom: 16.0, right: 60.0, left: 60.0),
            child: Center(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Image.asset(
                      'assets/images/forgot-password.png',
                      height: 150,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineMedium(context),
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Text(
                      'Enter your email address and we will send you a link to reset your password.',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomTextFormField(
                      labelText: 'Email',
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      errorText: _emailError,
                      prefixIcon: Icons.alternate_email_outlined,
                      onChanged: (value) => {
                        setState(() {
                          _emailError = null;
                        })
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomElevatedButton(
                      text: 'Send',
                      type: ButtonType.primary,
                      onPressed: () {
                        if (!isForgotPasswordFormValid()) {
                          //TODO: Quitar el !
                          context.goNamed(AppRoutes.resetInsertNewPassword);
                        }
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
}
