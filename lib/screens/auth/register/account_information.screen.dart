import 'dart:io';

import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/util/formatters/username.formatter.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/util/validators/input.validators.dart';
import 'package:fastporte/common/constants/client_type_configs.constant.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:fastporte/widgets/text_field/custom.text_form_field.dart';
import 'package:fastporte/widgets/text_field/template.input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({super.key});

  @override
  State<AccountInformationPage> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformationPage> {
  String? _descriptionError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;
  String _selectedUserType = ClientTypeConfigs.CLIENT;
  String? _termsBoxMessageError;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isTermsBoxChecked = false;
  bool _isUseOfInformationBoxChecked = false;

  File? _image;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _validateForm() {
    setState(() {
      _usernameError = InputValidators.validateRegisterUsername(_usernameController.text);
      _passwordError = InputValidators.validatePassword(_passwordController.text);
      _confirmPasswordError =
          InputValidators.validateConfirmPassword(_passwordController.text, _confirmPasswordController.text);
      _descriptionError = InputValidators.validateRegisterDescription(_descriptionController.text);
      _termsBoxMessageError = _isTermsBoxChecked ? null : 'You must accept the T&C';
    });
  }

  bool isAccountInformationFormValid() {
    _validateForm();

    return _passwordError == null &&
        _confirmPasswordError == null &&
        _descriptionError == null &&
        _usernameError == null &&
        _isTermsBoxChecked;
  }

  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> _pickImage() async {
    // Verifica y solicita permisos
    final status = await Permission.photos.status;
    if (!status.isGranted) {
      final result = await Permission.photos.request();
      if (!result.isGranted) {
        // Maneja el caso en el que el permiso no es concedido
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission not granted to access gallery.'),
          ),
        );
        return;
      }
    }

    // Abre la galería para seleccionar una imagen
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _descriptionController.dispose();
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
                    /**********/
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 130,
                        height: 120,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[200],
                              child: ClipOval(
                                child: _image == null
                                    ? Icon(
                                        Icons.person_outline_rounded,
                                        size: 60,
                                        color: Colors.grey[700],
                                      )
                                    : Image.file(
                                        _image!,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: FloatingActionButton(
                                mini: true,
                                backgroundColor: AppColors.primary.withOpacity(0.8),
                                shape: const CircleBorder(),
                                onPressed: _pickImage,
                                child: const Icon(Icons.camera_alt_outlined,
                                    size: AppConstrainsts.iconSizeMedium),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstrainsts.spacingLarge),
                    CustomTextFormField(
                      labelText: 'Describe yourself',
                      controller: _descriptionController,
                      maxLength: 100,
                      maxLines: 3,
                      errorText: _descriptionError,
                      prefixIcon: Icons.description_outlined,
                      counterText: '${_descriptionController.text.length}/100',
                      counterStyle: AppTextStyles.labelSmall(context),
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => {
                        setState(() {
                          _descriptionError = null;
                        })
                      },
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppConstrainsts.rowFormWidthLeftElement,
                          height: AppConstrainsts.rowFormHeight,
                          child: DropdownButtonFormField(
                            value: _selectedUserType,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 24,
                            ),
                            decoration: templateInputDecoration(
                              labelText: 'User type',
                            ),
                            selectedItemBuilder: (context) {
                              return ClientTypeConfigs.configs.keys.map<Widget>((String value) {
                                return SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      value,
                                      style: AppTextStyles.labelTextFormField(context).copyWith(
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            items: ClientTypeConfigs.configs.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    value,
                                    style: AppTextStyles.labelTextFormField(context),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedUserType = newValue!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: AppConstrainsts.spacingMedium),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: 'Username',
                            controller: _usernameController,
                            errorText: _usernameError,
                            prefixIcon: Icons.person_outline_rounded,
                            keyboardType: TextInputType.name,
                            inputFormatters: [UsernameInputFormatter()],
                            onChanged: (value) => {
                              setState(() {
                                _usernameError = null;
                              })
                            },
                          ),
                        ),
                      ],
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
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: AppColors.primary,
                          checkColor: AppColors.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: const BorderSide(color: AppColors.onSurface),
                          ),
                          value: _isTermsBoxChecked,
                          isError: _termsBoxMessageError != null,
                          onChanged: (bool? value) {
                            setState(() {
                              _isTermsBoxChecked = value!;
                              _termsBoxMessageError = null;
                            });
                          },
                        ),
                        const SizedBox(
                          width: AppConstrainsts.spacingSmall,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'I declare that I have read and accepted the Terms and Conditions',
                                style: AppTextStyles.labelMedium(context),
                                textAlign: TextAlign.justify,
                              ),
                              if (_termsBoxMessageError != null)
                                Text(
                                  _termsBoxMessageError!,
                                  style: AppTextStyles.labelMedium(context).copyWith(color: AppColors.error),
                                  textAlign: TextAlign.left,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: AppColors.primary,
                          checkColor: AppColors.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: const BorderSide(color: AppColors.onSurface),
                          ),
                          value: _isUseOfInformationBoxChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isUseOfInformationBoxChecked = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: AppConstrainsts.spacingSmall,
                        ),
                        Expanded(
                          child: Text(
                            'I agree to the use of my information',
                            style: AppTextStyles.labelMedium(context),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstrainsts.spacingSmall),
                    CustomElevatedButton(
                      text: 'Create account',
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
    if (!isAccountInformationFormValid()) {
      //TODO: Quitar el !
      if (true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully'),
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
