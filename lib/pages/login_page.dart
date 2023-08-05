import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/button_blue.dart';
import 'package:oneid_mobile_app/components/textfield.dart';
import 'dashboard.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  //Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                const SizedBox(height: 25),
                Text(
                  'Welcome to OneID',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
          
                const SizedBox(height: 25),
          
                //Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false,
                ),
          
                const SizedBox(height: 25),
          
                //Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 25),
          
                //Forgot password text
                const Text('Forgot Password?'),
          
                const SizedBox(height: 25),
          
                //Login Button
                SizedBox(
                  width: 200,
                  child: BlueButton(
                    buttonText: 'Login',
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),
                
              ] //Children
            ),
          ),
        )
      )
    );
  }
}

