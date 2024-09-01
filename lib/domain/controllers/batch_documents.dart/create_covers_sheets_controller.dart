import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Models/subject/subjects_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class CreateCoversSheetsController extends GetxController {
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  ControlMissionResModel? controlMissionResModel;
  List<ExamMissionResModel> examMissionsList = <ExamMissionResModel>[];
  List<GradeResModel> gradesList = <GradeResModel>[];
  bool is2Version = false;
  bool isLoadingGetControlMission = false;
  bool isLoadingGetEducationYear = false;
  bool isLoadingGrades = false;
  bool isLodingGetExamMission = false;
  bool isLodingGetSubject = false;
  bool isPeriod = false;
  List<ValueItem> optionsControlMission = <ValueItem>[];
  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ValueItem> optionsExamDurations = [
    const ValueItem(value: 15, label: '15 Mins'),
    const ValueItem(value: 25, label: '25 Mins'),
    const ValueItem(value: 45, label: '45 Mins'),
    const ValueItem(value: 60, label: '60 Mins'),
    const ValueItem(value: 70, label: '70 Mins'),
    const ValueItem(value: 75, label: '75 Mins'),
    const ValueItem(value: 85, label: '85 Mins'),
    const ValueItem(value: 90, label: '90 Mins'),
    const ValueItem(value: 100, label: '100 Mins'),
    const ValueItem(value: 105, label: '105 Mins'),
    const ValueItem(value: 120, label: '120 Mins'),
    const ValueItem(value: 130, label: '130 Mins'),
    const ValueItem(value: 150, label: '150 Mins')
  ];

  List<ValueItem> optionsGrades = <ValueItem>[];
  List<ValueItem> optionsSubjects = <ValueItem>[];
  final int schoolId = Hive.box('School').get('Id');
  ValueItem? selectedIExamDuration;
  ValueItem? selectedItemControlMission;
  ValueItem? selectedItemEducationYear;
  ValueItem? selectedItemGrade;
  ValueItem? selectedItemSubject;
  List<SubjectResModel> subjectsList = <SubjectResModel>[];

  Future<void> getAllSubjects() async {
    isLodingGetSubject = true;

    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path: SubjectsLinks.subjects,
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
        subjectsList = r.data!;
        optionsSubjects.assignAll(
          subjectsList.map(
            (e) => ValueItem(
              label: e.name!,
              value: e.iD,
            ),
          ),
        );

        isLodingGetSubject = false;
        update();
      },
    );
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
        optionsControlMission.assignAll(
          controlMissionList.map(
            (e) => ValueItem(
              label: e.name!,
              value: e.iD,
            ),
          ),
        );
      },
    );
    isLoadingGetControlMission = false;
    update();
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

  Future<void> getGradesBySchoolId() async {
    isLoadingGrades = true;

    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: GradeLinks.gradesSchools,
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
      gradesList = result.data!;
      optionsGrades.assignAll(
        gradesList.map(
          (e) => ValueItem(
            label: e.name!,
            value: e.iD,
          ),
        ),
      );

      update();
    });
    isLoadingGrades = false;
  }

  @override
  void onInit() {
    super.onInit();
    geteducationyear();
    getGradesBySchoolId();
    getAllSubjects();
  }

  void setSelectedItemControlMission(List<ValueItem> items) {
    if (items.isNotEmpty) {
      controlMissionResModel = controlMissionList.firstWhereOrNull(
        (element) => element.iD == selectedItemControlMission!.value,
      );
    } else {
      selectedItemControlMission = null;
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
    }

    update();
  }

  void setSelectedItemGrade(List<ValueItem> items) {
    selectedItemGrade = items.first;
    update();
  }

  void setSelectedItemSubject(List<ValueItem> items) {
    selectedItemSubject = items.first;
    update();
  }

  // @override
  // void onClose() {
  //   dateController.dispose();
  //   examFinalDegreeController.dispose();
  //   super.onClose();
  // }
}
