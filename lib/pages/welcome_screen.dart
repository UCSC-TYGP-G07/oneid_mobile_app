import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/button_blue.dart';
import 'package:oneid_mobile_app/components/button_white.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget{
  WelcomePage({super.key});

  //Sign user in method
  void signUserIn(){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
          
                // Back button icon
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        // Navigate back to previous screen
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
          
                //Lock screen image
                const Image(
                  image: AssetImage('lib/assets/loginImage.jpg'),
                  height: 350,
                  width: 400,
                ),
              
                //Welcome Text
                Text(
                  'Welcome to OneID',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
          
                const SizedBox(height: 15),
          
                //Login Button
                SizedBox(
                  child: BlueButton(
                    buttonText: 'Login',
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                ),
          
                const SizedBox(height: 10,),
                Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
          
                //Verify ID Button
                const SizedBox(height: 10,),
                SizedBox(
                  child: BlueButton(
                    buttonText: 'Verify ID',
                    onTap: (){
                      
                    },
                  ),
                ),
          
                const SizedBox(height: 10,),
                Text(
                  'NEW USER?',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
          
                const SizedBox(height: 5,),
                SizedBox(
                  child: WhiteButton(
                    buttonText: 'Register',
                    onTap: (){
                      
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                
              ] //Children
            ),
          ),
        )
      )
    );
  }
}

