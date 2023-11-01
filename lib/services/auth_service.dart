import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final RxString email = ''.obs;
  final RxBool isAuthenticated = false.obs;
  String _bearerToken = ''; // Store the bearer token

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    email.value = _prefs?.getString('email') ?? '';
    isAuthenticated.value = _prefs?.getBool('isAuthenticated') ?? false;
    _bearerToken =
        _prefs?.getString('bearerToken') ?? ''; // Initialize the bearer token
  }

  String getBearerToken() {
    if (_bearerToken == '') {
      _bearerToken = _prefs?.getString('bearerToken') ?? '';
    }

    return _bearerToken;
  }

  void updateBearerToken(String newToken) {
    _bearerToken = newToken;
    _prefs?.setString('bearerToken', newToken);
  }

  void setUserEmail(String newEmail) {
    email.value = newEmail;
    _prefs?.setString('email', newEmail);
  }

  void setAuthentication(bool value) {
    isAuthenticated.value = value;
    _prefs?.setBool('isAuthenticated', value);
  }

  void forceLogout() {
    if (kDebugMode) {
      print("Logging out");
    }
    // Clear stored authentication data
    _prefs?.remove('email');
    _prefs?.remove('bearerToken');
    _prefs?.remove('isAuthenticated');

    // Remove all routes and get to LoginScreen()
    Get.offAllNamed('/login');
  }
}
