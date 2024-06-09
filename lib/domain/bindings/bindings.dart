import 'package:control_system/domain/controllers/control_mission_controller.dart';
import 'package:get/get.dart';

import '../controllers/index.dart';
import '../controllers/studentsController/add_new_student_controller.dart';
import '../controllers/studentsController/student_controller.dart';
import '../services/side_menue_get_controller.dart';
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

    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}

class BatchDocumentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BatchDocumentsController>(
      () => BatchDocumentsController(),
      fenix: true,
    );
    Get.put(CreateCoversSheetsController());

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
    Get.lazyPut<CohortsSettingsController>(
      () => CohortsSettingsController(),
      fenix: true,
    );
  }
}

class ClassRoomBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassRoomController>(
      () => ClassRoomController(),
      fenix: true,
    );
  }
}

class StudentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewStudentController>(
      () => AddNewStudentController(),
      fenix: true,
    );

    Get.lazyPut<StudentController>(
      () => StudentController(),
      fenix: true,
    );
  }
}

class ControlMissingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControlMissionController>(
      () => ControlMissionController(),
      fenix: true,
    );
  }
}
