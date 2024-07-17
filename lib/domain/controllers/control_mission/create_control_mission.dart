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
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

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
  bool isLodingGetEducationYears = false;
  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ValueItem> optionsGrades = [];
  List<ValueItem>? selectedEducationYear;
  String? selectedEndDate;
  List<int> selectedGradesIds = [];
  String? selectedStartDate;
  List<StudentResModel> students = [];

  @override
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

  Future<bool> getGrades() async {
    bool gotData = false;
    update();
    int schoolId = Hive.box('School').get('Id');

    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();
    Either<Failure, GradesResModel> response =
        await responseHandler.getResponse(
      path: "${SchoolsLinks.gradesSchools}/$schoolId",
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

  Future<void> getEducationYears() async {
    isLodingGetEducationYears = true;
    update();

    final response = await ResponseHandler<EducationsYearsModel>().getResponse(
      path: EducationYearsLinks.educationyear,
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

    isLodingGetEducationYears = false;
    update();
  }

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

  bool canMoveToNextStep() {
    return selectedEndDate != null &&
        (batchName != null || batchName != null
            ? batchName!.isNotEmpty
            : false);
  }

  void continueToNextStep() {
    if (currentStep == 0) {
      currentStep++;
    }
    update();
  }

  void backToPreviousStep() {
    if (currentStep == 1) {
      currentStep--;
    }
    update();
  }

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

  void includeStudent(PlutoColumnRendererContext rendererContext) {
    includedStudentsRows.add(excludedStudentsRows.firstWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value));
    excludedStudentsRows.removeWhere((element) =>
        element.cells['BlbIdField']!.value ==
        rendererContext.row.cells['BlbIdField']!.value);
    includedStudentsStateManager?.notifyListeners();
    excludedStudentsStateManager?.notifyListeners();
  }

  Future<bool> addControlMission() async {
    bool success = false;
    isLoading = true;
    update();
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

  Future<bool> createStudentSeatNumbers() async {
    bool success = false;
    isLoading = true;
    update();
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
}
