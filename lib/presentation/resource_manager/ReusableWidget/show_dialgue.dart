// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAwesomeDialogue {
  final AnimType animType;

  Duration? autoHideTimer;
  VoidCallback? btnCancelOnPressed;
  VoidCallback? btnOkOnPressed;
  Widget? customBody;
  final String desc;
  final DialogType dialogType;
  final bool dismissOnBackKeyPress;
  final bool dismissOnTouchOutside;
  final bool showCloseIcon;
  final String title;
  final bool useRootNavigator;
  MyAwesomeDialogue({
    required this.title,
    required this.desc,
    required this.dialogType,
    this.btnOkOnPressed,
    this.btnCancelOnPressed,
    this.customBody,
    this.animType = AnimType.scale,
    this.useRootNavigator = true,
    this.autoHideTimer,
    this.dismissOnBackKeyPress = true,
    this.dismissOnTouchOutside = true,
    this.showCloseIcon = true,
  });

  void showDialogue(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      title: title,
      titleTextStyle: nunitoBoldStyle(fontSize: FontSize.s18),
      desc: desc,
      descTextStyle: nunitoRegularStyle(fontSize: FontSize.s16),
      width: Get.width * 0.5,
      btnCancelOnPress: btnCancelOnPressed,
      btnOkOnPress: btnOkOnPressed,
      animType: animType,
      body: customBody,
      useRootNavigator: useRootNavigator,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      showCloseIcon: showCloseIcon,
      autoHide: autoHideTimer,
    ).show();
  }
}
