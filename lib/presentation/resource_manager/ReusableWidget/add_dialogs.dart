import 'package:flutter/material.dart';

class AddDialogs extends StatelessWidget {
 const AddDialogs({
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
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Colors.white,
          content: content,
        ),
      ),
    );
  }
}

class MYDialogs {
  static showAddDialog(BuildContext context, Widget content) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Container(),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          var curve = Curves.easeInOut.transform(animation.value);
          return AddDialogs(
            curve: curve,
            content: content,
          );
        });
  }
}
