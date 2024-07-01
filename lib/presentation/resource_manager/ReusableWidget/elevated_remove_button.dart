import 'package:flutter/material.dart';

import '../index.dart';

class ElevatedRemoveButton extends StatelessWidget {
  const ElevatedRemoveButton({
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
