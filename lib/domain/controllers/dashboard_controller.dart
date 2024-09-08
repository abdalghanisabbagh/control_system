import 'dart:async' show Timer;

import 'package:control_system/domain/controllers/controllers.dart';
import 'package:flutter/material.dart' show DayPeriod, TimeOfDay;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardController extends GetxController {
  DateTime dateTime = DateTime.now();
  String? period;
  String? schoolTypeName;
  String? schoolName;
  TimeOfDay timeOfDay = TimeOfDay.now();
  String? userName;

  @override
  void onInit() {
    super.onInit();
    schoolTypeName = Hive.box('School').get('SchoolTypeName');
    schoolName = Hive.box('School').get('Name');
    userName = Get.find<ProfileController>().cachedUserProfile?.fullName;
    update();
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
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timeOfDay.minute != TimeOfDay.now().minute) {
          update(['clock']);
          timeOfDay = TimeOfDay.now();
        }
      },
    );
  }
}
