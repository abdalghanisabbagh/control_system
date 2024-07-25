import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class MyFlashBar {
  static Flushbar buildFlashBar(String title, String content) {
    return Flushbar(
      // title: title,
      titleColor: Colors.white,
      //  message: content,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
            color: Colors.blue[800]!,
            offset: const Offset(0.0, 2.0),
            blurRadius: 3.0)
      ],
      backgroundGradient:
          const LinearGradient(colors: [Colors.blueGrey, Colors.black]),
      isDismissible: false,
      duration: const Duration(seconds: 4),
      icon: const Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      mainButton: ElevatedButton(
        onPressed: () {},
        child: const Text(
          "CLAP",
          style: TextStyle(color: Colors.amber),
        ),
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      titleText: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.yellow[600],
            fontFamily: "ShadowsIntoLightTwo"),
      ),
      messageText: Text(
        content,
        style: const TextStyle(
            fontSize: 18.0,
            color: Colors.green,
            fontFamily: "ShadowsIntoLightTwo"),
      ),
    );
  }

  static showError(String message, String title) {
    return FlushbarHelper.createError(
        message: message, title: title, duration: const Duration(seconds: 5));
  }

  static showInfo(String message, String title) {
    return FlushbarHelper.createInformation(
        message: message, title: title, duration: const Duration(seconds: 5));
  }

  static showSuccess(String message, String title) {
    return FlushbarHelper.createSuccess(
        message: message, title: title, duration: const Duration(seconds: 5));
  }
}
