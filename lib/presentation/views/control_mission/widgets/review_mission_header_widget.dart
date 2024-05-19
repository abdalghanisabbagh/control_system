import 'package:flutter/material.dart';

class ReviewMissionHeaderWidget extends StatelessWidget {
  const ReviewMissionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: const Text(
        'Review Mission',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
