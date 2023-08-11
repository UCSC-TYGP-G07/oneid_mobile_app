import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/bottom_nav_bar.dart';
import 'package:oneid_mobile_app/components/id_card.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';



class Wallet extends StatefulWidget {
  Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _Wallet();
}

class _Wallet extends State<Wallet>{

  final List<Widget> fancyCards = <Widget>[
    FancyCard(
      image: Image.asset("lib/assets/proPic.jpeg"),
      title: "Say hello to planets!",
    ),
    FancyCard(
      image: Image.asset("lib/assets/proPic.jpeg"),
      title: "Don't be sad!",
    ),
    FancyCard(
      image: Image.asset("lib/assets/proPic.jpeg"),
      title: "Go for a walk!",
    ),
  ];
  
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: BottomNavBar(selectedIndex:1),

      body: StackedCardCarousel(
        items: fancyCards,
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
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              child: image,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            OutlinedButton(
              child: const Text("Learn more"),
              onPressed: () => print("Button was tapped"),
            ),
          ],
        ),
      ),
    );
  }
}