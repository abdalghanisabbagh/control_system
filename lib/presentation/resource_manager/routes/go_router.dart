import 'package:control_system/domain/bindings/home_bindings.dart';
import 'package:control_system/presentation/resource_manager/routes/app_routes_names_and_paths.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/controllers/home_controller.dart';
import '../../views/home/home_screen.dart';

class AppGoRouter {
  static final router = GoRouter(
    initialLocation: AppRoutesNamesAndPaths.homeScreenPath,
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
    ],
  );
}
