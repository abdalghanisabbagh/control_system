import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:control_system/domain/controllers/seating_numbers_controllers/seating_number_tab_view_controller.dart';
import 'package:control_system/domain/services/side_menue_get_controller.dart';
import 'package:get/get.dart';

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
  }
}
