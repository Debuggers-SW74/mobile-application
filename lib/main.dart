import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/providers/driver_info.provider.dart';
import 'package:fastporte/providers/driver_info.provider.dart';
import 'package:fastporte/screens/navigation/app.navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (_) => DriverInfoProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme =
    GoogleFonts.interTextTheme(Theme.of(context).textTheme);
    final customTextTheme = baseTextTheme.copyWith(
      headlineLarge: AppTextStyles.headlineLarge(context),
      headlineMedium: AppTextStyles.headlineMedium(context),
      headlineSmall: AppTextStyles.headlineSmall(context),
      titleLarge: AppTextStyles.titleLarge(context),
      titleMedium: AppTextStyles.titleMedium(context),
      titleSmall: AppTextStyles.titleSmall(context),
      bodyLarge: AppTextStyles.bodyLarge(context),
      bodyMedium: AppTextStyles.bodyMedium(context),
      bodySmall: AppTextStyles.bodySmall(context),
      labelLarge: AppTextStyles.labelLarge(context),
    );

    return MaterialApp.router(
      title: 'FastPorte',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
          onPrimary: AppColors.onPrimary,
          onSecondary: AppColors.onSecondary,
          onSurface: AppColors.onSurface,
          onError: AppColors.onError,
        ),
        textTheme: customTextTheme,
      ),

      // initialRoute: AppRoutes.login,
      // routes: {
      //   AppRoutes.login: (context) => const LoginPage(),
      //   AppRoutes.home: (context) => const HomePage(),
      //   AppRoutes.registerPersonalInformation: (context) => const PersonalInformationPage(),
      //   AppRoutes.registerAccountInformation: (context) => const AccountInformationPage(),
      //   AppRoutes.resetForgotPassword: (context) => const ForgotPassword(),
      //   AppRoutes.resetInsertNewPassword: (context) => const InsertNewPassword(),
      // },

      //home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}
