import 'package:easy_localization/easy_localization.dart'
    show BuildContextEasyLocalizationExtension;
import 'package:flutter/material.dart' show BuildContext, Locale;
import 'package:get/get.dart' show Get, GetNavigation;

extension ChangeAppLocale on BuildContext {
  void changeAppLocale(Locale locale) {
    if (this.locale.languageCode == locale.languageCode &&
        this.locale.countryCode == locale.countryCode) {
      return;
    }
    setLocale(locale);
    Get.updateLocale(locale);
    return;
  }
}
