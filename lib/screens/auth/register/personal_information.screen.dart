import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/services/driver/driver.service.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/text_field/custom.text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fastporte/util/helpers/date_time.helper.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/util/formatters/first_name.formatter.dart';
import 'package:fastporte/util/validators/input.validators.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app.colors.constant.dart';
import '../../../providers/registration.provider.dart';
import 'package:fastporte/util/formatters/last_names.formatter.dart';
import 'package:fastporte/common/constants/id_type_configs.constant.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:fastporte/widgets/text_field/template.input_decoration.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String? _firstNameError;
  String? _firstLastNameError;
  String? _secondLastNameError;
  String? _phoneNumberError;
  String? _termsBoxMessageError;

  bool _isTermsBoxChecked = false;
  bool _isUseOfInformationBoxChecked = false;

  final String _countryCode = '+51';

  final _firstNameController = TextEditingController();
  final _firstLastNameController = TextEditingController();
  final _secondLastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Future<void> _validateForm() async {
    setState(() {
      _firstNameError = InputValidators.validateRegisterFirstName(_firstNameController.text);
      _firstLastNameError = InputValidators.validateRegisterFirstName(_firstLastNameController.text);
      _secondLastNameError = InputValidators.validateRegisterFirstName(_secondLastNameController.text);
      _phoneNumberError = InputValidators.validateRegisterPhoneNumber(_phoneNumberController.text);
      _termsBoxMessageError = _isTermsBoxChecked ? null : 'You must accept the T&C';

    });
  }

  Future<bool> isPersonalInformationFormValid() async {
    await _validateForm();

    return _firstNameError == null &&
        _firstLastNameError == null &&
        _secondLastNameError == null &&
        _phoneNumberError == null &&
        _isTermsBoxChecked;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _firstLastNameController.dispose();
    _secondLastNameController.dispose();
    _phoneNumberController.dispose();

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
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
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
                        'Fill in your personal information',
                        style: AppTextStyles.headlineMedium(context),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConstrainsts.spacingLarge),
                      CustomTextFormField(
                        labelText: 'First name',
                        controller: _firstNameController,
                        errorText: _firstNameError,
                        prefixIcon: Icons.person_outline_rounded,
                        inputFormatters: [FirstNameInputFormatter()],
                        keyboardType: TextInputType.name,
                        onChanged: (value) => {
                          setState(() {
                            _firstNameError = null;
                          })
                        },
                      ),
                      const SizedBox(height: AppConstrainsts.spacingMedium),
                      CustomTextFormField(
                        labelText: 'First last name',
                        controller: _firstLastNameController,
                        errorText: _firstLastNameError,
                        prefixIcon: Icons.person_outline_rounded,
                        inputFormatters: [FirstNameInputFormatter()],
                        keyboardType: TextInputType.name,
                        onChanged: (value) => {
                          setState(() {
                            _firstLastNameError = null;
                          })
                        },
                      ),
                      const SizedBox(height: AppConstrainsts.spacingMedium),
                      CustomTextFormField(
                        labelText: 'Second last name',
                        controller: _secondLastNameController,
                        errorText: _secondLastNameError,
                        prefixIcon: Icons.person_outline_rounded,
                        inputFormatters: [FirstNameInputFormatter()],
                        keyboardType: TextInputType.name,
                        onChanged: (value) => {
                          setState(() {
                            _secondLastNameError = null;
                          })
                        },
                      ),
                      const SizedBox(height: AppConstrainsts.spacingMedium),
                      CustomTextFormField(
                        labelText: 'Phone number',
                        controller: _phoneNumberController,
                        errorText: _phoneNumberError,
                        errorMaxLines: 2,
                        prefixText: _countryCode,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => {
                          setState(() {
                            _phoneNumberError = null;
                          })
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
                      const SizedBox(height: AppConstrainsts.spacingMedium),
                      CustomElevatedButton(
                        text: 'Continue',
                        type: ButtonType.primary,
                        onPressed: () async {
                          await _handlePersonalInformationForm();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _handlePersonalInformationForm() async {
    final registrationProvider = Provider.of<RegistrationProvider>(context, listen: false);

    bool isValid = await isPersonalInformationFormValid();
    if (isValid) {
      if (mounted) {

        registrationProvider.setPersonalInformation(
          _firstNameController.text,
          _firstLastNameController.text,
          _secondLastNameController.text,
          _phoneNumberController.text,
        );

        bool success = await registrationProvider.register();


        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully'),
              backgroundColor: AppColors.secondary,
            ),
          );
          context.goNamed(AppRoutes.login);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred. Please try again.'),
              backgroundColor: AppColors.error,
            ),
          );
        }



        //context.goNamed(AppRoutes.login);
      } else {
        //Mostrar un mensaje de error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An internal error ocurred. Please contact support.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
