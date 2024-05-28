import 'package:flutter/material.dart';

import 'index.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,

    /// main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.primary,
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
      actionsIconTheme: const IconThemeData(color: ColorManager.black),
      iconTheme: const IconThemeData(color: ColorManager.black),
      centerTitle: true,
      color: ColorManager.appbarColor,
      elevation: AppSize.s5,
      shadowColor: ColorManager.appbarColorShadow,
      titleTextStyle: nunitoRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.appBarTextColor,
      ),
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
          foregroundColor: ColorManager.white,
          backgroundColor: ColorManager.primary,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //side: const BorderSide(color: Colors.red, width: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: nunitoLightStyle()),
    ),

    ///text theme

    textTheme: TextTheme(
      displayLarge: nunitoBoldStyle(
        fontSize: FontSize.s30,
        color: ColorManager.displayLargeText,
      ),
      headlineLarge: nunitoLightStyle(
        fontSize: FontSize.s20,
        color: ColorManager.headline1,
      ),
      titleMedium: nunitoLightStyle(
        fontSize: FontSize.s9,
        color: ColorManager.subtitle1,
      ),
      titleLarge: nunitoLightStyle(
        fontSize: FontSize.s14,
        color: ColorManager.subtitle2,
      ),
      //text in showDatePicker
      bodyLarge: nunitoLightStyle(
        fontSize: FontSize.s16,
        color: ColorManager.caption,
      ),
      bodySmall: nunitoLightStyle(
        fontSize: FontSize.s12,
        color: ColorManager.bodyText1,
      ),
      bodyMedium: nunitoLightStyle(
        fontSize: FontSize.s16,
        color: ColorManager.bodyMedium,
      ),
    ),

    ///inputDecoration theme (TextFormField)

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPading.p12),

      hintStyle: nunitoRegularStyle(
        fontSize: FontSize.s7,
        color: ColorManager.textFormFieldHintStyle,
      ),
      labelStyle: nunitoBlackStyle(
        fontSize: FontSize.s10,
        color: ColorManager.textFormFieldLabelStyle,
      ),
      errorStyle: nunitoRegularStyle(
        fontSize: FontSize.s10,
        color: ColorManager.error,
      ),

      /// enabled border style
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s4))),
      // disabled border style
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorManager.outlineInputBorderColor, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4))),
      // foucsed border style
      focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.black, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

      /// error border style

      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      /// focusedErrorBorder border style

      focusedErrorBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
      iconColor: ColorManager.grey,
      suffixIconColor: ColorManager.grey,
    ),
  );
}
