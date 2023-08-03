import 'package:flutter/material.dart';
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

    List<TrackerState> stepStates = List.generate(5, (index){
      if(index < step){
        return TrackerState.complete;
      }
      else {
        return TrackerState.none;
      }
    });

    return Container(
      child: StepTracker(
        dotSize: 15,
        selectedColor: Color(0xFF27187E),
        stepTrackerType: StepTrackerType.indexedHorizontal,
        pipeSize: 40,
        steps: [
          Steps(title: Text(""), state: stepStates[0]),
          Steps(title: Text(""), state: stepStates[1]),
          Steps(title: Text(""), state: stepStates[2]),
          Steps(title: Text(""), state: stepStates[3]),
          Steps(title: Text(""), state: stepStates[4]),
        ],
      ),
    );
  }

}