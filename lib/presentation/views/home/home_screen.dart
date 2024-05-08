import 'package:control_system/app/extensions/change_app_locale_extension.dart';
import 'package:control_system/app/generated/keys.dart';
import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:control_system/presentation/resource_manager/constants/supported_locales.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.title).tr(),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.changeAppLocale(SupportedLocales.arabicEG);
              },
              child: const Text(
                'العربية',
              ),
            ),
            TextButton(
              onPressed: () {
                context.changeAppLocale(SupportedLocales.englishUS);
              },
              child: const Text(
                'English',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
