import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCoversSheetsController extends GetxController {
  String atoken = '';
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
    RxBool isLoading = false.obs;
     TextEditingController examTimeController = TextEditingController();
  TextEditingController examFinalDegreeController = TextEditingController();
  List<int> examDurations = [
    15,
    25,
    45,
    60,
    70,
    75,
    85,
    90,
    100,
    105,
    120,
    130,
    150
  ];
    bool is2Version = false;
      bool isNight = false;



}
