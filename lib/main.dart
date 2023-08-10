import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/screens/apply_dl.dart';
import 'package:oneid_mobile_app/screens/apply_nic_1.dart';
import 'package:oneid_mobile_app/screens/apply_nic_2.dart';
import 'package:oneid_mobile_app/screens/edit_profile_screen.dart';
import 'package:oneid_mobile_app/screens/loading_screen.dart';
import 'package:oneid_mobile_app/screens/login_screen.dart';
import 'package:oneid_mobile_app/screens/main/main_screen.dart';
import 'package:oneid_mobile_app/screens/onboarding_screen.dart';
import 'package:oneid_mobile_app/screens/profile_screen.dart';
import 'package:oneid_mobile_app/screens/scan_birth_cert.dart';
import 'package:oneid_mobile_app/screens/welcome_screen.dart';
import 'package:oneid_mobile_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneID',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/loading',
      routes: <String, WidgetBuilder>{
        '/': (context) => const MainScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/on-boarding': (BuildContext context) => const OnBoardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (BuildContext context) => const ProfileScreen(),
        '/edit-profile': (BuildContext context) => const EditProfileScreen(),
        '/apply-dl': (BuildContext context) => const ApplyDLScreen(),
        '/apply-nic-1': (BuildContext context) => const ApplyNICScreen1(),
        '/apply-nic-2': (BuildContext context) => const ApplyNICScreen2(),
        '/scan-birth-cert': (BuildContext context) => ScanBirthCert(),
      },
    );
  }
}