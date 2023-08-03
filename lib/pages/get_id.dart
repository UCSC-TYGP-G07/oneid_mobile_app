import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/bottom_nav_bar.dart';
import 'package:oneid_mobile_app/components/button_blue.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';

class GetIDs extends StatefulWidget {
  GetIDs({Key? key}) : super(key: key);

  @override
  State<GetIDs> createState() => _GetIDs();
}

class _GetIDs extends State<GetIDs>{
  
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: const BottomNavBar(selectedIndex:2),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              //Progress Bar
              const SizedBox(height: 30,),
              ProgressBar(
                step: 0,
              ),
              
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Select the personal identification document you need to apply for',
                    style: TextStyle(
                      color: const Color(0xFF27187E),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                )
              ),

              //Buttons
              const SizedBox(height: 60,),
              SizedBox(
                width: 200,
                child: BlueButton(
                  buttonText: 'Driving License',
                  onTap: (){
                    
                  },
                ),
              ),

              const SizedBox(height: 40,),
              SizedBox(
                width: 200,
                child: BlueButton(
                  buttonText: 'NIC',
                  onTap: (){
                    
                  },
                ),
              ),

              const SizedBox(height: 40,),
              SizedBox(
                width: 200,
                child: BlueButton(
                  buttonText: 'Passport',
                  onTap: (){
                    
                  },
                ),
              ),

              const SizedBox(height: 40,),
              SizedBox(
                width: 200,
                child: BlueButton(
                  buttonText: 'Third Party IDs',
                  onTap: (){
                    
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}