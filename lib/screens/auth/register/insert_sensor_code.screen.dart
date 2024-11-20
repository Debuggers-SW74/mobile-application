import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/widgets/app_bar/main.app_bar.dart';
import 'package:fastporte/widgets/container/shadow.box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app.colors.constant.dart';
import '../../../common/constants/app.constraints.constant.dart';
import '../../../common/constants/app.text_styles.constant.dart';
import '../../../common/constants/button_type.enum.dart';
import '../../../providers/registration.provider.dart';
import '../../../widgets/elevated_button/custom.elevated_button.dart';

class InsertSensorCode extends StatefulWidget {
  const InsertSensorCode({super.key});

  @override
  State<InsertSensorCode> createState() => _InsertSensorCodeState();
}

class _InsertSensorCodeState extends State<InsertSensorCode> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String currentText = "";

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
                    'Insert your Sensor Code!',
                    style: AppTextStyles.headlineMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstrainsts.spacingLarge),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: shadowBoxDecoration(),
                    child: Form(
                      key: _formKey,
                      child: PinCodeTextField(
                        appContext: context,
                        controller: _codeController,
                        length: 6,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          selectedFillColor: Colors.grey[200],
                          inactiveFillColor: Colors.grey[100],
                          activeColor: AppColors.primary,
                          selectedColor: AppColors.primary,
                          inactiveColor: Colors.grey,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                    text: 'Continue',
                    type: ButtonType.primary,
                    onPressed: () async {
                      if (_codeController.text.length == 6) {
                        registrationProvider.setSensorCode(_codeController.text);
                        context.goNamed(AppRoutes.registerTypeProfile);

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a valid 6-character code"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}