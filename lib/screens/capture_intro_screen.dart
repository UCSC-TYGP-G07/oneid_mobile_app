import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:oneid_mobile_app/screens/photo_capture_screen.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class CaptureIntroScreen extends StatefulWidget {
  final Function(String path) setPhotoPath;

  const CaptureIntroScreen({super.key, required this.setPhotoPath});

  @override
  State<CaptureIntroScreen> createState() => _CaptureIntroScreenState();
}

class _CaptureIntroScreenState extends State<CaptureIntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) =>
              PhotoCaptureScreen(setPhotoPath: widget.setPhotoPath)),
    );
  }

  Widget _buildImage(String assetName, [double width = 200]) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Image.asset('assets/images/guide-img-1.png', width: width),
    );
  }

  Widget pageTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          height: 1.5,
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget pageBody(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          height: 1.4,
          fontSize: 17.0,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      bodyPadding: const EdgeInsets.only(top: 120.0),
      key: introKey,
      globalHeader: const SizedBox(
        width: double.infinity,
        height: 500.0,
      ),
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 10000,
      infiniteAutoScroll: true,

      // isProgressTap: false,
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(
          titleWidget: pageTitle("Capture a Close-Up Photo"),
          bodyWidget: pageBody(
              "Ask someone to help you capture a close-up photo of your head and partial shoulders. \n\nMake sure you are centered and at an appropriate distance from the camera."),
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: pageTitle("Natural Lighting, No Shadows"),
          bodyWidget: pageBody(
              "Take the photo in natural light to avoid shadows on your face or behind you."),
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget:
              pageTitle("Visible Facial Features and Neutral Expression"),
          bodyWidget: pageBody(
              "Ensure that your facial features are clearly visible, your hair doesn't cover your eyes, and maintain a neutral expression with your mouth closed."),
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: pageTitle("Clear Glasses, No Face Coverings"),
          bodyWidget: pageBody(
              "If you wear glasses, choose clear and thin frames without reflections or covering your eyes. Also, avoid head coverings, hair accessories, and facial ornaments that hide your face."),
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: pageTitle("Plain and Light Background"),
          bodyWidget: pageBody(
              "Use a background that is plain and light without any patterns, objects, textures, or other people."),
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        // PageViewModel(
        //   title: "Full Screen Page",
        //   body:
        //   "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
        //   image: _buildFullscreenImage(),
        //   decoration: pageDecoration.copyWith(
        //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
        //     fullScreen: true,
        //     bodyFlex: 2,
        //     imageFlex: 3,
        //     safeArea: 100,
        //   ),
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(8.0, 8.0),
        color: OneIDColor.grey,
        activeSize: Size(16.0, 8.0),
        activeColor: OneIDColor.secondaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
