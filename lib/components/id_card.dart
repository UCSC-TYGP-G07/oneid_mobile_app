import 'package:flutter/material.dart';

class IDCard extends StatelessWidget{

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
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Driving License'),
                Text('Ref No: #89hnfhfu'),
              ],
            ),
            SizedBox(
              height: 128,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name: Masha Nilushi'),
                Text('Approval In Progress'),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NIC: 996280373V'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}