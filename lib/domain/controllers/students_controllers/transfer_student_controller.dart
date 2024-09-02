import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/class_room/classes_rooms_res_model.dart';
import 'package:control_system/Data/Models/cohort/cohorts_res_model.dart';
import 'package:control_system/Data/Models/student/student_res_model.dart';
import 'package:control_system/Data/Network/tools/failure_model.dart';
import 'package:control_system/domain/controllers/controllers.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/school/school_response/schools_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class TransferStudentController extends GetxController {
  bool isLoadingSchools = false;

  bool isLoadingGrades = false;

  bool isLoadingClassRooms = false;

  bool isLoadingCohorts = false;

  bool transferLoading = false;

  List<ValueItem> classesOptions = [];

  ValueItem? selectedItemClassRoom;

  List<ValueItem> cohortsOptions = [];

  ValueItem? selectedItemCohort;

  List<ValueItem> gradesOptions = [];

  ValueItem? selectedItemGrade;

  List<ValueItem> schoolsOptions = [];

  ValueItem? selectedItemSchool;

  Future<void> getAllGradesSchoolId() async {
    isLoadingGrades = true;
    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: '${GradeLinks.gradesSchools}/${selectedItemSchool!.value}',
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        gradesOptions = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
      },
    );
    isLoadingGrades = false;
    update();
  }

  Future<void> getClassRoomsBySchoolId() async {
    isLoadingClassRooms = true;
    update();

    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();

    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path:
          '${SchoolsLinks.schoolsClasses}/school/${selectedItemSchool!.value}',
      converter: ClassesRoomsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        classesOptions = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
      },
    );

    isLoadingClassRooms = false;
    update();
  }

  Future<void> getCohortsBySchoolId() async {
    isLoadingCohorts = true;
    update();
    ResponseHandler<CohortsResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortsResModel> response =
        await responseHandler.getResponse(
      path: '${CohortLinks.cohort}/school/${selectedItemSchool!.value}',
      converter: CohortsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        cohortsOptions = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
      },
    );
    isLoadingCohorts = false;
    update();
  }

  Future<void> getSchools() async {
    ResponseHandler<SchoolsResModel> responseHandler =
        ResponseHandler<SchoolsResModel>();
    Either<Failure, SchoolsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.getAllSchools,
      converter: SchoolsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        schoolsOptions.assignAll(
          r.data!
              .map(
                (item) => ValueItem(
                    label: '${item.name} (${item.schoolType?.name})',
                    value: item.iD),
              )
              .toList(),
        );
      },
    );
    update();
  }

  void onClassRoomChanged(List<ValueItem> value) {
    value.isEmpty
        ? {
            selectedItemClassRoom = null,
          }
        : {
            selectedItemClassRoom = value.first,
          };
    update();
  }

  void onCohortChanged(List<ValueItem> value) {
    value.isEmpty
        ? {
            selectedItemCohort = null,
          }
        : {
            selectedItemCohort = value.first,
          };
    update();
  }

  void onGradeChanged(List<ValueItem> value) {
    value.isEmpty
        ? {
            selectedItemGrade = null,
          }
        : {
            selectedItemGrade = value.first,
          };
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    isLoadingSchools = true;
    update();
    await Future.wait([
      getSchools(),
    ]);
    isLoadingSchools = false;
    update();
  }

  void onSchoolChanged(List<ValueItem> value) {
    value.isEmpty
        ? {
            selectedItemSchool = null,
            selectedItemGrade = null,
            selectedItemCohort = null,
            selectedItemClassRoom = null
          }
        : {
            selectedItemSchool = value.first,
            getAllGradesSchoolId(),
            getCohortsBySchoolId(),
            getClassRoomsBySchoolId()
          };
    update();
  }

  Future<void> transferStudent(int studentId) async {
    transferLoading = true;
    update();
    ResponseHandler<StudentResModel> responseHandler =
        ResponseHandler<StudentResModel>();
    if (selectedItemSchool == null) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please Select School',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      transferLoading = false;
      update();
      return;
    } else if (selectedItemGrade == null) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please Select Grade',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      transferLoading = false;
      update();
      return;
    } else if (selectedItemClassRoom == null) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please Select Class Room',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      transferLoading = false;
      update();
      return;
    } else if (selectedItemCohort == null) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please Select Cohort',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      transferLoading = false;
      update();
      return;
    }

    Either<Failure, StudentResModel> response =
        await responseHandler.getResponse(
      path: '${StudentsLinks.student}/$studentId',
      converter: StudentResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {
        'Schools_ID': selectedItemSchool!.value,
        'Grades_ID': selectedItemGrade!.value,
        'Cohort_ID': selectedItemCohort!.value,
        'School_Class_ID': selectedItemClassRoom!.value,
      },
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        Get.back();
        MyFlashBar.showSuccess(
                'Student ${r.firstName} ${r.secondName} ${r.thirdName} Transfered To ${selectedItemSchool!.label} Successfully',
                'Success')
            .show(Get.key.currentContext!);
      },
    );
    transferLoading = false;
    update();
    Get.find<StudentController>().onInit();
  }
}
