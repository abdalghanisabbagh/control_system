import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  final void Function()? onPressed;

  final String buttonTitle;
  final double responsiveHeight, responsiveWidth;
  final Color? txtColor;
  final bool whiteButtonWithColoredBorder;
  const CustomizedButton({
    super.key,
    this.responsiveHeight = 36,
    this.responsiveWidth = 110,
    required this.buttonTitle,
    this.onPressed,
    this.txtColor,
    this.whiteButtonWithColoredBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: responsiveHeight,
        width: responsiveWidth,
        margin: const EdgeInsets.symmetric(vertical: AppPading.p12),
        decoration: BoxDecoration(
            border: whiteButtonWithColoredBorder
                ? Border.all(color: ColorManager.background)
                : null,
            color: whiteButtonWithColoredBorder
                ? Colors.white
                : ColorManager.background,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(
            AppPading.p5,
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                buttonTitle,
                style: nunitoRegularStyle(
                  fontSize: FontSize.s14,
                  color: whiteButtonWithColoredBorder
                      ? ColorManager.background
                      : (txtColor ?? Colors.white),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
