import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getMainFont(double fontSize, FontWeight fontWeight, Color color) {
  return
      // Get.locale!.languageCode == 'en'?
      GoogleFonts.poppins(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
  );
  // : GoogleFonts.tajawal(
  //     fontSize: fontSize.sp,
  //     color: color,
  //     fontWeight: fontWeight,
  //   );
}
/*
TextStyle _getMyPoppinsFont(
    double fontSize, FontWeight fontWeight, Color color) {
  return GoogleFonts.poppins().copyWith(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
  );
}
*/

// light Style
TextStyle poppinsLightStyle({double? fontSize, Color? color}) {
  return _getMainFont(
    fontSize ?? FontSize.s16,
    FontWeightManager.light,
    color ?? ColorManager.caption,
  );
}

// reguler Style
TextStyle poppinsRegulerStyle({double? fontSize, Color? color}) {
  return _getMainFont(
    fontSize ?? FontSize.s12,
    FontWeightManager.reguler,
    color ?? ColorManager.black,
  );
}

// meduim Style
TextStyle poppinsMeduimStyle({double? fontSize, Color? color}) {
  return _getMainFont(
    fontSize ?? FontSize.s14,
    FontWeightManager.meduim,
    color ?? ColorManager.textFormFieldLabelStyle,
  );
}

// bold Style
TextStyle poppinsBoldStyle({double? fontSize, Color? color}) {
  return _getMainFont(
    fontSize ?? FontSize.s30,
    FontWeightManager.bold,
    color ?? ColorManager.displayLargeText,
  );
}

// semiBold Style
TextStyle poppinsSemiBoldStyle({double? fontSize, Color? color}) {
  return _getMainFont(
    fontSize ?? FontSize.s24,
    FontWeightManager.semiBold,
    color ?? ColorManager.bodyMedium,
  );
}

///********************************************Tajawl ***********************/

// light Style
TextStyle tajawalLightStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.light, color);
}

// reguler Style
TextStyle tajawalRegulerStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.reguler, color);
}

// meduim Style
TextStyle tajawalMeduimStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.meduim, color);
}

// bold Style
TextStyle tajawalBoldStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.bold, color);
}

// semiBold Style
TextStyle tajawalSemiBoldStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.semiBold, color);
}
