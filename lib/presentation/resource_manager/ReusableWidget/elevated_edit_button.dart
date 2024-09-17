import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class ElevatedEditButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String title;
  const ElevatedEditButton({
    super.key,
    required this.onPressed,
    this.title = "Edit",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(11),
          ),
          color: ColorManager.glodenColor,
        ),
        child: Center(
          child: Text(
            title,
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
