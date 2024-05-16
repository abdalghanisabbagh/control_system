import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color_manager.dart';
import '../styles_manager.dart';

class ElevatedBackButton extends StatelessWidget {
  const ElevatedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(11),
          ),
          color: ColorManager.bgSideMenu,
        ),
        child: Center(
          child: Text(
            "Back",
            style: nunitoRegular.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
