import 'package:flutter/material.dart';

import '../index.dart';

class ElevatedEditButton extends StatelessWidget {
  const ElevatedEditButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

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
            "Edit",
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
