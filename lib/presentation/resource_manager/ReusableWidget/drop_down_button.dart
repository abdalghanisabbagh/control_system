import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownButtonController extends GetxController {
  List<String> items = [
    'مشويات',
    'اسماك',
    'بخاري',
  ];
  Rx<List<String>> selctedOptionList = Rx<List<String>>([]);
  final selectedOption = 'item'.obs;
  void setSelected(value) {
    selectedOption.value = value;
  }
}

class DropDownWidget extends StatelessWidget {
  final DropDownButtonController downButtonController =
      Get.put(DropDownButtonController());
  DropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: (newValue) {
        downButtonController.setSelected(newValue);
      },
      value: downButtonController.selectedOption.value,
      items: downButtonController.items
          .map((selectedType) => DropdownMenuItem(
                value: selectedType,
                child: Text(selectedType),
              ))
          .toList(),
    );
  }
}
