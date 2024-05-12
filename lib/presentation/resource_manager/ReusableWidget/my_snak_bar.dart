import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyReusbleWidget {
  static mySnackBarError(String title, String content) {
    return Get.snackbar(

      title,
      content,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      // backgroundColor: AppColor.red.withOpacity(0.8),
      messageText: Center(
        child: Text(
          content,
          // style: AppTextStyle.nunitoRegular.copyWith(
          //   color: AppColor.white,
          // ),
        ),
      ),
      titleText: Center(
        child: Text(
          title,
          // style: AppTextStyle.nunitoRegular.copyWith(
          //   color: AppColor.white,
          // ),
        ),
      ),
    );
  }

  static mySnackBarGood(String title, String content) {
    return Get.snackbar(
      title,
      content,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      messageText: Center(
        child: Text(
          content,
          // style: AppTextStyle.nunitoRegular,
        ),
      ),
      titleText: Center(
        child: Text(
          title,
          // style: AppTextStyle.nunitoRegular.copyWith(
          //   color: AppColor.white,
          // )
        ),
      ),
    );
  }

  static void show(BuildContext context, String message, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
