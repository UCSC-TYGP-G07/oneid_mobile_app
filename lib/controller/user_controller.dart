import 'package:get/get.dart';

import '../models/login_res.dart';

class UserController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  // Method to set user data
  void setUser(User? newUser) {
    print("Setting user data");
    if (newUser != null) {
      user.value = newUser;
    }
  }

  // Method to clear user data (e.g., on logout)
  void clearUserData() {
    user.value = null;
  }
}
