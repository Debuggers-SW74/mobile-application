import 'package:fastporte/providers/supervisor_info.provider.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app.colors.constant.dart';
import '../../../common/constants/app.constraints.constant.dart';
import '../../../common/constants/app.text_styles.constant.dart';
import '../../../common/constants/button_type.enum.dart';
import '../../../common/constants/default_data.constant.dart';
import '../../../models/entities/supervisor.dart';
import '../../../services/supervisor/update_supervisor.model.dart';
import '../../../util/formatters/first_name.formatter.dart';
import '../../../util/formatters/last_names.formatter.dart';
import '../../../util/validators/input.validators.dart';
import '../../../widgets/app_bar/logged.app_bar.dart';
import '../../../widgets/elevated_button/custom.elevated_button.dart';
import '../../../widgets/text_field/custom.text_form_field.dart';


class SupervisorProfileScreen extends StatefulWidget {
  const SupervisorProfileScreen({super.key, required this.from});

  final String from;

  @override
  State<SupervisorProfileScreen> createState() => _SupervisorProfileScreenState();
}

class _SupervisorProfileScreenState extends State<SupervisorProfileScreen> {
  var logger = Logger();
  late Supervisor? supervisor;
  late UpdateSupervisor updateSupervisor;

  String? _nameError;
  String? _firstLastNameError;
  String? _secondLastNameError;
  String? _emailError;
  String? _phoneNumberError;

  final _nameController = TextEditingController();
  final _firstLastNameController = TextEditingController();
  final _secondLastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  late SupervisorInfoProvider supervisorProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Inicializa supervisorProvider en didChangeDependencies
    supervisorProvider = Provider.of<SupervisorInfoProvider>(context);
    supervisor = supervisorProvider.supervisor;

    // Configura los controladores con los valores de supervisor
    if (supervisor != null) {
      _nameController.text = supervisor!.name;
      _firstLastNameController.text = supervisor!.firstLastName;
      _secondLastNameController.text = supervisor!.secondLastName;
      _emailController.text = supervisor!.email;
      _phoneNumberController.text = supervisor!.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _firstLastNameController.dispose();
    _secondLastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _validateForm() async {
    setState(() {
      _nameError = InputValidators.validateRegisterFirstName(_nameController.text);
      _firstLastNameError = InputValidators.validateRegisterLastName(_firstLastNameController.text);
      _secondLastNameError = InputValidators.validateRegisterLastName(_secondLastNameController.text);
      _emailError = InputValidators.validateEmail(_emailController.text);
      _phoneNumberError = InputValidators.validateRegisterPhoneNumber(_phoneNumberController.text);
    });
    //await _validatePhoneNumber(_phoneNumberController.text);
  }

  Future<bool> isPersonalInformationFormValid() async {
    await _validateForm();

    return _nameError == null &&
        _firstLastNameError == null &&
        _secondLastNameError == null &&
        _emailError == null &&
        _phoneNumberError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoggedAppBar(title: "Profile", backLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Consumer<SupervisorInfoProvider>(
                builder: (context, supervisorProvider, child) {
                  final supervisor = supervisorProvider.supervisor;

                  if(supervisor == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    children: [
                      ScreenTemplate(
                        paddingBottom: 0.0,
                        children: [
                          const SizedBox(height: AppConstrainsts.spacingMedium),
                          Text(
                            'Edit profile',
                            style: AppTextStyles.headlineMedium(context).copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppConstrainsts.spacingMedium),
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: const NetworkImage(DefaultData.DEFAULT_PROFILE_IMAGE),
                          ),
                          const SizedBox(height: AppConstrainsts.spacingMedium),
                          CustomTextFormField(
                            labelText: 'Name',
                            controller: _nameController,
                            errorText: _nameError,
                            prefixIcon: Icons.person_outline_rounded,
                            inputFormatters: [FirstNameInputFormatter()],
                            keyboardType: TextInputType.name,
                            onChanged: (value) => {
                              setState(() {
                                _nameError = null;
                              })
                            },
                          ),
                          const SizedBox(height: AppConstrainsts.spacingMedium),
                          CustomTextFormField(
                            labelText: 'First last name',
                            controller: _firstLastNameController,
                            errorText: _firstLastNameError,
                            prefixIcon: Icons.person_outline_rounded,
                            inputFormatters: [LastNamesInputFormatter()],
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
                            inputFormatters: [LastNamesInputFormatter()],
                            keyboardType: TextInputType.name,
                            onChanged: (value) => {
                              setState(() {
                                _secondLastNameError = null;
                              })
                            },
                          ),
                          const SizedBox(height: AppConstrainsts.spacingMedium),
                          CustomTextFormField(
                            labelText: 'Email',
                            controller: _emailController,
                            errorText: _emailError,
                            prefixIcon: Icons.person_outline_rounded,
                            keyboardType: TextInputType.name,
                            onChanged: (value) => {
                              setState(() {
                                _emailError = null;
                              })
                            },
                          ),
                          const SizedBox(height: AppConstrainsts.spacingMedium),
                          CustomTextFormField(
                            labelText: 'Phone number',
                            controller: _phoneNumberController,
                            errorText: _phoneNumberError,
                            prefixIcon: Icons.numbers_outlined,
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            onChanged: (value) => {
                              setState(() {
                                _phoneNumberError = null;
                              })
                            },
                          ),
                          const SizedBox(height: AppConstrainsts.spacingMedium),
                          CustomElevatedButton(
                            text: 'Save changes',
                            type: ButtonType.primary,
                            onPressed: () {
                              _handlePersonalInformationForm();
                            },
                          ),
                          const SizedBox(height: AppConstrainsts.spacingSmall)
                        ],
                      )
                    ],
                  );
                }
            )
        ),
      ),
    );
  }

  Future<void> _handlePersonalInformationForm() async {
    bool isValid = await isPersonalInformationFormValid();
    if (!isValid) {
      if (mounted) {
        //context.goNamed('account-information');
      } else {
        //Mostrar un mensaje de error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An internal error occurred. Please contact support.'),
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
    } else {
      //Enviar al service
      updateSupervisor = UpdateSupervisor(
        name: _nameController.text,
        firstLastName: _firstLastNameController.text,
        secondLastName: _secondLastNameController.text,
        email: _emailController.text,
        phone: _phoneNumberController.text,
      );

      final success = await supervisorProvider.updateSupervisorProfileInfo(updateSupervisor);

      if (success) {
        _showSuccessDialog();
      } else {
        _showErrorDialog();
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Success',
            style: AppTextStyles.headlineMedium(context).copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Your personal information has been updated successfully.'),
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

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: AppTextStyles.headlineMedium(context).copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('An internal error occurred. Please contact support.'),
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
