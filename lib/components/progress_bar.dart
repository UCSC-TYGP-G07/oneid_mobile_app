import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProgressBar extends StatelessWidget {
  final int step;

  const ProgressBar({
    super.key,
    required this.step,
  });

  //final BuildContext context;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StepProgressIndicator(
        totalSteps: 5,
        currentStep: step,
        selectedColor: const Color(0xFF27187E),
        unselectedColor: Colors.grey,
      ),
    );
  }

}