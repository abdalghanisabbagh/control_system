import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:flutter/material.dart';

class ReviewMissionHeaderWidget extends StatelessWidget {
  const ReviewMissionHeaderWidget({super.key, required this.title});

  final String title;

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
