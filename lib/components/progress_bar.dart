import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';
import 'package:step_tracker/step_tracker.dart';

class ProgressBar extends StatelessWidget {
  final int step;

  const ProgressBar({
    super.key,
    required this.step,
  });

  //final BuildContext context;
  

  @override
  Widget build(BuildContext context) {
    List<TrackerState> stepStates = List.generate(5, (index) {
      if (index < step) {
        return TrackerState.complete;
      } else {
        return TrackerState.none;
      }
    });

    return StepTracker(
      dotSize: 16,
      selectedColor: OneIDColor.secondaryColor,
      stepTrackerType: StepTrackerType.indexedHorizontal,
      pipeSize: 42,
      steps: [
        Steps(
            title: Text(
              "Basic Details",
              style: TextStyle(
                color: step == 0 ? OneIDColor.primaryColor : OneIDColor.black,
                fontSize: step == 0 ? 14 : 12,
                fontWeight: step == 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            state: stepStates[0]),
        Steps(
            title: Text(
              "Documents",
              style: TextStyle(
                color: step == 1 ? OneIDColor.primaryColor : OneIDColor.black,
                fontSize: step == 1 ? 14 : 12,
                fontWeight: step == 1 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            state: stepStates[1]),
        Steps(
            title: Text(
              "Photo",
              style: TextStyle(
                color: step == 2 ? OneIDColor.primaryColor : OneIDColor.black,
                fontSize: step == 2 ? 14 : 12,
                fontWeight: step == 2 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            state: stepStates[2]),
        Steps(
            title: Text(
              "Confirmation",
              style: TextStyle(
                color: step == 3 ? OneIDColor.primaryColor : OneIDColor.black,
                fontSize: step == 3 ? 14 : 12,
                fontWeight: step == 3 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            state: stepStates[3]),
      ],
    );
  }

}