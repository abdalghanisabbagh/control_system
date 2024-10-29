import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../Data/Models/exam_mission/exam_missions_res_model.dart';
import '../../../Data/Models/exam_mission/preview_exam_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/subject/subjects_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/dio_factory.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class CoversSheetsController extends GetxController {
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  ControlMissionResModel? controlMissionObject;
  List<ExamMissionResModel> examMissionsList = <ExamMissionResModel>[];
  List<ExamMissionResModel> filteredExamMissionsList = [];
  bool isLoading = false;
  bool isLoadingAddExamMission = false;
  bool isLoadingGeneratePdf = false;
  bool isLoadingGetControlMission = false;
  bool isLoadingGetEducationYear = false;
  bool isLoadingGetExamMission = false;
  bool isLoadingGetSubject = false;
  bool isLoadingGrades = false;
  List<ValueItem> optionsControlMission = <ValueItem>[];
  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ValueItem> optionsGrades = <ValueItem>[];
  List<ValueItem> optionsSubjects = <ValueItem>[];
  final int schoolId = Hive.box('School').get('Id');
  final String? schoolTypeName = Hive.box('School').get('SchoolTypeName');
  ValueItem? selectedItemControlMission;
  ValueItem? selectedItemEducationYear;
  ValueItem? selectedItemGrade;
  ValueItem? selectedSubject;

  /// This function adds a new exam mission to the database.
  ///
  /// It takes the following parameters:
  ///
  /// - [subjectId]: The ID of the subject.
  /// - [controlMissionId]: The ID of the control mission.
  /// - [gradeId]: The ID of the grade.
  /// - [educationYearId]: The ID of the education year.
  /// - [year]: The year of the exam mission.
  /// - [month]: The month of the exam mission.
  /// - [finalDegree]: The final degree of the exam mission.
  /// - [duration]: The duration of the exam mission.
  /// - [period]: The period of the exam mission.
  /// - [createOnly]: Whether to create the exam mission only or also add it to the selected control mission.
  ///
  /// It returns a boolean indicating whether the exam mission was added successfully.
  Future<bool> addNewExamMission({
    required int subjectId,
    required int controlMissionId,
    required int gradeId,
    required int educationYearId,
    required String year,
    required String month,
    required String finalDegree,
    required int duration,
    required bool? period,
    required bool? createOnly,
  }) async {
    isLoadingAddExamMission = true;
    update();
    bool addExamMissionHasBeenAdded = false;
    ResponseHandler<ExamMissionResModel> responseHandler = ResponseHandler();

    ExamMissionResModel examMissionResModel = ExamMissionResModel(
        subjectsID: subjectId,
        controlMissionID: controlMissionId,
        gradesID: gradeId,
        educationYearID: educationYearId,
        year: year,
        month: month,
        finalDegree: finalDegree,
        createOnly: createOnly,
        period: period,
        duration: duration);

    var response = await responseHandler.getResponse(
        path: ExamMissionLinks.examMission,
        converter: ExamMissionResModel.fromJson,
        type: ReqTypeEnum.POST,
        body: examMissionResModel.toJson());

    response.fold(
      (failure) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: "${failure.code} ::${failure.message}",
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        addExamMissionHasBeenAdded = false;
      },
      (result) {
        if (selectedItemControlMission != null) {
          getAllExamMissionsByControlMission(selectedItemControlMission!.value);
        }

        addExamMissionHasBeenAdded = true;
      },
    );
    isLoadingAddExamMission = false;

    update();
    return addExamMissionHasBeenAdded;
  }

  /// This function deletes an exam mission by its ID.
  ///
  /// It takes the following parameters:
  ///
  /// - [id]: The ID of the exam mission to be deleted.
  ///
  /// It returns a boolean indicating whether the exam mission was deleted successfully.
  ///
  Future<bool> deleteExamMission({
    required int id,
  }) async {
    bool examMissionHasBeenDeleted = false;

    ResponseHandler<ExamMissionResModel> responseHandler = ResponseHandler();

    Either<Failure, ExamMissionResModel> response =
        await responseHandler.getResponse(
      path: '${ExamMissionLinks.examMission}/$id',
      converter: ExamMissionResModel.fromJson,
      type: ReqTypeEnum.DELETE,
      body: {},
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

  /// This function generates an AM cover sheet for the given exam mission ID.
  ///
  /// It takes the following parameters:
  ///
  /// - [controlMissionName]: The name of the control mission.
  /// - [examMissionId]: The ID of the exam mission.
  ///
  /// It does not return any value.
  Future<void> generateAmCoverSheet({
    required String controlMissionName,
    required int examMissionId,
  }) async {
    await generateCoverSheet(
      controlMissionName: controlMissionName,
      examMissionId: examMissionId,
      path: '${GeneratePdfLinks.generatePdfAmCover}/$examMissionId',
    );
  }

  /// This function generates a BR cover sheet for the given exam mission ID.
  ///
  /// It takes the following parameters:
  ///
  /// - [controlMissionName]: The name of the control mission.
  /// - [examMissionId]: The ID of the exam mission.
  ///
  /// It does not return any value.
  Future<void> generateBrCoverSheet({
    required String controlMissionName,
    required int examMissionId,
  }) async {
    await generateCoverSheet(
      controlMissionName: controlMissionName,
      examMissionId: examMissionId,
      path: '${GeneratePdfLinks.generatePdfBrCover}/$examMissionId',
    );
  }

  /// Generates a cover sheet for the given exam mission ID.
  ///
  /// It takes the following parameters:
  ///
  /// - [controlMissionName]: The name of the control mission.
  /// - [examMissionId]: The ID of the exam mission.
  /// - [path]: The path to the API endpoint that generates the cover sheet.
  ///
  /// It does not return any value.
  Future<void> generateCoverSheet({
    required String controlMissionName,
    required int examMissionId,
    required String path,
  }) async {
    isLoadingGeneratePdf = true;
    update([examMissionId]);

    var dio = DioFactory().getDio();
    try {
      var response = await dio.get(
        path,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      if (response.statusCode == 200) {
        final bytes = Uint8List.fromList(response.data!);
        final blob = html.Blob([bytes]);
        final blobUrl = html.Url.createObjectUrlFromBlob(blob);

        // Create an anchor element and trigger the download
        html.AnchorElement(href: blobUrl)
          ..setAttribute('download', 'cover-sheet.pdf')
          ..click();

        // Revoke the object URL after download
        html.Url.revokeObjectUrl(blobUrl);
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      MyAwesomeDialogue(
              title: 'Error', desc: "$e", dialogType: DialogType.error)
          .showDialogue(Get.key.currentContext!);
    }

    isLoadingGeneratePdf = false;

    update([examMissionId]);
  }

  /// Generates a cover sheet for the given exam mission ID in IB format.
  ///
  /// It takes the following parameters:
  ///
  /// - [controlMissionName]: The name of the control mission.
  /// - [examMissionId]: The ID of the exam mission.
  ///
  /// It does not return any value.
  Future<void> generateIBCoverSheet({
    required String controlMissionName,
    required int examMissionId,
  }) async {
    await generateCoverSheet(
      controlMissionName: controlMissionName,
      examMissionId: examMissionId,
      path: '${GeneratePdfLinks.generatePdfIBCover}/$examMissionId',
    );
  }

  /// Gets all the exam missions for the given control mission ID.
  ///
  /// It takes the following parameter:
  ///
  /// - [controlMissionId]: The ID of the control mission.
  ///
  /// It does not return any value.
  Future<void> getAllExamMissionsByControlMission(int controlMissionId) async {
    isLoadingGetExamMission = true;

    update();
    ResponseHandler<ExamMissionsResModel> responseHandler = ResponseHandler();
    Either<Failure, ExamMissionsResModel> response =
        await responseHandler.getResponse(
      path: "${ExamMissionLinks.examMissionControlMission}/$controlMissionId",
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
        isLoadingGetSubject = false;
        update();
      },
      (r) {
        examMissionsList = r.data!;
        updateFilteredList(null, null);
        isLoadingGetExamMission = false;
        update();
      },
    );
  }

  /// Gets all the subjects from the API.
  ///
  /// It does not take any parameters.
  ///
  /// It sets the [isLoadingGetSubject] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is successful, it updates the [optionsSubjects] list with
  /// the subjects returned by the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  Future<void> getAllSubjects() async {
    isLoadingGetSubject = true;

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
        isLoadingGetSubject = false;
        update();
      },
      (r) {
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsSubjects = items;

        isLoadingGetSubject = false;
        update();
      },
    );
  }

  /// Gets all the control missions for the selected education year and school.
  ///
  /// It sets the [isLoadingGetControlMission] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is successful, it updates the [controlMissionList] with
  /// the control missions returned by the API and sets the [optionsControlMission]
  /// with the control missions.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// [educationYearId] The id of the education year whose control missions are
  /// being requested.
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

  /// Gets all the education years for the school.
  ///
  /// It sets the [isLoadingGetEducationYear] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is successful, it updates the [optionsEducationYear] with
  /// the education years returned by the API.
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

  /// Gets all the grades for the selected school.
  ///
  /// It sets the [isLoadingGrades] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is successful, it updates the [optionsGrades] with
  /// the grades returned by the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
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
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsGrades = items;
    });
    isLoadingGrades = false;
  }

  @override

  /// Calls [getEducationYear] when the controller is initialized.
  /// This is necessary to load the education year as soon as the
  /// controller is created.
  ///
  void onInit() {
    getEducationYear();
    super.onInit();
  }

  /// A function that makes a GET request to the server to preview an exam
  /// mission.
  ///
  /// The function takes one parameter, [examMissionId], which is the id of the
  /// exam mission to be previewed.
  ///
  /// The function returns a [Future] that resolves to an [Either] of a
  /// [Failure] or a [PreviewExamResModel].
  ///
  /// If the response is successful, the function will try to launch the url
  /// returned in the response. If the url cannot be launched, an error dialog
  /// will be shown with the error message.
  ///
  /// If the response is a failure, an error dialog will be shown with the
  /// failure message.
  Future<void> previewExamMission({
    required int examMissionId,
  }) async {
    final response = await ResponseHandler<PreviewExamResModel>().getResponse(
      path: "${ExamMissionLinks.previewExamMission}/$examMissionId",
      converter: PreviewExamResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }, (result) async {
      if (result.A != null) {
        try {
          if (await canLaunchUrl(Uri.parse(result.A!))) {
            await launchUrl(Uri.parse(result.A!), webOnlyWindowName: '_blank');
          } else {
            throw 'Could not launch ${Uri.parse(result.A!)}';
          }
        } catch (e) {
          MyAwesomeDialogue(
            title: 'Error',
            desc: "$e",
            dialogType: DialogType.error,
          ).showDialogue(Get.key.currentContext!);
        }
      }
    });
  }

  /// Sets the [selectedItemControlMission] to the first item in [items] if it
  /// is not empty. If it is empty, it sets the [selectedItemControlMission] to
  /// null and clears the [examMissionsList] and [filteredExamMissionsList].
  ///
  /// If [items] is not empty, it also updates the [controlMissionObject] to the
  /// first control mission in [controlMissionList] whose id is equal to the
  /// value of the first item in [items].
  ///
  /// It then calls [getAllSubjects], [getGradesBySchoolId] and
  /// [getAllExamMissionsByControlMission] and waits for all of them to complete
  /// before setting [isLoading] to false and calling [update].
  ///
  /// Finally, it calls [updateFilteredList] with null arguments and [update]
  /// again.
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

  /// Sets the [selectedItemEducationYear] to the first item in [items] if it
  /// is not empty. If it is empty, it sets the [selectedItemEducationYear] to
  /// null and clears the [examMissionsList] and [filteredExamMissionsList] and
  /// [selectedItemControlMission].
  ///
  /// It then calls [getControlMissionByEducationYearAndBySchool] with the value
  /// of the first item in [items].
  ///
  /// Finally, it calls [update].
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

  /// Sets the [selectedItemGrade] to the first item in [items] if it is not
  /// empty. If it is empty, it sets the [selectedItemGrade] to null and calls
  /// [updateFilteredList] with null as arguments.
  ///
  /// Finally, it calls [update].
  void setSelectedItemGrade(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedItemGrade = items.first;
      updateFilteredList(selectedItemGrade, selectedSubject);
    } else {
      selectedItemGrade = null;
      updateFilteredList(null, selectedSubject);
    }
    update();
  }

  /// Sets the [selectedSubject] to the first item in [items] if it is not
  /// empty. If it is empty, it sets the [selectedSubject] to null and calls
  /// [updateFilteredList] with null as arguments.
  ///
  /// Finally, it calls [update].
  void setSelectedItemSubject(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedSubject = items.first;
      updateFilteredList(selectedItemGrade, selectedSubject);
    } else {
      selectedSubject = null;
      updateFilteredList(selectedItemGrade, null);
    }
  }

  /// Updates the [filteredExamMissionsList] based on the values of
  /// [selectedItemGrade] and [selectedItemSubject].
  ///
  /// If [selectedItemGrade] and [selectedItemSubject] are both null, it sets
  /// [filteredExamMissionsList] to [examMissionsList].
  ///
  /// If either [selectedItemGrade] or [selectedItemSubject] is not null, it
  /// filters [examMissionsList] and sets [filteredExamMissionsList] to the
  /// filtered list. The filtered list contains only the exam missions that
  /// match both the selected grade and the selected subject.
  ///
  /// Finally, it calls [update].
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
}
