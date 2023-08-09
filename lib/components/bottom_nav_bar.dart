import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:oneid_mobile_app/screens/get_id.dart';
import 'package:oneid_mobile_app/screens/main/dashboard_screen.dart';
import 'package:oneid_mobile_app/screens/main/id_wallet_screen.dart';
import 'package:oneid_mobile_app/screens/profile_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {
      //required this.context,
      required this.selectedIndex,
      super.key});

  //final BuildContext context;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ]
        ),

        child: GNav(
          haptic: true,
          color: Colors.grey,
          activeColor: Colors.black,
          gap: 8,
          selectedIndex: selectedIndex,
          onTabChange: (index){
            print(index);
            _navigateToScreen(context, index);
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home'
            ),
            GButton(
              icon: Icons.wallet,
              text: 'My Wallet',
            ),
            GButton(
              icon: Icons.edit_document,
              text: 'Get IDs',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      );
  }

  // Function to navigate to the selected screen based on the tapped icon
  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0: // HomeScreen
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
        break;
      case 1: // WalletScreen
        Navigator.push(context, MaterialPageRoute(builder: (context) => Wallet()));
        break;
      case 2: // GetIDsScreen
        Navigator.push(context, MaterialPageRoute(builder: (context) => GetIDs()));
        break;
      case 3: // ProfileScreen
        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
        break;
      default:
        break;
    }
  }

}