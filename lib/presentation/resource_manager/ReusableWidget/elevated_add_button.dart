import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class ElevatedAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ElevatedAddButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(11),
          ),
          color: ColorManager.glodenColor,
        ),
        child: Center(
          child: Text(
            "Add",
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
