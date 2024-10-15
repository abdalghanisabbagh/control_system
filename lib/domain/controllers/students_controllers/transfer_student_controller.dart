import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/cohort/cohorts_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/school/school_response/schools_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import '../controllers.dart';

class TransferStudentController extends GetxController {
  List<ValueItem> classesOptions = [];
  List<ValueItem> cohortsOptions = [];
  List<ValueItem> gradesOptions = [];
  bool isLoadingClassRooms = false;
  bool isLoadingCohorts = false;
  bool isLoadingGrades = false;
  bool isLoadingSchools = false;
  List<ValueItem> schoolsOptions = [];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemCohort;
  ValueItem? selectedItemGrade;
  ValueItem? selectedItemSchool;
  bool transferLoading = false;

  /// Gets all the grades for the given school id from the API and sets the
  /// [gradesOptions] with the grades returned by the API.
  ///
  /// It sets the [isLoadingGrades] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
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

  /// Gets all the classes rooms for the given school id from the API and sets the
  /// [classesOptions] with the classes rooms returned by the API.
  ///
  /// It sets the [isLoadingClassRooms] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
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

  /// Gets all the cohorts for the given school id from the API and sets the
  /// [cohortsOptions] with the cohorts returned by the API.
  ///
  /// It sets the [isLoadingCohorts] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
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

  /// Gets all schools from the API and sets the [schoolsOptions] with the
  /// schools returned by the API.
  ///
  /// It sets the [isLoadingSchools] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the transfer student
  /// page.
  ///
  /// The function returns a boolean indicating whether the schools were
  /// retrieved successfully.
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

  /// Changes the selected class room when the user selects a different class room from the drop down.
  ///
  /// The function takes a [List<ValueItem>] as a parameter which is the list of the selected class rooms.
  ///
  /// If the list is empty, it sets [selectedItemClassRoom] to null. Otherwise, it sets [selectedItemClassRoom] to the first element of the list.
  ///
  /// The function then calls [update] to update the UI.
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

  /// Changes the selected cohort when the user selects a different cohort from the drop down.
  ///
  /// The function takes a [List<ValueItem>] as a parameter which is the list of the selected cohorts.
  ///
  /// If the list is empty, it sets [selectedItemCohort] to null. Otherwise, it sets [selectedItemCohort] to the first element of the list.
  ///
  /// The function then calls [update] to update the UI.
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

  /// Changes the selected grade when the user selects a different grade from the drop down.
  ///
  /// The function takes a [List<ValueItem>] as a parameter which is the list of the selected grades.
  ///
  /// If the list is empty, it sets [selectedItemGrade] to null. Otherwise, it sets [selectedItemGrade] to the first element of the list.
  ///
  /// The function then calls [update] to update the UI.
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

  /// The onInit function of the [TransferStudentController] class.
  ///
  /// The function is called when the controller is initialized.
  ///
  /// The function sets [isLoadingSchools] to true and updates the UI.
  ///
  /// Then, it waits for the [getSchools] function to finish and sets
  /// [isLoadingSchools] to false.
  ///
  /// Finally, it updates the UI.
  ///
  /// The function is asynchronous and returns a [Future<void>].
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

  /// Changes the selected school when the user selects a different school from the drop down.
  ///
  /// The function takes a [List<ValueItem>] as a parameter which is the list of the selected schools.
  ///
  /// If the list is empty, it sets all the selected items to null. Otherwise, it sets [selectedItemSchool] to the first element of the list and calls the [getAllGradesSchoolId], [getCohortsBySchoolId], and [getClassRoomsBySchoolId] functions to get the grades, cohorts, and class rooms for the selected school.
  ///
  /// The function then calls [update] to update the UI.
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
            selectedItemGrade = null,
            selectedItemCohort = null,
            selectedItemClassRoom = null,
            getAllGradesSchoolId(),
            getCohortsBySchoolId(),
            getClassRoomsBySchoolId()
          };
    update();
  }

  /// Transfers the student with the given [studentId] to the selected school, grade, cohort, and class room.
  ///
  /// The function first checks if the selected school, grade, cohort, and class room are null.
  /// If any of them are null, it shows an error dialog with the appropriate message.
  ///
  /// If all of them are not null, it makes a PATCH request to the server to transfer the student.
  ///
  /// If the response is a failure, it shows an error dialog with the failure message.
  ///
  /// If the response is a success, it shows a success flash bar with a message indicating that the student has been transferred successfully.
  ///
  /// The function also calls [update] to update the UI and [Get.find<StudentController>().onInit()] to update the students list.
  ///
  /// The function is asynchronous and returns a [Future<void>].
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
