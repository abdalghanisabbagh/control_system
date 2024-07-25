import 'package:flutter/cupertino.dart';

import 'assets_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

TextStyle get nunitoBlack => nunitoBlackStyle();

TextStyle get nunitoBold => nunitoBoldStyle();

TextStyle get nunitoLight => nunitoLightStyle();

TextStyle get nunitoRegular => nunitoRegularStyle();

TextStyle get nunitoSemiBold => nunitoSemiBoldStyle();

TextStyle get openSansBold => openSansBoldStyle();

TextStyle get openSansMeduim => openSansMeduimStyle();

TextStyle get openSansRegular => openSansRegularStyle();

TextStyle get openSansSemiBold => openSansSemiBoldStyle();

TextStyle get playfairDisplayBold => playfairDisplayBoldStyle();

TextStyle get playfairDisplayMeduim => playfairDisplayMeduimStyle();

TextStyle get playfairDisplayRegular => playfairDisplayRegularStyle();

TextStyle get playfairDisplaySemiBold => playfairDisplaySemiBoldStyle();

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
    color ?? ColorManager.primary,
  );
}

//////////////////////////Nunito Font Styles////////////////////////////////////

// light Style
TextStyle nunitoLightStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsNunitoLight,
    fontSize ?? FontSize.s18,
    FontWeightManager.light,
    color ?? ColorManager.caption,
  );
}

// reguler Style
TextStyle nunitoRegularStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsNunitoRegular,
    fontSize ?? FontSize.s18,
    FontWeightManager.reguler,
    color ?? ColorManager.black,
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

//bold Style
TextStyle openSansBoldStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsOpenSans,
    fontSize ?? FontSize.s18,
    FontWeightManager.bold,
    color ?? ColorManager.black,
  );
}

//meduim Style
TextStyle openSansMeduimStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsOpenSans,
    fontSize ?? FontSize.s14,
    FontWeightManager.meduim,
    color ?? ColorManager.black,
  );
}

//////////////////////////Open-Sans Font Styles////////////////////////////////////

//reguler Style
TextStyle openSansRegularStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsOpenSans,
    fontSize ?? FontSize.s12,
    FontWeightManager.reguler,
    color ?? ColorManager.black,
  );
}

//semiBold Style
TextStyle openSansSemiBoldStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsOpenSans,
    fontSize ?? FontSize.s16,
    FontWeightManager.semiBold,
    color ?? ColorManager.black,
  );
}

//bold Style
TextStyle playfairDisplayBoldStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsPlayfairDisplayBold,
    fontSize ?? FontSize.s18,
    FontWeightManager.bold,
    color ?? ColorManager.black,
  );
}

//meduim Style
TextStyle playfairDisplayMeduimStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsPlayfairDisplayMedium,
    fontSize ?? FontSize.s14,
    FontWeightManager.meduim,
    color ?? ColorManager.black,
  );
}

//////////////////////////PlayfairDisplay Font Styles////////////////////////////////////

//reguler Style
TextStyle playfairDisplayRegularStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsPlayfairDisplayRegular,
    fontSize ?? FontSize.s12,
    FontWeightManager.reguler,
    color ?? ColorManager.black,
  );
}

//semiBold Style
TextStyle playfairDisplaySemiBoldStyle({
  double? fontSize,
  Color? color,
}) {
  return _getMainFont(
    fontFamily: AssetsManager.assetsFontsPlayfairDisplaySemiBold,
    fontSize ?? FontSize.s16,
    FontWeightManager.semiBold,
    color ?? ColorManager.black,
  );
}

TextStyle _getMainFont(
  double fontSize,
  FontWeight fontWeight,
  Color color, {
  String fontFamily = AssetsManager.assetsFontsNunitoBlack,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
  );
}
