import 'package:flutter/material.dart';

class AppDialogs extends StatelessWidget {
  const AppDialogs({
    super.key,
    required this.curve,
    required this.content,
  });
  final double? curve;
  final Widget content;
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
  static showAddDialog(BuildContext context, Widget content) {
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
}