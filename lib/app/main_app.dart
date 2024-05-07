import 'package:control_system/presentation/resource_manager/routes/app_go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../presentation/resource_manager/theme_manager.dart';
import '../presentation/views/home/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: const MaterialApp(
        home: HomeScreen(),
      ),
      builder: (_, __) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          key: Get.key,
          routerDelegate: AppGoRouter.router.routerDelegate,
          routeInformationProvider: AppGoRouter.router.routeInformationProvider,
          routeInformationParser: AppGoRouter.router.routeInformationParser,
          theme: getApplicationTheme(),
        );
      },
    );
  }
}
