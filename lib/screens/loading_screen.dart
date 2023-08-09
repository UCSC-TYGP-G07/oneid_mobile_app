import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    showOnBoarding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/oneid-logo.png"),
              ),
            ),
          ),
      ),
    );
  }

  Future<void> showOnBoarding() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? showOnBoarding = prefs.getBool("show_on_boarding");

    if (showOnBoarding == null || showOnBoarding == true) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/on-boarding');
    }else{
      return;
    }
  }
}
