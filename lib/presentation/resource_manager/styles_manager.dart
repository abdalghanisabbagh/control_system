import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getMainFont(
  double fontSize,
  FontWeight fontWeight,
  Color color, {
  String fontFamily = AssetsManager.assetsFontsNunitoBlack,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
  );
}

// light Style
TextStyle nunitoLightStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsNunitoLight,
    fontSize ?? FontSize.s16,
    FontWeightManager.light,
    color ?? ColorManager.caption,
  );
}

// reguler Style
TextStyle nunitoRegulerStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsNunitoRegular,
    fontSize ?? FontSize.s12,
    FontWeightManager.reguler,
    color ?? ColorManager.black,
  );
}

// meduim Style
TextStyle nunitoBlackStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsNunitoBlack,
    fontSize ?? FontSize.s14,
    FontWeightManager.meduim,
    color ?? ColorManager.textFormFieldLabelStyle,
  );
}

// bold Style
TextStyle nunitoBoldStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsNunitoBold,
    fontSize ?? FontSize.s30,
    FontWeightManager.bold,
    color ?? ColorManager.displayLargeText,
  );
}

// semiBold Style
TextStyle nunitoSemiBoldStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsNunitoSemiBold,
    fontSize ?? FontSize.s24,
    FontWeightManager.semiBold,
    color ?? ColorManager.bodyMedium,
  );
}
