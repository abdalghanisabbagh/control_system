import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../domain/bindings/bindings.dart';
import '../presentation/resource_manager/routes/app_go_router.dart';
import 'configurations/scroll_configurations.dart';

class MyApp extends StatefulWidget {
  static const MyApp _instance = MyApp._internal(); // singlton instance

  factory MyApp() => _instance;

  const MyApp._internal();

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
      title: 'NIS Control System',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      routerDelegate: AppGoRouter.router.routerDelegate,
      backButtonDispatcher: AppGoRouter.router.backButtonDispatcher,
      routeInformationProvider: AppGoRouter.router.routeInformationProvider,
      routeInformationParser: AppGoRouter.router.routeInformationParser,
      theme: getApplicationTheme(),
      initialBinding: SideMenuBindings(),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
