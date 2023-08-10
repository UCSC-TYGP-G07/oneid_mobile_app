import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/id_card.dart';
import 'package:oneid_mobile_app/components/searchField.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _Dashboard();
}

class _Dashboard extends State<DashboardScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Hide keyboard when user taps outside of textfield
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  //Welcome text
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Good Morning Masha!',
                        style: TextStyle(
                          color: OneIDColor.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/pro-pic.jpeg'),
                        ),
                      ),
                    ],
                  ),
                  //Search Bar
                  SizedBox(height: 20),
                  MySearchField(
                    controller: searchController,
                    labelText: 'Search',
                    obscureText: false,
                  ),

                  //Ongoing approvals
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ongoing Approvals',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  //Ongoing approval cards
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index < 2
                                ? 20.0
                                : 0.0, // Apply padding to all cards except the last one
                          ),
                          child: IDCard(
                            idType: 'Driving License',
                            refNum: '#13j894nk',
                            applicantName: 'Masha Nilushi Pupulewatte',
                            nic: '996280373V',
                            approvalStatus: 'In progress',
                          ),
                        );
                      },
                    ),
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