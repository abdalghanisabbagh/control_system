import 'package:control_system/domain/controllers/SeatingNumbersControllers/CreateCoversSheetsController.dart';
import 'package:control_system/domain/controllers/SeatingNumbersControllers/seating_number_tab_view_controller.dart';
import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:control_system/domain/controllers/profile_controller.dart';
import 'package:control_system/domain/controllers/school_controller.dart';
import 'package:control_system/domain/controllers/subject_controller.dart';
import 'package:control_system/domain/services/side_menue_get_controller.dart';
import 'package:control_system/presentation/views/cohort_settings/cohort_settings_screen.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';
import '../controllers/home_controller.dart';
import '../services/token_service.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

class SideMenuBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SideMenueGetController>(
      () => SideMenueGetController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

class BatchDocumentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BatchDocumentsController>(
      () => BatchDocumentsController(),
      fenix: true,
    );
    Get.lazyPut<CreateCoversSheetsController>(
      () => CreateCoversSheetsController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

class DashBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

class TokenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TokenService(), permanent: true);
  }
}

class SchoolSettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchoolController>(
      () => SchoolController(),
      fenix: true,
    );
  }
}

class SubjectSettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubjectsController>(
      () => SubjectsController(),
      fenix: true,
    );
  }
}

class CohortSettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CohortSettingsScreen>(
      () => const CohortSettingsScreen(),
      fenix: true,
    );
  }
}
