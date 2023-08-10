import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/form_textfield.dart';

import '../components/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                  child: Column(
                    children: [
                      //Avatar Image
                      SizedBox(
                        height: 200,
                        width: 150,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/pro-pic.jpeg'),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 20,
                              child: Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    //Change the image
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const textField(
                        hintText: 'Masha Nilushi Pupulewatte',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const textField(
                        hintText: 'mashanilushi@gmail.com',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const textField(
                        hintText: '996480353V',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const textField(
                        hintText: '+94 763497995',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const textField(
                        hintText: '07/05/1999',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const textField(
                        hintText: '18/9, Gnanawimala Road, Athurugiriya',
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      PrimaryButton(
                        onTap: () {},
                        buttonText: 'Update',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
