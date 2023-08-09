import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  final String screenImage;
  final int currentPosition;
  final String topicText;
  final String contentText;
  final Function()? onTap;
  final String buttonText;

  const OnBoardingScreen({
    super.key,
    required this.screenImage,
    required this.currentPosition,
    required this.topicText,
    required this.contentText,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context){
    return Center(
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

              const SizedBox(height: 40,),
              //Lock screen image
              Image(
                //Passes the image url from onboarding screens
                image: AssetImage(screenImage),
                height: 230,
                width: 300,
              ),
      
              const SizedBox(height: 100,),
              //Bottom Card
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFFAEB8FE).withOpacity(0.73),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),

                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [

                            //Dot Indicator
                            const SizedBox(height: 30,),
                            Center(
                              child: DotsIndicator(
                                dotsCount: 4,
                                //Passes the current position from the onboarding screens
                                position: currentPosition,
                                decorator: DotsDecorator(
                                  color: Colors.grey.shade100,
                                  activeColor: const Color(0xFF27187E),
                                  size: const Size.square(9.0),
                                  activeSize: const Size(18.0, 9.0),
                                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30,),
                            Center(
                              child: Text(
                                //Passes the topic of the onboarding screens
                                topicText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF27187E),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text(
                                  //Passes the content of the onboarding screens
                                  contentText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            //Next/Done Button
                            Center(
                              child: GestureDetector(
                                onTap: onTap,
                                child: SizedBox(
                                  width: 70, 
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFECEAFB).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: const Color(0xFFECEAFB).withOpacity(0.5),
                                        width: 2.0,
                                      )
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        buttonText,
                                        style: const TextStyle(
                                          color: Color(0xFF27187E),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
            
            
          ] //Children
        ),
    );
  }
}