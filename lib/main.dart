import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/screens/loading_screen.dart';
import 'package:oneid_mobile_app/screens/main/main_screen.dart';
import 'package:oneid_mobile_app/screens/onboarding_screen.dart';
import 'package:oneid_mobile_app/screens/profile_screen.dart';
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
        '/welcome': (context) => const WelcomeScreen(),
        '/profile': (BuildContext context) => Profile(),
        '/on-boarding': (BuildContext context) => const OnBoardingScreen(),
      },
    );
  }
}