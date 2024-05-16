import 'dart:async' show Timer;

import 'package:flutter/material.dart' show DayPeriod, TimeOfDay;
import 'package:get/get.dart';

class DashboardController extends GetxController {
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  String? period;

  @override
  void onInit() {
    super.onInit();
    updateTime();
    updateClock();
  }

  updateTime() {
    period = timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeOfDay.minute != TimeOfDay.now().minute) {
        update();
        timeOfDay = TimeOfDay.now();
      }
    });
  }

  updateClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
      dateTime = DateTime.now();
    });
  }
}
