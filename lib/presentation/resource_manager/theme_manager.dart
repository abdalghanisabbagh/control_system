import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    /// main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey,

    // cardView Theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.lightGrey,
      elevation: AppSize.s5,

      // margin: const EdgeInsets.all(AppSize.s5),
      // shape:
    ),

    ///AppBar Theme
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: ColorManager.black),
      iconTheme: IconThemeData(color: ColorManager.black),
      centerTitle: true,
      color: ColorManager.appbarColor,
      elevation: AppSize.s5,
      shadowColor: ColorManager.appbarColorShadow,
      titleTextStyle:
          poppinsRegulerStyle(FontSize.s16, ColorManager.appBarTextColor),
    ),

    ///button theme

    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.buttonDisableColor,
      buttonColor: ColorManager.buttonColor,
      splashColor: ColorManager.buttonSplashColor,
    ),

    /// elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: poppinsRegulerStyle(
            FontSize.s18, ColorManager.elevatedButtonTextColor),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s4.r),
        ),
      ),
    ),

    ///text theme

    textTheme: TextTheme(
      displayLarge:
          poppinsBoldStyle(FontSize.s30, ColorManager.displayLargeText),
      headlineLarge: poppinsLightStyle(FontSize.s20, ColorManager.headline1),
      titleMedium: poppinsLightStyle(FontSize.s16, ColorManager.subtitle1),
      titleLarge: poppinsLightStyle(FontSize.s14, ColorManager.subtitle2),
      bodyLarge: poppinsLightStyle(FontSize.s20, ColorManager.caption),
      bodySmall: poppinsLightStyle(FontSize.s12, ColorManager.bodyText1),
      bodyMedium: poppinsLightStyle(FontSize.s16, ColorManager.bodyMedium),
    ),

    ///inputDecoration theme (TextFormField)

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPading.p12),

      hintStyle: poppinsRegulerStyle(
          FontSize.s10, ColorManager.textFormFieldHintStyle),
      labelStyle: poppinsMeduimStyle(
          FontSize.s14, ColorManager.textFormFieldLabelStyle),
      errorStyle: poppinsRegulerStyle(FontSize.s10, ColorManager.error),
      // enabled border style
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorManager.outlineInputBorderColor, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4))),
      // disabled border style
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorManager.outlineInputBorderColor, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4))),
      // foucsed border style
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      /// error border style

      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      /// focusedErrorBorder border style

      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      iconColor: ColorManager.grey,
      suffixIconColor: ColorManager.grey,
    ),
  );
}
