import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/cohort/cohort_res_model.dart';
import 'package:control_system/Data/Models/education_year/education_year_model.dart';
import 'package:control_system/Data/Models/education_year/educations_years_res_model.dart';
import 'package:control_system/Data/Models/exam_room/exam_room_res_model.dart';
import 'package:control_system/Data/Models/school/grade_response/grade_res_model.dart';
import 'package:control_system/Data/Models/school/grade_response/grades_res_model.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/app/extensions/convert_date_string_to_iso8601_string_extension.dart';
import 'package:control_system/app/extensions/pluto_row_extension.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../Data/Models/class_room/class_room_res_model.dart';
import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/cohort/cohorts_res_model.dart';
import '../../../Data/Models/control_mission/control_mission_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Models/student/students_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';

class ControlMissionController extends GetxController {
  PlutoGridStateManager? includedStudentsStateManager;
  PlutoGridStateManager? excludedStudentsStateManager;
  List<EducationYearModel> educationYearList = [];
  String? batchName;
  String? selectedStartDate;
  String? selectedEndDate;
  int currentStep = 0;

  List<GradeResModel> grades = [];
  List<ValueItem> optionsGrades = [];
  List<int> selectedGradesIds = [];

  List<ClassRoomResModel> classesRooms = [];

  List<CohortResModel> cohorts = [];

  List<StudentResModel> students = [];
  List<PlutoRow> includedStudentsRows = [];
  List<PlutoRow> excludedStudentsRows = [];

  List<ValueItem>? selectedEducationYear;
  bool isLoading = false;
  bool isLodingGetEducationYears = false;
  bool isLodingGetClassesRooms = false;

  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  ValueItem? selectedItemEducationYear;

  Future<void> getExamRoomByControlMissionId(int controlMissionId) async {
    isLodingGetClassesRooms = true;
    update();

    final response = await ResponseHandler<ExamRoomResModel>().getResponse(
      path: "${ExamLinks.examRoomsControlMission}/$controlMissionId",
      converter: ExamRoomResModel.fromJson,
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
        //  print("dfghjk");
        // educationYearList = r.data!;
        // List<ValueItem> items = r.data!
        //     .map((item) => ValueItem(label: item.name!, value: item.id))
        //     .toList();
        // optionsEducationYear = items;
        update();
      },
    );

    isLodingGetClassesRooms = false;
    update();
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

  Future<bool> addControlMission() async {
    if (selectedGradesIds.isEmpty) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'Please select grades',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      return false;
    }
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
        'grades_ID': selectedGradesIds
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
    getControlMissionByEducationYear(selectedEducationYear!.first.value);
    update();
    return success;
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

  Future<bool> getCohorts() async {
    bool gotData = false;
    update();
    int selectedSchoolId = Hive.box('School').get('SchoolTypeID');

    ResponseHandler<CohortsResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortsResModel> response =
        await responseHandler.getResponse(
      path: "${SchoolsLinks.getCohortBySchoolType}/$selectedSchoolId",
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
        gotData = false;
      },
      (r) {
        cohorts = r.data!;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  Future<bool> getClassRooms() async {
    bool gotData = false;
    update();
    int schoolId = Hive.box('School').get('Id');

    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ClassesRoomsResModel> response =
        await responseHandler.getResponse(
      path: "${SchoolsLinks.getSchoolsClassesBySchoolId}/$schoolId",
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
        gotData = false;
      },
      (r) {
        classesRooms = r.data!;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  Future<bool> getControlMissionByEducationYear(int educationYearId) async {
    bool gotData = false;
    isLoading = true;
    update();

    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionSchool}/${Hive.box('School').get('Id')}/${ControlMissionLinks.controlMissionEducationYear}/$educationYearId",
      converter: ControlMissionsResModel.fromJson,
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
        controlMissionList = r.data!;
        gotData = true;
      },
    );
    isLoading = false;
    update();
    return gotData;
  }

  void setSelectedItemEducationYear(List<ValueItem> items) {
    selectedItemEducationYear = items.first;
    int educationYearId = selectedItemEducationYear!.value;
    getControlMissionByEducationYear(educationYearId);
    update();
  }

  void updateSelectedGrades(List<ValueItem> selectedOptions) {
    selectedGradesIds = selectedOptions.map((e) => e.value as int).toList();
    includedStudentsRows.assignAll(
      students
          .where((student) => selectedGradesIds.contains(student.gradesID))
          .toList()
          .convertStudentsToRows(
            cohorts: cohorts,
            classesRooms: classesRooms,
            grades: grades,
          ),
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
        element.cells['IdField']!.value ==
        rendererContext.row.cells['IdField']!.value));
    includedStudentsRows.removeWhere((element) =>
        element.cells['IdField']!.value ==
        rendererContext.row.cells['IdField']!.value);
    includedStudentsStateManager?.notifyListeners();
    excludedStudentsRows.length == 1
        ? excludedStudentsStateManager?.setPage(1)
        : excludedStudentsStateManager?.notifyListeners();
  }

  void includeStudent(PlutoColumnRendererContext rendererContext) {
    includedStudentsRows.add(excludedStudentsRows.firstWhere((element) =>
        element.cells['IdField']!.value ==
        rendererContext.row.cells['IdField']!.value));
    excludedStudentsRows.removeWhere((element) =>
        element.cells['IdField']!.value ==
        rendererContext.row.cells['IdField']!.value);
    includedStudentsStateManager?.notifyListeners();
    excludedStudentsStateManager?.notifyListeners();
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.wait([
      getEducationYears(),
      getGrades(),
      getClassRooms(),
      getCohorts(),
    ]).then((_) async {
      getStudents();
    });
  }
}
