import 'package:get/get.dart';

class DropDownButtonController extends GetxController {
  List<String> items = [
    'مشويات',
    'اسماك',
    'بخاري',
    'item',
  ];
  Rx<List<String>> selctedOptionList = Rx<List<String>>([]);
  final selectedOption = 'item'.obs;
  void setSelected(value) {
    selectedOption.value = value;
  }
}
