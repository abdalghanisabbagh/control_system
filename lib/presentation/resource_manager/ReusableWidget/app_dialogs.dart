import 'package:flutter/material.dart';

class AppDialogs extends StatelessWidget {
  final Widget content;

  final double? curve;
  const AppDialogs({
    super.key,
    required this.curve,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: curve,
      child: StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          content: content,
        ),
      ),
    );
  }
}

class MyDialogs {
  /////////////////////////////Flutter Material Dialog////////////////////////
  static showDialog(BuildContext context, Widget content) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOut.transform(animation.value);
        return AppDialogs(
          curve: curve,
          content: content,
        );
      },
    );
  }

///////////////////////////////Getx Dialog////////////////////////
  // static showDialog(BuildContext context, Widget content) {
  //   Get.generalDialog(
  //     pageBuilder: (context, animation, secondaryAnimation) => Container(),
  //     transitionBuilder: (context, animation, secondaryAnimation, child) {
  //       var curve = Curves.easeInOut.transform(animation.value);
  //       return AppDialogs(
  //         curve: curve,
  //         content: content,
  //       );
  //     },
  //   );
  // }
}
