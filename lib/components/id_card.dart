import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IDCard extends StatelessWidget {
  final String idType;
  final String refNum;
  final String applicantName;
  final String nic;
  final String approvalStatus;

  IDCard({
    required this.idType,
    required this.refNum,
    required this.applicantName,
    required this.nic,
    required this.approvalStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Driving License',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text('Ref No: #89hnfhfu',
                style: TextStyle(
                  color: OneIDColor.grey,
                )),
            SizedBox(
              height: 4,
            ),
            Divider(
              color: OneIDColor.grey,
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 32.0,
                    lineWidth: 5.0,
                    percent: 0.5,
                    center: new Text("50%"),
                    progressColor: Colors.green,
                    animation: true,
                  ),
                  SizedBox(width: 24),
                  Text('Approval In Progress',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: '),
                Text(
                  'Masha Nilushi',
                  style: TextStyle(color: OneIDColor.primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('NIC: '),
                Text(
                  '996280373V',
                  style: TextStyle(color: OneIDColor.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}