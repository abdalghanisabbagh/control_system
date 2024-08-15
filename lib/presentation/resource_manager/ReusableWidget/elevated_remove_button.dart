import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class ElevatedRemoveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ElevatedRemoveButton({
    super.key,
    required this.onPressed,
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
          color: ColorManager.red,
        ),
        child: Center(
          child: Text(
            "Remove",
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
