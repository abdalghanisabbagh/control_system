import 'package:flutter/material.dart';
import 'index.dart';

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
      titleTextStyle: poppinsRegulerStyle(
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
        textStyle: poppinsRegulerStyle(
            fontSize: FontSize.s18,
            color: ColorManager.elevatedButtonTextColor),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s4),
        ),
      ),
    ),

    ///text theme

    textTheme: TextTheme(
      displayLarge: poppinsBoldStyle(
        fontSize: FontSize.s30,
        color: ColorManager.displayLargeText,
      ),
      headlineLarge: poppinsLightStyle(
        fontSize: FontSize.s20,
        color: ColorManager.headline1,
      ),
      titleMedium: poppinsLightStyle(
        fontSize: FontSize.s9,
        color: ColorManager.subtitle1,
      ),
      titleLarge: poppinsLightStyle(
        fontSize: FontSize.s14,
        color: ColorManager.subtitle2,
      ),
      bodyLarge: poppinsLightStyle(
        fontSize: FontSize.s7,
        color: ColorManager.caption,
      ),
      bodySmall: poppinsLightStyle(
        fontSize: FontSize.s12,
        color: ColorManager.bodyText1,
      ),
      bodyMedium: poppinsLightStyle(
        fontSize: FontSize.s16,
        color: ColorManager.bodyMedium,
      ),
    ),

    ///inputDecoration theme (TextFormField)

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPading.p12),

      hintStyle: poppinsRegulerStyle(
        fontSize: FontSize.s7,
        color: ColorManager.textFormFieldHintStyle,
      ),
      labelStyle: poppinsMeduimStyle(
        fontSize: FontSize.s10,
        color: ColorManager.textFormFieldLabelStyle,
      ),
      errorStyle: poppinsRegulerStyle(
        fontSize: FontSize.s10,
        color: ColorManager.error,
      ),

      /// enabled border style
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
