import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/bottom_nav_bar.dart';
import 'package:oneid_mobile_app/components/button_white.dart';
import 'package:oneid_mobile_app/components/form_textfield.dart';

import '../components/primary_button.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: BottomNavBar(selectedIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                // Back button icon
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      // Navigate back to previous screen
                      Navigator.of(context).pop();
                    },
                  ),
                ),
        
                //Avatar Image
                SizedBox(
                  height: 200,
                  width: 155,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('lib/assets/proPic.jpeg'),
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
                                onPressed: (){
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
        
                //User detials form
                const Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        
                        textField(
                          hintText: 'Masha Nilushi Pupulewatte',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: 'mashanilushi@gmail.com',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: '996480353V',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: '+94 763497995',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: '07/05/1999',
                        ),
                        SizedBox(height: 20,),
                        textField(
                          hintText: '18/9, Gnanawimala Road, Athurugiriya',
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      onTap: () {},
                      buttonText: 'Update',
                    ),
                    SizedBox(width: 10),
                    WhiteButton(
                      onTap: () {},
                      buttonText: 'Cancel',
                    ),
                  ],
                ),
                SizedBox(height: 20,),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}