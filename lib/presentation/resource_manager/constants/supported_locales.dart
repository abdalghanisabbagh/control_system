import 'package:flutter/material.dart' show Locale;

abstract class SupportedLocales {
  static const Locale englishUS = Locale('en', 'US');

  static const Locale arabicEG = Locale('ar', 'EG');

  static const List<Locale> supportedLocales = [
    arabicEG,
    englishUS,
  ];

  static const fallbackLocale = englishUS;
}
