import 'package:control_system/presentation/resource_manager/routes/app_go_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      key: Get.key,
      routerDelegate: AppGoRouter.router.routerDelegate,
      routeInformationProvider: AppGoRouter.router.routeInformationProvider,
      routeInformationParser: AppGoRouter.router.routeInformationParser,
      // theme: getApplicationTheme(),
    );
  }
}
