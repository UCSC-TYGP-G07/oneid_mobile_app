import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/bottom_nav_bar.dart';

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
      bottomNavigationBar: BottomNavBar(selectedIndex:2),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              //Ongoing approvals
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Apply for IDs',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ),

            ],
          ),
        )
      ),
    );
  }
}