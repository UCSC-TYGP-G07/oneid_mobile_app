import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class IDWalletScreen extends StatefulWidget {
  const IDWalletScreen({Key? key}) : super(key: key);

  @override
  State<IDWalletScreen> createState() => _Wallet();
}

class _Wallet extends State<IDWalletScreen> {
  final searchController = TextEditingController();

  final List<Widget> fancyCards = <Widget>[
    FancyCard(
      image: Image.asset(
        "assets/images/pro-pic.jpeg",
        height: 100,
      ),
      title: "Driving License",
    ),
    FancyCard(
      image: Image.asset("assets/images/pro-pic.jpeg"),
      title: "NIC Card",
    ),
    FancyCard(
      image: Image.asset("assets/images/pro-pic.jpeg"),
      title: "UCSC Student ID",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
        child: StackedCardCarousel(
          items: fancyCards,
          spaceBetweenItems: 196,
        ),
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
                  title: const Text(
                    "Share ID",
                    textAlign: TextAlign.center,
                  ),
                  content: Image.asset("assets/images/qr.jpg"),
                )));
      },
      child: Card(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                Row(
                  children: [
                    // Image on the left
                    Container(
                        width: 100,
                        height: 130,
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          // Adjust the radius as needed
                          child: image,
                        )),
                    // ID card details on the right
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name: ',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                'Masha Nilushi',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: OneIDColor.primaryColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'ID Number: ',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                '12345',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: OneIDColor.primaryColor),
                              ),
                            ],
                          ),
                        ],
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
