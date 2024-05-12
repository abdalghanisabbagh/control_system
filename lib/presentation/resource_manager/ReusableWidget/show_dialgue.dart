// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class MyAwesomeDialogue {
  final String title;
  final String desc;
  final DialogType dialogType;

  VoidCallback? btnOkOnPressed;
  VoidCallback? btnCancelOnPressed;
  Widget? customBody;
  final AnimType animType;
  final bool useRootNavigator;
  Duration? autoHideTimer;
  final bool dismissOnBackKeyPress;
  final bool dismissOnTouchOutside;
  final bool showCloseIcon;

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
            desc: desc,
            btnCancelOnPress: btnCancelOnPressed,
            btnOkOnPress: btnOkOnPressed,
            animType: animType,
            body: customBody,
            useRootNavigator: useRootNavigator,
            dismissOnBackKeyPress: dismissOnBackKeyPress,
            dismissOnTouchOutside: dismissOnTouchOutside,
            showCloseIcon: showCloseIcon,
            autoHide: autoHideTimer)
        .show();
  }
}
