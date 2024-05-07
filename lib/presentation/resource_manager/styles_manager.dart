import 'font_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle _getMainFont(double fontSize, FontWeight fontWeight, Color color) {
  return Get.locale!.languageCode == 'en'
      ? GoogleFonts.poppins(
          fontSize: fontSize.sp,
          color: color,
          fontWeight: fontWeight,
        )
      : GoogleFonts.tajawal(
          fontSize: fontSize.sp,
          color: color,
          fontWeight: fontWeight,
        );
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
TextStyle poppinsLightStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.light, color);
}

// reguler Style
TextStyle poppinsRegulerStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.reguler, color);
}

// meduim Style
TextStyle poppinsMeduimStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.meduim, color);
}

// bold Style
TextStyle poppinsBoldStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.bold, color);
}

// semiBold Style
TextStyle poppinsSemiBoldStyle(double fontSize, Color color) {
  return _getMainFont(fontSize, FontWeightManager.semiBold, color);
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
