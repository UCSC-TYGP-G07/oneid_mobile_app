import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'onboarding_screen_four.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OnBoardingScreen(
          screenImage: 'lib/assets/onboardingScreenThree.png',
          currentPosition: 2,
          topicText: 'Store Digital Versions of PIDs',
          contentText:
              'You can store the digital versions of your PIDs including NIC, Passport, Driving License and even 3rd party IDs',
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const OnboardingScreenFour(),
                isIos: true,
              ),
            );
          },
          buttonText: 'Next',
        ),

        
        ),
    );
  }
}

