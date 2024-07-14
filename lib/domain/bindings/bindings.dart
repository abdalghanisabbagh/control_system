import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../controllers/roles_controller.dart';
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
    Get.lazyPut<DetailsAndReviewMissionController>(
      () => DetailsAndReviewMissionController(),
      fenix: true,
    );

    Get.lazyPut<DistributeStudentsController>(
      () => DistributeStudentsController(),
      fenix: true,
    );
    Get.lazyPut<DistributionController>(
      () => DistributionController(),
      fenix: true,
    );
  }
}

class CreateControlMissionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateControlMissionController>(
      () => CreateControlMissionController(),
      fenix: true,
    );
  }
}

class AddNewStudentsToControlMissionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewStudentsToControlMissionController>(
      () => AddNewStudentsToControlMissionController(),
      fenix: true,
    );
  }
}

class RolesBinidings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RolesController>(
      () => RolesController(),
      fenix: true,
    );
  }
}

class ProctorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProctorController>(
      () => ProctorController(),
      fenix: true,
    );
  }
}
