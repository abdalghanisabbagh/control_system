import 'dart:async' show Timer;

import 'package:flutter/material.dart' show DayPeriod, TimeOfDay;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardController extends GetxController {
  DateTime dateTime = DateTime.now();
  String? period;
  final String? schoolName = Hive.box('School').get('Name');
  TimeOfDay timeOfDay = TimeOfDay.now();
  final String? userName = Hive.box('Profile').get('User_Name');

  @override
  void onInit() {
    super.onInit();
    updateTime();
    updateClock();
  }

  updateClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      update(['clock']);
      dateTime = DateTime.now();
    });
  }

  updateTime() {
    period = timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeOfDay.minute != TimeOfDay.now().minute) {
        update(['clock']);
        timeOfDay = TimeOfDay.now();
      }
    });
  }
}
