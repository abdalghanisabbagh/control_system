import 'package:get/get.dart';

class DropDownButtonController extends GetxController {
  List<String> items = [
    'مشويات',
    'اسماك',
    'بخاري',
    'لاشيى',
  ];
  Rx<List<String>> selctedOptionList = Rx<List<String>>([]);
  final selectedOption = 'لاشيى'.obs;
  void setSelected(value) {
    selectedOption.value = value;
  }
}

