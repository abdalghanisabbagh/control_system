import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/exam_mission/exam_mission_res_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../../../Data/Models/control_mission/control_mission_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
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
  TextEditingController dateController = TextEditingController();
  TextEditingController examFinalDegreeController = TextEditingController();
  List<GradeResModel> gradesList = <GradeResModel>[];
  bool is2Version = false;
  bool isLoadingGetControlMission = false;
  bool isLodingGetSubject = false;
  bool isLodingGetExamMission = false;
  bool isLoadingGrades = false;
  bool isLoadingGetEducationYear = false;
  bool isLodingAddExamMission = false;
  bool isNight = false;

  List<SubjectResModel> subjectsList = <SubjectResModel>[];
  List<ExamMissionResModel> examMissionsList = <ExamMissionResModel>[];
  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ValueItem> optionsControlMission = <ValueItem>[];
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
  DateTime selectedDate = DateTime.now();
  String? selectedDay;
  ValueItem? selectedIExamDuration;
  ValueItem? selectedItemControlMission;
  ValueItem? selectedItemEducationYear;
  ValueItem? selectedItemGrade;
  ValueItem? selectedItemSubject;
  String? selectedMonth;
  String? selectedYear;

  @override
  void onInit() {
    super.onInit();
    geteducationyear();
    getGradesBySchoolId();
    getAllSubjects();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate = picked;
      selectedDay = picked.day.toString();
      selectedMonth = picked.month.toString();
      selectedYear = picked.year.toString();
      dateController.text = DateFormat('dd MMMM yyyy').format(selectedDate);
    }
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

  void setSelectedItemControlMission(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedItemControlMission = items.first;
      //  int controlMission = selectedItemControlMission!.value;
    } else {
      selectedItemControlMission = null;
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

  Future<bool> addNewExamMission({
    required int subjectId,
    required int controlMissionId,
    required int gradeId,
    required int educationyearId,
    required String year,
    required String month,
    required String finalDegree,
  }) async {
    isLodingAddExamMission = true;

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
    );

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
      //  studentController.getStudents();
      addExamMissionHasBeenAdded = true;
    });
    isLodingAddExamMission = false;

    update();
    return addExamMissionHasBeenAdded;
  }
}
