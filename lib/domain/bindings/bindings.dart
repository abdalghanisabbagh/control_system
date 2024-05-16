import 'package:control_system/domain/controllers/SeatingNumbersControllers/CreateCoversSheetsController.dart';
import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:control_system/domain/controllers/SeatingNumbersControllers/seating_number_tab_view_controller.dart';
import 'package:control_system/domain/services/side_menue_get_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';
import '../controllers/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}

class SideMenuBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SideMenueGetController>(
      () => SideMenueGetController(),
      fenix: true,
    );
  }
}

class SeatingNumberBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeatingNumberController>(
      () => SeatingNumberController(),
      fenix: true,
    );
    Get.lazyPut<CreateCoversSheetsController>(
      () => CreateCoversSheetsController(),
      fenix: true,
    );
  }
}

class DashBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
      fenix: true,
    );
  }
}
