import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/control_mission/control_mission_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../Data/Models/exam_mission/exam_missions_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/subject/subjects_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class CoversSheetsController extends GetxController {
  List<ExamMissionResModel> examMissionsList = <ExamMissionResModel>[];
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  List<ExamMissionResModel> filteredExamMissionsList = [];

  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ValueItem> optionsControlMission = <ValueItem>[];
  List<ValueItem> optionsGrades = <ValueItem>[];
  List<ValueItem> optionsSubjects = <ValueItem>[];

  ControlMissionResModel? controlMissionObject;

  bool isLoadingGetControlMission = false;
  bool isLodingGetSubject = false;
  bool isLodingGetExamMission = false;
  bool isLoadingGrades = false;
  bool isLoadingGetEducationYear = false;
  bool isLoading = false;
  bool isLoadingAddExamMission = false;

  ValueItem? selectedItemControlMission;
  ValueItem? selectedItemEducationYear;
  ValueItem? selectedItemGrade;
  ValueItem? selectedSubject;

  final int schoolId = Hive.box('School').get('Id');
  final int schoolTypeId = Hive.box('School').get('SchoolTypeID');

  @override
  void onInit() {
    geteducationyear();
    super.onInit();
  }

  Future<void> updateFilteredList(
      ValueItem? selectedItemGrade, ValueItem? selectedItemSubject) async {
    if (selectedItemGrade == null && selectedItemSubject == null) {
      filteredExamMissionsList = examMissionsList;
    } else {
      filteredExamMissionsList = examMissionsList.where((mission) {
        bool matchesGrade = selectedItemGrade == null ||
            mission.gradesID == selectedItemGrade.value;
        bool matchesSubject = selectedItemSubject == null ||
            mission.subjectsID == selectedItemSubject.value;
        return matchesGrade && matchesSubject;
      }).toList();
    }
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

  void setSelectedItemControlMission(List<ValueItem> items) async {
    if (items.isNotEmpty) {
      selectedItemControlMission = items.first;
      controlMissionObject = controlMissionList.firstWhereOrNull(
        (element) => element.iD == selectedItemControlMission!.value,
      );

      isLoading = true;
      update();
      await Future.wait([
        getAllSubjects(),
        getGradesBySchoolId(),
        getAllExamMissionsByControlMission(selectedItemControlMission!.value)
      ]);
      isLoading = false;
      update();
      // await getAllExamMissionsByControlMission(
      //     selectedItemControlMission!.value);
      updateFilteredList(null, null);
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
      updateFilteredList(selectedItemGrade, null);
    } else {
      updateFilteredList(null, null);
      selectedItemGrade = null;
    }
    update();
  }

  void setSelectedItemSubject(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedSubject = items.first;
      updateFilteredList(null, selectedSubject);
    } else {
      updateFilteredList(null, null);
      selectedItemGrade = null;
    }
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
        selectedItemControlMission = null;
        filteredExamMissionsList.clear();
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

  Future<void> getAllSubjects() async {
    isLodingGetSubject = true;

    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.subjects,
      converter: SubjectsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLodingGetSubject = false;
        update();
      },
      (r) {
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsSubjects = items;

        isLodingGetSubject = false;
        update();
      },
    );
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
        isLodingGetSubject = false;
        update();
      },
      (r) {
        examMissionsList = r.data!;
        updateFilteredList(null, null);
        isLodingGetExamMission = false;
        update();
      },
    );
  }

  Future<bool> deleteExamMission({
    required int id,
  }) async {
    bool examMissionHasBeenDeleted = false;

    ResponseHandler<ExamMissionResModel> responseHandler = ResponseHandler();

    Either<Failure, ExamMissionResModel> response =
        await responseHandler.getResponse(
      path: '${ExamLinks.examMission}/$id',
      converter: ExamMissionResModel.fromJson,
      type: ReqTypeEnum.DELETE,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        examMissionHasBeenDeleted = false;
      },
      (r) {
        getAllExamMissionsByControlMission(selectedItemControlMission!.value);
        examMissionHasBeenDeleted = true;
      },
    );
    update();
    return examMissionHasBeenDeleted;
  }

  Future<bool> addNewExamMission({
    required int subjectId,
    required int controlMissionId,
    required int gradeId,
    required int educationyearId,
    required String year,
    required String month,
    required String finalDegree,
    required int duration,
  }) async {
    isLoadingAddExamMission = true;

    update();
    bool addExamMissionHasBeenAdded = false;
    ResponseHandler<ExamMissionResModel> responseHandler = ResponseHandler();

    ExamMissionResModel examMissionResModel = ExamMissionResModel(
        subjectsID: subjectId,
        controlMissionID: controlMissionId,
        gradesID: gradeId,
        educationYearID: educationyearId,
        year: year,
        month: month,
        finalDegree: finalDegree,
        duration: duration);

    var response = await responseHandler.getResponse(
        path: ExamLinks.examMission,
        converter: ExamMissionResModel.fromJson,
        type: ReqTypeEnum.POST,
        body: examMissionResModel.toJson());

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      addExamMissionHasBeenAdded = false;
    }, (result) {
      getAllExamMissionsByControlMission(selectedItemControlMission!.value);

      addExamMissionHasBeenAdded = true;
    });
    isLoadingAddExamMission = false;

    update();
    return addExamMissionHasBeenAdded;
  }
}
