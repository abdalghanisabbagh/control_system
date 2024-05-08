import 'package:control_system/app/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/main_app.dart';
import 'presentation/resource_manager/constants/supported_locales.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: SupportedLocales.supportedLocales,
      fallbackLocale: SupportedLocales.fallbackLocale,
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: const MainApp(),
    ),
  );
}
