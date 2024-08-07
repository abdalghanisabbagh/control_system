import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class ReviewMissionHeaderWidget extends StatelessWidget {
  final String title;

  const ReviewMissionHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        title,
        style: nunitoBold.copyWith(
          fontSize: 30,
        ),
      ),
    );
  }
}
