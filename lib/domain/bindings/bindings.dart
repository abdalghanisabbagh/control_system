import 'package:get/get.dart';

import '../controllers/control_mission/control_mission_opreation_controller.dart';
import '../controllers/controllers.dart';
import '../services/side_menue_get_controller.dart';
import '../services/token_service.dart';

/// This class is used to bind the dependencies of the
/// [AddNewStudentsToControlMissionController] controller.
///
/// The [dependencies] method is used to register the
/// [AddNewStudentsToControlMissionController] controller with the
/// GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controller will be created and registered every time the
/// [AddNewStudentsToControlMissionPage] is opened.
class AddNewStudentsToControlMissionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewStudentsToControlMissionController>(
      () => AddNewStudentsToControlMissionController(),
      fenix: true,
    );
  }
}

/// This class is used to bind the dependencies of the
/// [AdminController] controller.
///
/// The [dependencies] method is used to register the
/// [AdminController] controller with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controller will be created and registered every time the
/// [AdminPage] is opened.
class AdminBindings implements Bindings {
  @override
  void dependencies() {
    /// Register the [AdminController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [AdminPage] is opened.
    Get.lazyPut<AdminController>(() => AdminController(), fenix: true);
  }
}

/// This class is used to bind the dependencies of the
/// [AuthController] and [ProfileController] controllers.
///
/// The [dependencies] method is used to register the
/// [AuthController] and [ProfileController] controllers with the
/// GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controllers will be created and registered every time the
/// [LoginPage] is opened.
class AuthBindings extends Bindings {
  @override
  void dependencies() {
    /// Register the [AuthController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [LoginPage] is opened.
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);

    /// Register the [ProfileController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [LoginPage] is opened.
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

/// This class is used to bind the dependencies of the
/// [BarcodeController] controller.
///
/// The [dependencies] method is used to register the
/// [BarcodeController] controller with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controller will be created and registered every time the
/// [BarcodePage] is opened.
class BarcodeBindings extends Bindings {
  @override
  void dependencies() {
    /// Register the [BarcodeController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BarcodePage] is opened.
    Get.lazyPut<BarcodeController>(
      () => BarcodeController(),
      fenix: true,
    );
  }
}

/// This class is used to bind the dependencies of the
/// [BatchDocumentsController], [CreateCoversSheetsController],
/// [EditCoverSheetController], [SeatNumberController],
/// [AttendanceController] and [CoversSheetsController] controllers.
///
/// The [dependencies] method is used to register the
/// controllers with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controllers will be created and registered every time the
/// [BatchDocumentsPage] is opened.
class BatchDocumentsBindings extends Bindings {
  @override
  void dependencies() {
    /// Register the [BatchDocumentsController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BatchDocumentsPage] is opened.
    Get.lazyPut<BatchDocumentsController>(
      () => BatchDocumentsController(),
      fenix: true,
    );

    /// Register the [CreateCoversSheetsController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BatchDocumentsPage] is opened.
    Get.lazyPut<CreateCoversSheetsController>(
      () => CreateCoversSheetsController(),
      fenix: true,
    );

    /// Register the [EditCoverSheetController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BatchDocumentsPage] is opened.
    Get.lazyPut<EditCoverSheetController>(
      () => EditCoverSheetController(),
      fenix: true,
    );

    /// Register the [SeatNumberController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BatchDocumentsPage] is opened.
    Get.lazyPut<SeatNumberController>(
      () => SeatNumberController(),
      fenix: true,
    );

    /// Register the [AttendanceController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BatchDocumentsPage] is opened.
    Get.lazyPut<AttendanceController>(
      () => AttendanceController(),
      fenix: true,
    );

    /// Register the [CoversSheetsController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BatchDocumentsPage] is opened.
    Get.lazyPut<CoversSheetsController>(
      () => CoversSheetsController(),
      fenix: true,
    );

    /// Register the [ProfileController] with the GetX dependency injection system.
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [BatchDocumentsPage] is opened.
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
  }
}

/// A class that is used to bind the dependencies of the
/// [ClassRoomPage] using the GetX dependency injection system.
class ClassRoomBindings extends Bindings {
  /// The dependencies method is a part of the Bindings class
  /// and is used to register the dependencies with the GetX
  /// dependency injection system.
  ///
  /// In this case, the [ClassRoomController] is registered with
  /// the GetX dependency injection system.
  @override
  void dependencies() {
    /// The [Get.lazyPut] method is used to register the
    /// [ClassRoomController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [ClassRoomPage] is opened.
    Get.lazyPut<ClassRoomController>(
      () => ClassRoomController(),
      fenix: true,
    );
  }
}

/// A class that is used to bind the dependencies of the
/// [CohortSettingsPage] using the GetX dependency injection system.
class CohortSettingsBindings extends Bindings {
  /// The dependencies method is a part of the Bindings class
  /// and is used to register the dependencies with the GetX
  /// dependency injection system.
  ///
  /// In this case, the [CohortsSettingsController] and
  /// [OperationCohortController] are registered with
  /// the GetX dependency injection system.
  @override
  void dependencies() {
    /// The [Get.lazyPut] method is used to register the
    /// [CohortsSettingsController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [CohortSettingsPage] is opened.
    Get.lazyPut<CohortsSettingsController>(
      () => CohortsSettingsController(),
      fenix: true,
    );

    /// The [Get.lazyPut] method is used to register the
    /// [OperationCohortController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [CohortSettingsPage] is opened.
    Get.lazyPut<OperationCohortController>(
      () => OperationCohortController(),
      fenix: true,
    );
  }
}

/// A class that is used to bind the dependencies of the
/// [ControlMissionPage] using the GetX dependency injection system.
class ControlMissingBindings extends Bindings {
  /// The dependencies method is a part of the Bindings class
  /// and is used to register the dependencies with the GetX
  /// dependency injection system.
  ///
  /// In this case, the [ControlMissionController],
  /// [DetailsAndReviewMissionController], [DistributeStudentsController],
  /// [DistributionController] and [ControlMissionOperationController]
  /// are registered with the GetX dependency injection system.
  @override
  void dependencies() {
    /// The [Get.lazyPut] method is used to register the
    /// [ControlMissionController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [ControlMissionPage] is opened.
    Get.lazyPut<ControlMissionController>(
      () => ControlMissionController(),
      fenix: true,
    );

    /// The [Get.lazyPut] method is used to register the
    /// [DetailsAndReviewMissionController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [ControlMissionPage] is opened.
    Get.lazyPut<DetailsAndReviewMissionController>(
      () => DetailsAndReviewMissionController(),
      fenix: true,
    );

    /// The [Get.lazyPut] method is used to register the
    /// [DistributeStudentsController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [ControlMissionPage] is opened.
    Get.lazyPut<DistributeStudentsController>(
      () => DistributeStudentsController(),
      fenix: true,
    );

    /// The [Get.lazyPut] method is used to register the
    /// [DistributionController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [ControlMissionPage] is opened.
    Get.lazyPut<DistributionController>(
      () => DistributionController(),
      fenix: true,
    );

    /// The [Get.lazyPut] method is used to register the
    /// [ControlMissionOperationController] with the GetX dependency injection
    /// system.
    ///
    /// The [fenix] parameter is set to `true` which means that the
    /// controller will be created and registered every time the
    /// [ControlMissionPage] is opened.
    Get.lazyPut<ControlMissionOperationController>(
      () => ControlMissionOperationController(),
      fenix: true,
    );
  }
}

/// The [CreateControlMissionBindings] class is a binding that is used to
/// register the [CreateControlMissionController] with the GetX dependency
/// injection system.
///
/// The [dependencies] method is overridden to register the
/// [CreateControlMissionController] with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controller will be created and registered every time the
/// [CreateControlMissionPage] is opened.
class CreateControlMissionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateControlMissionController>(
      () => CreateControlMissionController(),
      fenix: true,
    );
  }
}

/// The [DashBoardBindings] class is a binding that is used to
/// register the [DashboardController] and [ProfileController] with the
/// GetX dependency injection system.
///
/// The [dependencies] method is overridden to register the
/// [DashboardController] and [ProfileController] with the GetX dependency
/// injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controllers will be created and registered every time the
/// [DashboardPage] is opened.
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

/// The [ProctorBindings] class is a binding that is used to
/// register the [ProctorController] with the GetX dependency injection system.
///
/// The [dependencies] method is overridden to register the
/// [ProctorController] with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controller will be created and registered every time the
/// [ProctorPage] is opened.
class ProctorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProctorController>(
      () => ProctorController(),
      fenix: true,
    );
  }
}

/// The [RolesBindings] class is a binding that is used to
/// register the [PrivilegesController] with the GetX dependency injection system.
///
/// The [dependencies] method is overridden to register the
/// [PrivilegesController] with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controller will be created and registered every time the
/// [RolesPage] is opened.
class RolesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivilegesController>(
      () => PrivilegesController(),
      fenix: true,
    );
  }
}

/// The [SchoolSettingBindings] class is a binding that is used to
/// register the [SchoolController] with the GetX dependency injection system.
///
/// The [dependencies] method is overridden to register the
/// [SchoolController] with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the
/// controller will be created and registered every time the
/// [SchoolSettingPage] is opened.
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
    Get.lazyPut<SideMenuGetController>(
      () => SideMenuGetController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}

/// The [StudentsBindings] class is a binding that is used to register the
/// [AddNewStudentController], [StudentController], and [TransferStudentController]
/// with the GetX dependency injection system.
///
/// The [dependencies] method is overridden to register the above controllers
/// with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the controllers
/// will be created and registered every time the [StudentPage] is opened.
class StudentsBindings extends Bindings {
  @override
  void dependencies() {
    /// The [AddNewStudentController] is used to add a new student to the
    /// school.
    Get.lazyPut<AddNewStudentController>(
      () => AddNewStudentController(),
      fenix: true,
    );

    /// The [StudentController] is used to manage students in the school.
    Get.lazyPut<StudentController>(
      () => StudentController(),
      fenix: true,
    );

    /// The [TransferStudentController] is used to transfer a student from one
    /// school to another.
    Get.lazyPut<TransferStudentController>(
      () => TransferStudentController(),
      fenix: true,
    );
  }
}

/// The [SubjectSettingBindings] class is a binding that is used to register the
/// [SubjectsController] and [EditSubjectsController] with the GetX dependency
/// injection system.
///
/// The [dependencies] method is overridden to register the above controllers
/// with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the controllers
/// will be created and registered every time the [SubjectSettingsPage] is opened.
class SubjectSettingBindings extends Bindings {
  @override
  void dependencies() {
    /// The [SubjectsController] is used to manage subjects in the school.
    Get.lazyPut<SubjectsController>(
      () => SubjectsController(),
      fenix: true,
    );

    /// The [EditSubjectsController] is used to edit subjects in the school.
    Get.lazyPut<EditSubjectsController>(
      () => EditSubjectsController(),
      fenix: true,
    );

    /// The [SchoolController] is used to manage schools in the system.
    Get.lazyPut<SchoolController>(
      () => SchoolController(),
      fenix: true,
    );

    /// The [OperationController] is used to manage operations in the system.
    Get.lazyPut<OperationController>(
      () => OperationController(),
      fenix: true,
    );
  }
}

/// The [SystemLoggerBindings] class is a binding that is used to register the
/// [SystemLoggerController] with the GetX dependency injection system.
///
/// The [dependencies] method is overridden to register the above controller
/// with the GetX dependency injection system.
///
/// The [fenix] parameter is set to `true` which means that the controller
/// will be created and registered every time the [SystemLoggerPage] is opened.
class SystemLoggerBindings extends Bindings {
  @override
  void dependencies() {
    /// The [SystemLoggerController] is used to manage system logs in the system.
    Get.lazyPut<SystemLoggerController>(
      () => SystemLoggerController(),
      fenix: true,
    );
  }
}

/// The [TokenBindings] class is a binding that is used to register the
/// [TokenService] with the GetX dependency injection system.
///
/// The [dependencies] method is overridden to register the above service
/// with the GetX dependency injection system.
///
/// The `permanent: true` parameter is used to ensure that the service is
/// created and registered only once, and is not recreated every time the
/// binding is used.
class TokenBindings extends Bindings {
  @override
  void dependencies() {
    /// The [TokenService] is a service that is used to manage the access token
    /// of the user in the system.
    Get.put(TokenService(), permanent: true);
  }
}
