import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElevatedBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ElevatedBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed?.call();
        Get.back();
      },
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
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
