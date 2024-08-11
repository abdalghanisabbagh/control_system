import 'package:flutter/material.dart';

abstract class AppConstants {
  static const Duration durationFourSeconds = Duration(seconds: 4);
  static const Duration durationOneSecond = Duration(seconds: 1);
  static const Duration durationThreeSeconds = Duration(seconds: 3);
  static const Duration durationTwoSeconds = Duration(seconds: 2);
  static const Duration mediumDuration = Durations.medium1;

  static const List<String> roleTypes = [
    'Control admin',
    'School Director',
    'Academic Dean',
    'Principal',
    'QR Reader',
    'Vice Principal'
  ];

  static const List<String> schoolDivision = [
    "Elementary",
    "Middle",
    "High",
    "Key Stage 1",
    "Key Stage 2",
    "Key Stage 3",
    "IGCSE",
  ];
}
