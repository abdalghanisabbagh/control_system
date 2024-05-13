import 'dart:ui';

import 'package:control_system/presentation/resource_manager/routes/app_go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../presentation/resource_manager/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal(); // singlton instance

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp.router(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      key: Get.key,
      title: 'Controll App',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      routerDelegate: AppGoRouter.router.routerDelegate,
      routeInformationProvider: AppGoRouter.router.routeInformationProvider,
      routeInformationParser: AppGoRouter.router.routeInformationParser,
      theme: getApplicationTheme(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
