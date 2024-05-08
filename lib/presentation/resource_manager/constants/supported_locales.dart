import 'package:flutter/material.dart' show Locale;

abstract class SupportedLocales {
  static const List<Locale> supportedLocales = [
    Locale('ar', 'EG'),
    Locale('en', 'US'),
  ];

  static const fallbackLocale = Locale('en', 'US');
}
