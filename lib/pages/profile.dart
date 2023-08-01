import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/bottom_nav_bar.dart';
import 'package:oneid_mobile_app/components/profile_button.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile>{
  
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: BottomNavBar(selectedIndex:3),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              
              //Top Card
              SizedBox(height: 25,),
              Container(
                width: 350,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage('lib/assets/proPic.jpeg'),
                              radius: 50,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 25,
                        width: 20,
                      ),
                      Text(
                        'Ms. Pupulewatte',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              //Middle Buttons
              SizedBox(height: 25,),
              SizedBox(
                width: 400,
                height: 70,
                child: profileButton(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                  buttonText: 'User Profile Details',
                  iconData: Icons.person_search,
                ),
              ),

              SizedBox(height: 10,),
              SizedBox(
                width: 400,
                height: 70,
                child: profileButton(
                  onTap: (){
                    //Redirect to change password
                  },
                  buttonText: 'Change Password',
                  iconData: Icons.lock,
                ),
              ),

              SizedBox(height: 10,),
              SizedBox(
                width: 400,
                height: 70,
                child: profileButton(
                  onTap: (){
                    //Redirect to change language
                  },
                  buttonText: 'Change Language',
                  iconData: Icons.text_format,
                ),
              ),

              SizedBox(height: 10,),
              SizedBox(
                width: 400,
                height: 70,
                child: profileButton(
                  onTap: (){
                    //Redirect to change theme
                  },
                  buttonText: 'Change Theme',
                  iconData: Icons.sunny,
                ),
              ),

              SizedBox(height: 60,),
              SizedBox(
                width: 400,
                height: 70,
                child: profileButton(
                  onTap: (){
                    //Redirect to change password
                  },
                  buttonText: 'Log Out',
                  iconData: Icons.logout,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}