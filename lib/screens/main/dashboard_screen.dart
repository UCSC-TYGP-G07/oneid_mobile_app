import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/components/id_card.dart';
import 'package:oneid_mobile_app/components/searchField.dart';
import 'package:oneid_mobile_app/screens/verify_id_screen.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import '../../controller/user_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _Dashboard();
}

class _Dashboard extends State<DashboardScreen> {
  final searchController = TextEditingController();
  final UserController userController = Get.find<UserController>();

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${getGreeting()}${userController.user.value!.firstName} ${userController.user.value?.lastName}',
                              style: const TextStyle(
                                color: OneIDColor.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              'Welcome to OneID',
                              style: TextStyle(
                                color: OneIDColor.darkGrey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/profile');
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                                "https://ui-avatars.com/api/?name=${userController.user.value!.firstName}+${userController.user.value?.lastName}"),
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
                    const SizedBox(
                      height: 30,
                    ),
                    const Align(
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
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 215,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < 2
                                  ? 16.0
                                  : 0.0, // Apply padding to all cards except the last one
                            ),
                            child: IDCard(
                              idType: 'Driving License',
                              refNum: '#13j894nk',
                              applicantName:
                                  '${userController.user.value!.firstName} ${userController.user.value!.lastName}',
                              nic: '996280373V',
                              approvalStatus: 'In progress',
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(
                        color: OneIDColor.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Icon(
                                Icons.person,
                                color: OneIDColor.primaryColor,
                                size: 64,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Share my ID',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const VerifyIDScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                const Icon(
                                  Icons.qr_code_scanner_rounded,
                                  color: OneIDColor.primaryColor,
                                  size: 64,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  'Verify ID',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) {
      return 'Good Morning, ';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon, ';
    } else {
      return 'Good Evening, ';
    }
  }
}
