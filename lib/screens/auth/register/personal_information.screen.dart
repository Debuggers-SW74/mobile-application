import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/text_field/custom.text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fastporte/util/helpers/date_time.helper.dart';
import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/util/formatters/first_name.formatter.dart';
import 'package:fastporte/util/validators/input.validators.dart';
import 'package:fastporte/util/formatters/last_names.formatter.dart';
import 'package:fastporte/common/constants/id_type_configs.constant.dart';
import 'package:fastporte/widgets/elevated_button/template.button_style.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:fastporte/widgets/text_field/template.input_decoration.dart';
import 'package:fastporte/widgets/text_field/template.prefix_icon.dart';
import 'package:fastporte/widgets/text_field/template.prefix_text.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../widgets/modal/custom_cupertino_date.modal.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String? _firstNameError;
  String? _lastNamesError;
  String? _emailError;
  String? _phoneNumberError;
  String? _idError;
  String? _birthdateError;
  String _selectedIdType = IdTypeConfigs.DNI;
  String _countryCode = '+51';

  DateTime _selectedBirthdate = DateHelper.todayDateMinus18Years();
  CountryWithPhoneCode? _selectedCountry;
  List<CountryWithPhoneCode> _countries = [];

  final _firstNameController = TextEditingController();
  final _lastNamesController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _idController = TextEditingController();
  final _birthdateController = TextEditingController();

  late MaskTextInputFormatter _idMaskFormatter;
  late MaskTextInputFormatter _phoneNumberFormatter;
  late AnimationController _cpiController;

  /*
  /// Todo: Arreglar el método para comporbar que el número decelular es válido para el país elegido
  Future<void> _validatePhoneNumber(String value) async {
    if (value.isEmpty) {
      setState(() {
        _phoneNumberError = 'Please enter your phone number';
      });
    } else {
      try {
        // Elimina espacios en blanco y guiones del número
        String cleanedNumber = value.replaceAll(RegExp(r'\s|-'), '');

        // Asegúrate de que _selectedCountry no sea null y tenga un código de país válido
        String countryCode = _selectedCountry?.countryCode ?? 'PE'; // USA como fallback

        debugPrint('Este es un mensaje de depuración');
        debugPrint('Country code: $countryCode');
        // Valida el número de teléfono
        Map<String, dynamic> result = await parse(
          cleanedNumber,
          region: countryCode,
        );

        debugPrint('Este es un mensaje de depuración');
        debugPrint('Result: $result');

        setState(() {
          if (result['is_valid_number']) {
            _phoneNumberError = null;
          } else {
            _phoneNumberError = 'Please enter a valid phone number';
          }
        });
      } catch (e) {
        setState(() {
          _phoneNumberError = 'An error occurred while validating the phone number';
        });
      }
    }
  }
  */

  Future<void> _validateForm() async {
    setState(() {
      _firstNameError = InputValidators.validateRegisterFirstName(_firstNameController.text);
      _lastNamesError = InputValidators.validateRegisterLastName(_lastNamesController.text);
      _emailError = InputValidators.validateEmail(_emailController.text);
      _idError = InputValidators.validateRegisterId(_idController.text, _selectedIdType);
      _birthdateError = InputValidators.validateRegisterBirthdate(_birthdateController.text);
      _phoneNumberError = InputValidators.validateRegisterPhoneNumber(_phoneNumberController.text);
    });
    //await _validatePhoneNumber(_phoneNumberController.text);
  }

  Future<bool> isPersonalInformationFormValid() async {
    await _validateForm();

    return _firstNameError == null &&
        _lastNamesError == null &&
        _emailError == null &&
        _phoneNumberError == null &&
        _idError == null &&
        _birthdateError == null;
  }

  Future<List<CountryWithPhoneCode>> _loadCountries() async {
    await init();
    //cargar la lista de paises pero ordenados por nombre
    // List<CountryWithPhoneCode> countries = CountryManager().countries;
    // countries.sort((a, b) => a.countryName!.compareTo(b.countryName!));

    //Cargar solo Peru
    List<CountryWithPhoneCode> countries =
        CountryManager().countries.where((element) => element.countryCode == 'PE').toList();

    _selectedCountry =
        countries.firstWhere((element) => element.countryCode == 'PE', orElse: () => countries.first);

    return countries;
  }

  void _onCountryChanged(CountryWithPhoneCode country) {
    setState(() {
      _selectedCountry = country;
      _countryCode = "+${country.phoneCode}";
    });
  }

  void _showDatePickerDialog(BuildContext context) {
    DateTime initialDate = DateHelper.todayDateMinus18Years();
    DateTime maximumDate = initialDate;
    DateTime minimumDate = DateTime(initialDate.year - 82, initialDate.month, initialDate.day);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CustomCupertinoDatePicker(
        selectedDate: _selectedBirthdate,
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        onDateTimeChanged: (DateTime newDateTime) {
          setState(() {
            _selectedBirthdate = newDateTime;
          });
        },
        onOkPressed: () {
          setState(() {
            _birthdateController.text = DateHelper.formatDate(_selectedBirthdate);
            _birthdateError = null;
          });
          Navigator.of(context).pop();
        },
      ),
    );
/*
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: AppTextStyles.labelTextFormField(context),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: _selectedBirthdate,
                    maximumDate: maximumDate,
                    minimumDate: minimumDate,
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        _selectedBirthdate = newDateTime;
                      });
                    },
                  ),
                ),
              ),
              CupertinoButton(
                child: Text(
                  'OK',
                  style: AppTextStyles.labelTextFormField(context)
                      .copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    _birthdateController.text = DateHelper.formatDate(_selectedBirthdate);
                    _birthdateError = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
    */
  }

  @override
  void initState() {
    super.initState();

    /// Iniciar máscaras
    _idMaskFormatter = IdTypeConfigs.configs[_selectedIdType]!.mask!;
    _phoneNumberFormatter = MaskTextInputFormatter(
        mask: '### ### ###',
        filter: {"#": RegExp(r'[0-9]')},
        initialText: '9',
        type: MaskAutoCompletionType.eager);

    /// Cargar países
    _loadCountries().then((countries) {
      setState(() {
        _countries = countries;
        _selectedCountry =
            countries.firstWhere((element) => element.countryCode == 'PE', orElse: () => countries.first);
      });
    });

    //Circular progress indicator
    _cpiController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(() {
        setState(() {});
      });
    _cpiController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNamesController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _idController.dispose();
    _cpiController.dispose();
    _birthdateController.dispose();

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
                        labelText: 'Last names',
                        controller: _lastNamesController,
                        errorText: _lastNamesError,
                        prefixIcon: Icons.person_outline_rounded,
                        inputFormatters: [LastNamesInputFormatter()],
                        keyboardType: TextInputType.name,
                        onChanged: (value) => {
                          setState(() {
                            _lastNamesError = null;
                          })
                        },
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: AppConstrainsts.rowFormWidthLeftElement,
                              height: AppConstrainsts.rowFormHeight,
                              child: _countries.isEmpty
                                  ? SizedBox(
                                      height: AppConstrainsts.rowFormHeight,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: _cpiController.value,
                                          ),
                                        ],
                                      ),
                                    )
                                  : DropdownButtonFormField<CountryWithPhoneCode>(
                                      //hint: const Text('Select Country'),
                                      value: _selectedCountry,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: 24,
                                      ),
                                      style: AppTextStyles.labelTextFormField(context),
                                      decoration: templateInputDecoration(
                                        labelText: 'Country',
                                        labelStyle: AppTextStyles.labelTextFormField(context),
                                      ),
                                      onChanged: (CountryWithPhoneCode? newValue) {
                                        setState(() {
                                          _selectedCountry = newValue;
                                          _phoneNumberController.clear();
                                        });
                                        if (newValue != null) {
                                          _onCountryChanged(newValue);
                                        }
                                      },
                                      selectedItemBuilder: (context) {
                                        return _countries.map<Widget>((CountryWithPhoneCode country) {
                                          return SizedBox(
                                            width: 40,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Text(country.countryName!,
                                                  style: AppTextStyles.labelTextFormField(context).copyWith(
                                                    overflow: TextOverflow.clip,
                                                  )),
                                            ),
                                          );
                                        }).toList();
                                      },
                                      items: _countries.map<DropdownMenuItem<CountryWithPhoneCode>>(
                                          (CountryWithPhoneCode country) {
                                        bool isSelected = country == _selectedCountry;
                                        return DropdownMenuItem<CountryWithPhoneCode>(
                                          value: country,
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              //vertical: 4.0,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            color: isSelected
                                                ? Colors.blue.withOpacity(0.1)
                                                : Colors.transparent,
                                            child: Text(
                                              country.countryName!,
                                              maxLines: 1,
                                              style: AppTextStyles.labelTextFormField(context)
                                                  .copyWith(overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                          const SizedBox(width: AppConstrainsts.spacingMedium),
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Phone number',
                              controller: _phoneNumberController,
                              errorText: _phoneNumberError,
                              errorMaxLines: 2,
                              prefixText: _countryCode,
                              inputFormatters: [_phoneNumberFormatter],
                              // inputFormatters: _selectedCountry == null
                              //     ? null
                              //     : [
                              //         LibPhonenumberTextFormatter(
                              //           country: _selectedCountry!,
                              //           phoneNumberType: PhoneNumberType.mobile,
                              //           phoneNumberFormat: PhoneNumberFormat.international,
                              //         ),
                              //       ],
                              keyboardType: TextInputType.phone,
                              onChanged: (value) => {
                                setState(() {
                                  _phoneNumberError = null;
                                })
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstrainsts.spacingMedium),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppConstrainsts.rowFormWidthLeftElement,
                            height: AppConstrainsts.rowFormHeight,
                            child: DropdownButtonFormField(
                              value: _selectedIdType,
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 24,
                              ),
                              decoration: templateInputDecoration(
                                labelText: 'ID type',
                              ),
                              selectedItemBuilder: (context) {
                                return IdTypeConfigs.configs.keys.map<Widget>((String value) {
                                  return SizedBox(
                                    width: 40,
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
                              items: IdTypeConfigs.configs.keys.map((String value) {
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
                                  _selectedIdType = newValue!;
                                  _idMaskFormatter = IdTypeConfigs.configs[_selectedIdType]!.mask!;
                                  _idController.clear();
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: AppConstrainsts.spacingMedium),
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'ID',
                              controller: _idController,
                              errorText: _idError,
                              prefixIcon: Icons.numbers_outlined,
                              keyboardType: TextInputType.number,
                              inputFormatters: [_idMaskFormatter],
                              onChanged: (value) => {
                                setState(() {
                                  _idError = null;
                                })
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstrainsts.spacingMedium),
                      CustomTextFormField(
                        controller: _birthdateController,
                        labelText: 'Birth date',
                        errorText: _birthdateError,
                        prefixIcon: Icons.calendar_today_outlined,
                        readOnly: true,
                        onTap: () => {
                          setState(() {
                            _showDatePickerDialog(context);
                          })
                        },
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
    bool isValid = await isPersonalInformationFormValid();
    if (!isValid) {
      if (mounted) {
        context.goNamed('account-information');
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
