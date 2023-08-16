import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'onboarding_screen_two.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OnBoardingScreen(
          screenImage: 'lib/assets/onboardingScreenOne.png',
          currentPosition: 0,
          topicText: 'Apply for PIDs Online',
          contentText:
              'You can apply for personal identification documents such as NIC, Passport and Driving License',
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const OnboardingScreenTwo(),
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

