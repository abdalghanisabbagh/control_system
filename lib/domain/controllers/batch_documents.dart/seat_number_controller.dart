import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/exam_mission/exam_mission_res_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/exam_mission/exam_missions_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class SeatNumberController extends GetxController {
  bool isLoadingGetEducationYear = false;
  bool isLoadingGetControlMission = false;
  bool isLodingGetExamMission = false;
  bool isLoadingGrades = false;
  bool isLoading = false;
  List<ValueItem> optionsEducationYear = [];
  ValueItem? selectedItemEducationYear;
  List<ValueItem> optionsControlMission = [];
  ValueItem? selectedItemControlMission;
  List<ValueItem> optionsGrades = [];
  List<ExamMissionResModel> examMissionsList = [];
  List<ExamMissionResModel> filteredExamMissionsList = [];
  List<ControlMissionResModel> controlMissionList = [];
  ValueItem? selectedItemGrade;
  ControlMissionResModel? controlMissionObject;

  final int schoolId = Hive.box('School').get('Id');

  @override
  void onInit() {
    geteducationyear();
    super.onInit();
  }

  Future<void> updateFilteredList(ValueItem? selectedItemGrade) async {
    if (selectedItemGrade == null) {
      filteredExamMissionsList = examMissionsList;
    } else {
      filteredExamMissionsList = examMissionsList.where((mission) {
        bool matchesGrade = mission.gradesID == selectedItemGrade.value;

        return matchesGrade;
      }).toList();
    }
    update();
  }

  void setSelectedItemControlMission(List<ValueItem> items) async {
    if (items.isNotEmpty) {
      selectedItemControlMission = items.first;
      controlMissionObject = controlMissionList.firstWhereOrNull(
        (element) => element.iD == selectedItemControlMission!.value,
      );

      isLoading = true;
      update();
      await Future.wait([
        getGradesBySchoolId(),
        getAllExamMissionsByControlMission(selectedItemControlMission!.value)
      ]);
      isLoading = false;
      update();

      updateFilteredList(null);
    } else {
      selectedItemControlMission = null;
      examMissionsList.clear();
      filteredExamMissionsList.clear();
    }

    update();
  }

  void setSelectedItemGrade(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedItemGrade = items.first;
      updateFilteredList(selectedItemGrade);
    } else {
      updateFilteredList(null);
      selectedItemGrade = null;
    }
    update();
  }

  Future<void> getAllExamMissionsByControlMission(int controlMissionId) async {
    isLodingGetExamMission = true;

    update();
    ResponseHandler<ExamMissionsResModel> responseHandler = ResponseHandler();
    Either<Failure, ExamMissionsResModel> response =
        await responseHandler.getResponse(
      path: "${ExamLinks.examMissionControlMission}/$controlMissionId",
      converter: ExamMissionsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        update();
      },
      (r) {
        examMissionsList = r.data!;
        updateFilteredList(null);
        isLodingGetExamMission = false;
        update();
      },
    );
  }

  Future<void> geteducationyear() async {
    isLoadingGetEducationYear = true;
    update();
    ResponseHandler<EducationsYearsModel> responseHandler = ResponseHandler();
    Either<Failure, EducationsYearsModel> response =
        await responseHandler.getResponse(
      path: EducationYearsLinks.educationyear,
      converter: EducationsYearsModel.fromJson,
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
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.id))
            .toList();
        optionsEducationYear = items;
      },
    );

    isLoadingGetEducationYear = false;
    update();
  }

  void setSelectedItemEducationYear(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedItemEducationYear = items.first;
      int educationYearId = selectedItemEducationYear!.value;
      getControlMissionByEducationYearAndBySchool(educationYearId);
    } else {
      selectedItemEducationYear = null;
      examMissionsList.clear();
      filteredExamMissionsList.clear();
      selectedItemControlMission = null;
    }

    update();
  }

  Future<void> getControlMissionByEducationYearAndBySchool(
      int educationYearId) async {
    isLoadingGetControlMission = true;

    update();

    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionSchool}/$schoolId/${ControlMissionLinks.controlMissionEducationYear}/$educationYearId",
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
      },
      (r) {
        controlMissionList = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsControlMission = items;
      },
    );
    isLoadingGetControlMission = false;
    update();
  }

  Future<void> getGradesBySchoolId() async {
    isLoadingGrades = true;

    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${SchoolsLinks.gradesSchools}/$schoolId",
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsGrades = items;
    });
    isLoadingGrades = false;
  }
}
