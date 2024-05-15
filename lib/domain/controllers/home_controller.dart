import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class HomeController extends GetxController {
@override
void onInit() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.onInit();
  }

    SideMenuController sideMenu = SideMenuController();
    PageController pageController = PageController();

  RxList<ValueItem> selectedOptions = <ValueItem>[].obs;

  void onOptionSelected(List<ValueItem> selectedOptions) {
    this.selectedOptions.value = selectedOptions;
  }

  final List<ValueItem> options = const <ValueItem>[
    ValueItem(label: 'Option 1', value: 1),
    ValueItem(label: 'Option 2', value: 2),
    ValueItem(label: 'Option 3', value: 3),
    ValueItem(label: 'Option 4', value: 4),
    ValueItem(label: 'Option 5', value: 5),
    ValueItem(label: 'Option 6', value: 6),
  ];
}
