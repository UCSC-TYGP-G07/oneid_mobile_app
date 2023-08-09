import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/bottom_nav_bar.dart';
import 'package:oneid_mobile_app/components/id_card.dart';
import 'package:oneid_mobile_app/components/textfield.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard>{
  
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: BottomNavBar(selectedIndex:0),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              //Welcome text
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Good Morning Sandul!',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 20,
                    ),
                  ),
                )),

            //Search Bar
            SizedBox(height: 25),
            MyTextField(
              controller: searchController,
              labelText: 'Search',
              obscureText: false,
            ),

            //Ongoing approvals
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ongoing Approvals',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ),

              //Ongoing approval cards
              SizedBox(height: 25,),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return IDCard(
                      idType: 'Driving License',
                      refNum: '#13j894nk',
                      applicantName: 'Masha Nilushi Pupulewatte',
                      nic: '996280373V',
                      approvalStatus: 'In progress',
                    );
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