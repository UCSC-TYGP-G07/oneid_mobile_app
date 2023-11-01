import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/controller/register_controller.dart';
import 'package:oneid_mobile_app/screens/apply_dl.dart';
import 'package:oneid_mobile_app/screens/apply_nic_1.dart';
import 'package:oneid_mobile_app/screens/edit_profile_screen.dart';
import 'package:oneid_mobile_app/screens/loading_screen.dart';
import 'package:oneid_mobile_app/screens/login_screen.dart';
import 'package:oneid_mobile_app/screens/main/main_screen.dart';
import 'package:oneid_mobile_app/screens/onboarding_screen.dart';
import 'package:oneid_mobile_app/screens/profile_screen.dart';
import 'package:oneid_mobile_app/screens/register_screen.dart';
import 'package:oneid_mobile_app/screens/scan_birth_cert_screen.dart';
import 'package:oneid_mobile_app/screens/welcome_screen.dart';
import 'package:oneid_mobile_app/services/api_service.dart';
import 'package:oneid_mobile_app/services/auth_service.dart';
import 'package:oneid_mobile_app/theme/app_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthService());
    Get.put(ApiService());
    Get.put(RegisterController());

    AuthService authService = Get.put<AuthService>(AuthService());
    authService.init();

    // Force portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return GetMaterialApp(
      title: 'OneID',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute:
          (authService.isAuthenticated.value == true) ? '/main' : '/welcome',
      routes: <String, WidgetBuilder>{
        '/main': (context) => const MainScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/on-boarding': (context) => const OnBoardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/apply-dl': (context) => const ApplyDLScreen(),
        '/apply-nic': (context) => const ApplyNICScreen1(),
        '/scan-birth-cert': (context) => const ScanBirthCertScreen(),
      },
    );
  }
}
