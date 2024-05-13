import 'package:control_system/presentation/resource_manager/routes/app_routes_names_and_paths.dart';
import 'package:control_system/presentation/views/Login/login_screen.dart';
import 'package:control_system/presentation/views/schools/school_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/indices/index.dart';
import '../../views/home/home_screen.dart';

class AppGoRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutesNamesAndPaths.loginScreenPath,
    routes: [
      GoRoute(
        path: AppRoutesNamesAndPaths.homeScreenPath,
        name: AppRoutesNamesAndPaths.homeScreenName,
        builder: (context, state) {
          HomeBindings().dependencies();
          return const HomeScreen();
        },
        onExit: (context, state) {
          Get.delete<HomeController>();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.loginScreenPath,
        name: AppRoutesNamesAndPaths.loginScreenName,
        builder: (context, state) {
          AuthBindings().dependencies();
          return const LoginScreen();
        },
        onExit: (context, state) {
          Get.delete<AuthController>();
          return true;
        },
      ),
      GoRoute(
        path: AppRoutesNamesAndPaths.schoolsScreenPath,
        name: AppRoutesNamesAndPaths.schoolsScreenName,
        builder: (context, state) {
          return const SchoolsScreen();
        },
        onExit: (context, state) {
          return true;
        },
      ),
    ],
  );
}
