import 'dart:ui';

import 'package:control_system/presentation/resource_manager/routes/app_go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../presentation/resource_manager/theme_manager.dart';
<<<<<<< HEAD
=======
import '../presentation/views/home/home_screen.dart';
import 'configurations/scroll_configurations.dart';
>>>>>>> 0bd50e2201d8acda9cca0f45405bdd046cf51679

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
<<<<<<< HEAD
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp.router(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      key: Get.key,
      title: 'NIS Control System',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      routerDelegate: AppGoRouter.router.routerDelegate,
      routeInformationProvider: AppGoRouter.router.routeInformationProvider,
      routeInformationParser: AppGoRouter.router.routeInformationParser,
      theme: getApplicationTheme(),
=======
    return ScreenUtilInit(
      child: const MaterialApp(
        home: HomeScreen(),
      ),
      builder: (context, __) {
        return GetMaterialApp.router(
          scrollBehavior: AppScrollBehavior(),
          debugShowCheckedModeBanner: false,
          key: Get.key,
          routerDelegate: AppGoRouter.router.routerDelegate,
          routeInformationProvider: AppGoRouter.router.routeInformationProvider,
          routeInformationParser: AppGoRouter.router.routeInformationParser,
          theme: getApplicationTheme(),
        );
      },
>>>>>>> 0bd50e2201d8acda9cca0f45405bdd046cf51679
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
