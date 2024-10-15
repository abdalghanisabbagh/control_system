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
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class CreateCoversSheetsController extends GetxController {
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  ControlMissionResModel? controlMissionResModel;
  List<ExamMissionResModel> examMissionsList = <ExamMissionResModel>[];
  List<GradeResModel> gradesList = <GradeResModel>[];
  bool is2Version = false;
  bool isLoadingGetControlMission = false;
  bool isLoadingGetEducationYear = false;
  bool isLoadingGetExamMission = false;
  bool isLoadingGetSubject = false;
  bool isLoadingGrades = false;
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

  /// Gets all subjects from the server and updates the UI
  ///
  /// This function sends a GET request to the server to get all subjects
  /// for the current school type. The response is handled by the
  /// [ResponseHandler]. If the response is successful, the subjects list
  /// is updated and the UI is updated. If the response is not successful,
  /// an error dialog is shown with the error message from the response.
  ///
  /// The function also updates the options for the subject dropdown
  /// with the subjects from the response.
  Future<void> getAllSubjects() async {
    isLoadingGetSubject = true;

    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path:
          "${SubjectsLinks.subjectsBySchoolType}/${Hive.box('School').get('SchoolTypeID')}",
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
        isLoadingGetSubject = false;
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

        isLoadingGetSubject = false;
        update();
      },
    );
  }

  /// This function gets the control mission by education year and by school.
  ///
  /// It takes the education year id as a parameter.
  ///
  /// The function sends a GET request to the server and gets the response.
  /// If the response is successful, the function will update the list of
  /// control missions and the options for the control mission drop down.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the error message.
  ///
  /// The function will also update the UI to show or hide the loading indicator
  /// based on the status of the request.
  Future<void> getControlMissionByEducationYearAndBySchool(
      int educationYearId) async {
    isLoadingGetControlMission = true;

    update();

    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionActiveSchool}/$schoolId/${ControlMissionLinks.controlMissionEducationYear}/$educationYearId",
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

  /// Gets all the education years from the API and sets the
  /// [optionsEducationYear] with the education years returned by the API.
  ///
  /// It sets the [isLoadingGetEducationYear] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  Future<void> getEducationYear() async {
    isLoadingGetEducationYear = true;
    update();
    ResponseHandler<EducationsYearsModel> responseHandler = ResponseHandler();
    Either<Failure, EducationsYearsModel> response =
        await responseHandler.getResponse(
      path: EducationYearsLinks.educationYear,
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

  /// Gets all the grades from the API and sets the
  /// [optionsGrades] with the grades returned by the API.
  ///
  /// It sets the [isLoadingGrades] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// code and message.
  Future<void> getGradesBySchoolId() async {
    isLoadingGrades = true;

    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: GradeLinks.gradesSchools,
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
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

  /// This is the onInit function of the CreateCoversSheetsController class.
  ///
  /// It is called when the GetX controller is initialized.
  ///
  /// The function calls the following functions in order to initialize the required data:
  ///
  /// - [getEducationYear] to get the list of education year.
  /// - [getGradesBySchoolId] to get the list of grades for the selected school.
  /// - [getAllSubjects] to get the list of subjects.
  void onInit() {
    super.onInit();
    getEducationYear();
    getGradesBySchoolId();
    getAllSubjects();
  }

  /// Sets the selected control mission based on the given [items].
  ///
  /// If [items] is not empty, it will find the first control mission in the
  /// [controlMissionList] that matches the value of the first item in [items]
  /// and set it as the [controlMissionResModel].
  ///
  /// If [items] is empty, it will set [selectedItemControlMission] to null.
  ///
  /// Finally, it will call [update] to notify the UI of the changes.
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

  /// Sets the selected education year based on the given [items].
  ///
  /// If [items] is not empty, it will select the first education year in the
  /// [educationYearList] that matches the value of the first item in [items]
  /// and set it as the [selectedItemEducationYear].
  ///
  /// It will also call [getControlMissionByEducationYearAndBySchool] with the selected
  /// [educationYearId] to get the list of control missions for the selected education year.
  ///
  /// If [items] is empty, it will set [selectedItemEducationYear] to null.
  ///
  /// Finally, it will call [update] to notify the UI of the changes.
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

  /// Sets the selected grade based on the given [items].
  ///
  /// If [items] is not empty, it will select the first item in [items]
  /// and set it as the [selectedItemGrade].
  ///
  /// Finally, it will call [update] to notify the UI of the changes.
  void setSelectedItemGrade(List<ValueItem> items) {
    selectedItemGrade = items.first;
    update();
  }

  /// Sets the selected subject based on the given [items].
  ///
  /// If [items] is not empty, it will select the first item in [items]
  /// and set it as the [selectedItemSubject].
  ///
  /// Finally, it will call [update] to notify the UI of the changes.
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
