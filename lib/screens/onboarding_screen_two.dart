import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'onboarding_screen_three.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OnBoardingScreen(
          screenImage: 'lib/assets/onboardingScreenTwo.png',
          currentPosition: 1,
          topicText: 'Get Studio Quality ID Photos',
          contentText:
              'You can capture studio quality ID photos that follows ICAO standards which is ...',
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const OnboardingScreenThree(),
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

