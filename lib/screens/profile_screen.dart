import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/components/profile_button.dart';
import 'package:oneid_mobile_app/screens/login_screen.dart';

import '../controller/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _Profile();
}

class _Profile extends State<ProfileScreen> {
  final searchController = TextEditingController();
  final UserController userController =
      Get.find<UserController>(); // Replace with your actual controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      "https://ui-avatars.com/api/?name=${userController.user.value!.firstName}+${userController.user.value?.lastName}"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${userController.user.value!.firstName} ${userController.user.value!.lastName}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Middle Buttons
                  const SizedBox(
                    height: 24,
                  ),

                  profileButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/edit-profile');
                    },
                    buttonText: 'User Profile Details',
                    iconData: Icons.person_search,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  profileButton(
                    onTap: () {
                      //Redirect to change password
                    },
                    buttonText: 'Change Password',
                    iconData: Icons.lock,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  profileButton(
                    onTap: () {
                      //Redirect to change language
                    },
                    buttonText: 'Change Language',
                    iconData: Icons.text_format,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  profileButton(
                    onTap: () {
                      //Redirect to change theme
                    },
                    buttonText: 'Change Theme',
                    iconData: Icons.sunny,
                  ),

                  const SizedBox(
                    height: 48,
                  ),
                  profileButton(
                    onTap: () {
                      //Redirect to change password
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    buttonText: 'Logout',
                    iconData: Icons.logout,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
