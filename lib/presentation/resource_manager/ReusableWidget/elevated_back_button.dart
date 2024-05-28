import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color_manager.dart';
import '../styles_manager.dart';

class ElevatedBackButton extends StatelessWidget {
  const ElevatedBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed?.call();
        Get.back();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(11),
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
