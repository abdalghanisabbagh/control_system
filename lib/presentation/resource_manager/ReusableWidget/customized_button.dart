// import 'package:/resources_manager/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_manager.dart';
import '../font_manager.dart';
import '../styles_manager.dart';
import '../values_manager.dart';

class CustomizedButton extends StatelessWidget {
  const CustomizedButton({
    super.key,
    this.responsiveHeight = 36,
    this.responsiveWidth = 110,
    required this.buttonTitle,
    this.onPressed,
    this.txtColor,
    this.whiteButtonWithColoredBorder = false,
  });
  final double responsiveHeight, responsiveWidth;
  final String buttonTitle;
  final void Function()? onPressed;
  final Color? txtColor;
  final bool whiteButtonWithColoredBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: responsiveHeight.h,
        width: responsiveWidth.w,
        margin: EdgeInsets.symmetric(vertical: AppPading.p12.r),
        decoration: BoxDecoration(
            border: whiteButtonWithColoredBorder
                ? Border.all(color: ColorManager.background)
                : null,
            color: whiteButtonWithColoredBorder
                ? Colors.white
                : ColorManager.background,
            borderRadius: BorderRadius.circular(4.r)),
        child: Padding(
          padding: const EdgeInsets.all(
            AppPading.p5,
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                buttonTitle,
                style: poppinsRegulerStyle(
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
