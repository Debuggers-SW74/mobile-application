import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app.colors.constant.dart';
import '../../../common/constants/app.constraints.constant.dart';
import '../../../common/constants/app.routes.constant.dart';
import '../../../common/constants/app.text_styles.constant.dart';
import '../../../common/constants/button_type.enum.dart';
import '../../../providers/registration.provider.dart';
import '../../../widgets/app_bar/main.app_bar.dart';
import '../../../widgets/elevated_button/custom.elevated_button.dart';

class SelectTypeProfile extends StatefulWidget {
  const SelectTypeProfile({super.key});

  @override
  State<SelectTypeProfile> createState() => _SelectTypeProfileState();
}

class _SelectTypeProfileState extends State<SelectTypeProfile> {
  String selectedProfileType = '';

  void selectProfileType(String type) {
    setState(() {
      selectedProfileType = type;
    });
  }

  @override
  Widget build(BuildContext context) {

    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      appBar: const MainAppBar(backLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0, bottom: 16.0, right: 60.0, left: 60.0),
            child: Center(
              child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Image.asset(
                      'assets/images/fastporte-logo.png',
                      height: 60,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingMedium),
                    Text(
                      'Select Type of Profile',
                      style: AppTextStyles.headlineMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstrainsts.spacingLarge),

                    // Selección de Tipo de Perfil
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => selectProfileType('ROLE_DRIVER'),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedProfileType == 'ROLE_DRIVER' ? AppColors.primary : Colors.grey,
                                    width: 4,
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 60,
                                      color: selectedProfileType == 'ROLE_DRIVER' ? AppColors.primary : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Driver'),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => selectProfileType('ROLE_SUPERVISOR'),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedProfileType == 'ROLE_SUPERVISOR' ? AppColors.primary : Colors.grey,
                                    width: 4,
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.apartment,
                                      size: 60,
                                      color: selectedProfileType == 'ROLE_SUPERVISOR' ? AppColors.primary : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Supervisor'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: AppConstrainsts.spacingLarge),
                    CustomElevatedButton(
                      text: 'Continue',
                      type: ButtonType.primary,
                      onPressed: () {
                        if (selectedProfileType.isNotEmpty) {
                          registrationProvider.setRole(selectedProfileType);
                          context.goNamed(AppRoutes.registerAccountInformation);
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
