import 'package:get/get.dart';

import '../controllers/batch_documents.dart/attendance_controller.dart';
import '../controllers/batch_documents.dart/edit_cover_controller.dart';
import '../controllers/batch_documents.dart/seat_number_controller.dart';
import '../controllers/controllers.dart';
import '../controllers/subject/edit_subject_controller.dart';
import '../controllers/subject/operation_controoler.dart';
import '../services/side_menue_get_controller.dart';
import '../services/token_service.dart';

class AddNewStudentsToControlMissionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewStudentsToControlMissionController>(
      () => AddNewStudentsToControlMissionController(),
      fenix: true,
    );
  }
}

class AdminBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController(), fenix: true);
  }
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

class BarcodeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeController>(
      () => BarcodeController(),
      fenix: true,
    );
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
    Get.lazyPut<EditCoverSheetController>(
      () => EditCoverSheetController(),
      fenix: true,
    );
    Get.lazyPut<SeatNumberController>(
      () => SeatNumberController(),
      fenix: true,
    );
    Get.lazyPut<AttendanceController>(
      () => AttendanceController(),
      fenix: true,
    );
    Get.lazyPut<CoversSheetsController>(
      () => CoversSheetsController(),
      fenix: true,
    );

    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
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

class CohortSettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CohortsSettingsController>(
      () => CohortsSettingsController(),
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

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
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

class RolesBinidings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RolesController>(
      () => RolesController(),
      fenix: true,
    );
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

class SubjectSettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubjectsController>(
      () => SubjectsController(),
      fenix: true,
    );
    Get.lazyPut<EditSubjectsController>(
      () => EditSubjectsController(),
      fenix: true,
    );

    Get.lazyPut<SchoolController>(
      () => SchoolController(),
      fenix: true,
    );
    Get.lazyPut<OperationController>(
      () => OperationController(),
      fenix: true,
    );
  }
}

class TokenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TokenService(), permanent: true);
  }
}
