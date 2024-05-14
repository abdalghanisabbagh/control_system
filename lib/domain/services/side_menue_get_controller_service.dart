import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenueGetControllerService extends GetxService {
  late final SideMenuController sideMenuController;
  late final PageController pageController;

  @override
  void onInit() {
    sideMenuController = SideMenuController();
    pageController = PageController();

    sideMenuController.addListener((int index) {
      pageController.jumpToPage(index);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    sideMenuController.dispose();
    super.onClose();
  }
}
