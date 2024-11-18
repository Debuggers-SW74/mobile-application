import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/providers/driver_info.provider.dart';
import 'package:fastporte/services/auth/auth.service.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/util/validators/input.validators.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:fastporte/widgets/text_field/custom.text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _authService = AuthService();

  final ScrollController _scrollController = ScrollController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String? _usernameError;
  String? _passwordError;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  late DriverInfoProvider _clientProvider;

  @override
  void initState() {
    super.initState();

    //Agregar texto por defecto a los campos email y passowrd
    _usernameController.text = 'pg666@gm.com';
    _passwordController.text = 'pgomez';

    _usernameFocusNode.addListener(() {
      if (_usernameFocusNode.hasFocus) {
        _scrollToBottom();
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
  }

  bool isLoginFormValid() {
    setState(() {
      _usernameError = InputValidators.validateEmail(_usernameController.text);
      _passwordError = InputValidators.validateLoginPassword(_passwordController.text);
    });

    return _usernameError == null && _passwordError == null;
  }

  Future<void> _handleLogin() async {
    if (isLoginFormValid()) {
      var loginRole = await _authService.login(_usernameController.text, _passwordController.text);

      if (loginRole != null && mounted) {

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final driverProvider = Provider.of<DriverInfoProvider>(context, listen: false);
          driverProvider.fetchDriver();
        });

        loginRole == 'ROLE_DRIVER' ? context.goNamed(AppRoutes.driverHome) : context.goNamed(AppRoutes.supervisorHome);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch user'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _clientProvider = Provider.of<DriverInfoProvider>(context);

    return Scaffold(
      appBar: const MainAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0, bottom: 16.0, right: 60.0, left: 60.0),
            child: Center(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/fastporte-logo.png',
                      height: 60,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Text(
                      "Welcome, let's get started!",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineLarge(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstrainsts.spacingLarge),
                    CustomTextFormField(
                      focusNode: _usernameFocusNode,
                      controller: _usernameController,
                      labelText: 'Email',
                      errorText: _usernameError,
                      prefixIcon: Icons.alternate_email_outlined,
                      onChanged: (value) => {
                        setState(() {
                          _usernameError = null;
                        })
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomTextFormField(
                      labelText: 'Password',
                      focusNode: _passwordFocusNode,
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
                      onChanged: (value) => {
                        setState(
                          () {
                            _passwordError = null;
                          },
                        ),
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    CustomElevatedButton(
                      text: 'LOGIN',
                      type: ButtonType.primary,
                      onPressed: _handleLogin,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingLarge),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed(AppRoutes.resetForgotPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.labelLarge(context)
                              .copyWith(color: AppColors.primary, decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed(AppRoutes.registerSensorCode);
                        },
                        child: Text(
                          'Create an Account',
                          style: AppTextStyles.labelLarge(context)
                              .copyWith(color: AppColors.primary, decoration: TextDecoration.underline),
                        ),
                      ),
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
