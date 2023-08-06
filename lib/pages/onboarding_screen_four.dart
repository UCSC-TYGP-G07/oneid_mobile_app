import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:oneid_mobile_app/components/onboarding_screen.dart';
import 'welcome_screen.dart';

class OnboardingScreenFour extends StatelessWidget{
  const OnboardingScreenFour({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OnboardingScreen(
          screenImage: 'lib/assets/onboardingScreenFour.png',
          currentPosition: 3,
          topicText: 'Share to Verify Identity Electronically',
          contentText: 'You can share your PIDs anytime anywhere...',
          onTap: (){
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: WelcomePage(),
                isIos: true,
              ),
            );
          },
          buttonText: 'Done',
        ),

        
        ),
    );
  }
}

