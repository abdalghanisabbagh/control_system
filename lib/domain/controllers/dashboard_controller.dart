import 'dart:async' show Timer;

import 'package:flutter/material.dart' show DayPeriod, TimeOfDay;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers.dart';

class DashboardController extends GetxController {
  DateTime dateTime = DateTime.now();
  String? period;
  String? schoolName;
  String? schoolTypeName;
  TimeOfDay timeOfDay = TimeOfDay.now();
  String? userName;

  @override

  /// Called when the widget is initialized.
  ///
  /// Sets [schoolTypeName], [schoolName] and [userName] from the cached values in
  /// Hive.
  ///
  /// Calls [update] to notify the UI about the changes.
  ///
  /// Calls [updateTime] and [updateClock] to start updating the clock and time.
  void onInit() {
    super.onInit();
    schoolTypeName = Hive.box('School').get('SchoolTypeName');
    schoolName = Hive.box('School').get('Name');
    userName = Get.find<ProfileController>().cachedUserProfile?.fullName;
    update();
    updateTime();
    updateClock();
  }

  /// Updates the [dateTime] every second and notifies the UI about the changes.
  ///
  /// The function is called when [onInit] is called.
  ///
  /// It uses a [Timer] to update the [dateTime] every second and calls [update]
  /// to notify the UI about the changes.
  ///
  /// [dateTime] is used to display the current time in the dashboard.
  void updateClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      update(['clock']);
      dateTime = DateTime.now();
    });
  }

  /// Updates the [timeOfDay] every minute and notifies the UI about the changes.
  ///
  /// The function is called when [onInit] is called.
  ///
  /// It uses a [Timer] to update the [timeOfDay] every minute and calls [update]
  /// to notify the UI about the changes.
  ///
  /// [timeOfDay] is used to display the current time of day in the dashboard.
  void updateTime() {
    period = timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    Timer.periodic(
      const Duration(seconds: 60),
      (timer) {
        final now = TimeOfDay.now();
        if (timeOfDay.minute != now.minute) {
          update(['clock']);
          timeOfDay = now;
        }
      },
    );
  }
}
