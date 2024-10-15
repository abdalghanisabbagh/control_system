import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../Data/Models/class_room/class_room_res_model.dart';
import '../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/education_year/education_year_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Models/student/students_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../app/extensions/convert_date_string_to_iso8601_string_extension.dart';
import '../../../app/extensions/pluto_row_extension.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class CreateControlMissionController extends GetxController {
  String? batchName;
  List<ClassRoomResModel> classesRooms = [];
  List<CohortResModel> cohorts = [];
  int controlMissionId = -1;
  int currentStep = 0;
  List<EducationYearModel> educationYearList = [];
  List<PlutoRow> excludedStudentsRows = [];
  PlutoGridStateManager? excludedStudentsStateManager;
  List<GradeResModel> grades = [];
  List<int> includedStudentsIds = [];
  List<PlutoRow> includedStudentsRows = [];
  PlutoGridStateManager? includedStudentsStateManager;
  bool isLoading = false;
  bool isLoadingGetEducationYears = false;
  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ValueItem> optionsGrades = [];
  List<ValueItem>? selectedEducationYear;
  String? selectedEndDate;
  List<int> selectedGradesIds = [];
  String? selectedStartDate;
  List<StudentResModel> students = [];

  /// A function that adds a control mission to the database with the given parameters and returns a boolean indicating whether the add was successful.
  ///
  /// The function takes the following parameters:
  ///
  /// - [selectedEducationYear]: The ID of the selected education year.
  /// - [batchName]: The name of the batch.
  /// - [selectedStartDate]: The start date of the mission.
  /// - [selectedEndDate]: The end date of the mission.
  ///
  /// The function will return a boolean indicating whether the add was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the list of control missions in the [CoversSheetsController] and reset the UI to show that no file has been imported.
  Future<bool> addControlMission() async {
    bool success = false;
    isLoading = true;
    update();
    if (selectedEducationYear == null) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please select education year',
        dialogType: DialogType.error,
      ).showDialogue(
        Get.key.currentContext!,
      );
      success = false;
      isLoading = false;
      update();
      return success;
    } else if (batchName == null || batchName!.isEmpty) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please enter mission name',
        dialogType: DialogType.error,
      ).showDialogue(
        Get.key.currentContext!,
      );
      success = false;
      isLoading = false;
      update();
      return success;
    } else if (selectedStartDate == null) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please select start date',
        dialogType: DialogType.error,
      ).showDialogue(
        Get.key.currentContext!,
      );
      success = false;
      isLoading = false;
      update();
      return success;
    } else if (selectedEndDate == null) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please select end date',
        dialogType: DialogType.error,
      ).showDialogue(
        Get.key.currentContext!,
      );
      success = false;
      isLoading = false;
      update();
      return success;
    }

    final response =
        await ResponseHandler<ControlMissionResModel>().getResponse(
      path: ControlMissionLinks.controlMission,
      converter: ControlMissionResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        'Education_year_ID': selectedEducationYear!.first.value,
        'Schools_ID': Hive.box('School').get('Id'),
        'Name': batchName,
        'Start_Date': selectedStartDate!.convertDateStringToIso8601String(),
        'End_Date': selectedEndDate!.convertDateStringToIso8601String(),
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
        success = false;
      },
      (r) {
        controlMissionId = r.iD!;
        success = true;
      },
    );
    isLoading = false;
    update();
    return success;
  }

  /// Goes back to the previous step in the control mission creation process.
  ///
  /// This function checks if the current step is 1 and if so, decrements the
  /// step by one. It then calls the [update] function to update the UI.
  ///
  /// This function is used when the user wants to go back to the previous step
  /// while creating a control mission.
  void backToPreviousStep() {
    if (currentStep == 1) {
      currentStep--;
    }
    update();
  }

  bool canMoveToNextStep() {
    return selectedEndDate != null &&
        (batchName != null || batchName != null
            ? batchName!.isNotEmpty
            : false);
  }

  /// Goes to the next step in the control mission creation process.
  ///
  /// This function checks if the current step is 0 and if so, increments the
  /// step by one. It then calls the [update] function to update the UI.
  ///
  /// This function is used when the user wants to go to the next step while
  /// creating a control mission.
  void continueToNextStep() {
    if (currentStep == 0) {
      currentStep++;
    }
    update();
  }

  /// A function that creates student seat numbers in the database and returns a boolean indicating whether the operation was successful.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show a loading indicator while the request is being processed.
  ///
  /// If the user has not selected any students, the function will show an error dialog with the message 'Please select students'.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will return true.
  ///
  Future<bool> createStudentSeatNumbers() async {
    bool success = false;
    isLoading = true;
    update();
    if (includedStudentsRows.isEmpty) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please select students',
        dialogType: DialogType.error,
      ).showDialogue(
        Get.key.currentContext!,
      );
      success = false;
      isLoading = false;
      update();
      return success;
    }

    List<int> blbIds = includedStudentsRows
        .map((e) => int.parse(e.cells['BlbIdField']!.value))
        .toList();
    includedStudentsIds = students
        .where((e) => blbIds.contains(e.blbId))
        .map(
          (e) => e.iD!,
        )
        .toList();

    final response = await ResponseHandler<void>().getResponse(
      path: ControlMissionLinks.studentSeatNumbers,
      converter: (_) {},
      type: ReqTypeEnum.POST,
      body: {
        'Student_IDs': includedStudentsIds,
        'controlMissionId': controlMissionId,
      },
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
        success = false;
      },
      (r) {
        success = true;
      },
    );
    isLoading = false;
    update();
    return success;
  }

  /// This function excludes a student from the control mission.
  ///
  /// It takes a [PlutoColumnRendererContext] as a parameter.
  ///
  /// The function will remove the student from the [includedStudentsRows] and add it to the [excludedStudentsRows].
  ///
  /// It will also notify the listeners of the [includedStudentsStateManager] and [excludedStudentsStateManager] to update the UI.
  void excludeStudent(PlutoColumnRendererContext rendererContext) {
    excludedStudentsRows.add(includedStudentsRows.firstWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value));
    includedStudentsRows.removeWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value);
    includedStudentsStateManager?.notifyListeners();
    excludedStudentsStateManager?.setPage(1);
  }

  /// Gets all the education years from the API and sets the [optionsEducationYear] with the education years returned by the API.
  ///
  /// It sets the [isLoadingGetEducationYears] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// It will also update the UI to show a loading indicator while the request is being processed.
  Future<void> getEducationYears() async {
    isLoadingGetEducationYears = true;
    update();

    final response = await ResponseHandler<EducationsYearsModel>().getResponse(
      path: EducationYearsLinks.educationYear,
      converter: EducationsYearsModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        educationYearList = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.id))
            .toList();
        optionsEducationYear = items;
        update();
      },
    );

    isLoadingGetEducationYears = false;
    update();
  }

  /// Gets all grades from the API and assigns them to [grades] and [optionsGrades].
  ///
  /// It takes no parameters.
  ///
  /// The function will return a boolean indicating whether the grades were
  /// retrieved successfully.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  Future<bool> getGrades() async {
    bool gotData = false;
    update();

    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();
    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: GradeLinks.gradesSchools,
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
        gotData = false;
      },
      (r) {
        grades = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsGrades = items;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  /// Gets all students from the API and assigns them to [students].
  ///
  /// It takes no parameters.
  ///
  /// The function will return a boolean indicating whether the students were
  /// retrieved successfully.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  Future<bool> getStudents() async {
    bool gotData = false;
    update();

    ResponseHandler<StudentsResModel> responseHandler = ResponseHandler();
    Either<Failure, StudentsResModel> response =
        await responseHandler.getResponse(
      path: '${StudentsLinks.studentSchool}/${Hive.box('School').get('Id')}',
      converter: StudentsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gotData = false;
      },
      (r) {
        students = r.students!;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  /// Adds a student to the list of included students and removes it from the list
  /// of excluded students.
  ///
  /// It takes a [PlutoColumnRendererContext] as a parameter.
  ///
  /// The function will add the student whose ID is equal to the value of the
  /// cell with the key 'BlbIdField' in the given [rendererContext] to the list
  /// of included students and remove the same student from the list of excluded
  /// students.
  ///
  /// The function will also set the page of the [includedStudentsStateManager] to
  /// 1 and notify the listeners of the [excludedStudentsStateManager] to update
  /// the UI.
  void includeStudent(PlutoColumnRendererContext rendererContext) {
    includedStudentsRows.add(excludedStudentsRows.firstWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value));
    excludedStudentsRows.removeWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value);
    includedStudentsStateManager?.setPage(1);
    excludedStudentsStateManager?.notifyListeners();
  }

  @override

  /// Called when the widget is initialized.
  ///
  /// It calls the [getEducationYears], [getGrades] and [getStudents] functions
  /// and then calls the super class [onInit] function.
  void onInit() async {
    super.onInit();
    isLoading = true;
    update();
    await Future.wait([
      getEducationYears(),
      getGrades(),
    ]).then((_) async {
      getStudents();
    });
    isLoading = false;
    update();
  }

  /// Updates the included students based on the selected grades.
  ///
  /// It takes a list of [ValueItem] as a parameter.
  ///
  /// The function will update the [selectedGradesIds] with the IDs of the selected grades.
  ///
  /// The function will then update the [includedStudentsRows] with the students that have
  /// the selected grades and clears the [excludedStudentsRows].
  ///
  /// The function will also notify the listeners of the [includedStudentsStateManager] and
  /// [excludedStudentsStateManager] to update the UI.
  void updateSelectedGrades(List<ValueItem> selectedOptions) {
    selectedGradesIds = selectedOptions.map((e) => e.value as int).toList();
    includedStudentsRows.assignAll(
      students
          .where((student) => selectedGradesIds.contains(student.gradesID))
          .toList()
          .convertStudentsToRows(),
    );
    update();
    excludedStudentsRows.clear();
    includedStudentsStateManager?.setPage(1);
    excludedStudentsStateManager?.setPage(1);
  }
}
