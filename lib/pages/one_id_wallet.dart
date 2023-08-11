import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/bottom_nav_bar.dart';
import 'package:oneid_mobile_app/components/id_card.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class Wallet extends StatefulWidget {
  Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _Wallet();
}

class _Wallet extends State<Wallet> {
  final List<Widget> fancyCards = <Widget>[
    FancyCard(
      image: Image.asset(
        "lib/assets/proPic.jpeg",
        height: 100,
      ),
      title: "Driving License",
    ),
    FancyCard(
      image: Image.asset("lib/assets/proPic.jpeg"),
      title: "NIC Card",
    ),
    FancyCard(
      image: Image.asset("lib/assets/proPic.jpeg"),
      title: "Passport",
    ),
  ];

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
      body: StackedCardCarousel(
        items: fancyCards,
        spaceBetweenItems: 200,
      ),
    );
  }
}

class FancyCard extends StatelessWidget {
  const FancyCard({
    super.key,
    required this.image,
    required this.title,
  });

  final Image image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: Text("QR Code"),
                  content: Image.asset("lib/assets/qr.jpg"),
                )));
      },
      child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(title),
                Row(
                  children: [
                    // Image on the left
                    Container(
                      width: 100,
                      height: 170,
                      child: image,
                      padding: EdgeInsets.all(10),
                    ),
                    // ID card details on the right
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'ID Number: ',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
