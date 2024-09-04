import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../Data/Models/exam_mission/exam_missions_res_model.dart';
import '../../../Data/Models/exam_mission/preview_exam_res_model.dart';
import '../../../Data/Models/exam_mission/upload_pdf_res_models.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/subject/subjects_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

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
  bool isLoadingGrades = false;
  bool isLodingGetExamMission = false;
  bool isLodingGetSubject = false;
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

  Future<bool> addNewExamMission({
    required int subjectId,
    required int controlMissionId,
    required int gradeId,
    required int educationyearId,
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
        educationYearID: educationyearId,
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
      (fauilr) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: "${fauilr.code} ::${fauilr.message}",
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

  Future<void> downloadFilePdf(String url, String controlMissionName) async {
    try {
      await FileSaver.instance.saveFile(
        name: 'cover-sheet-$controlMissionName',
        link: LinkDetails(link: url),
        mimeType: MimeType.pdf,
        ext: 'pdf',
      );
    } catch (e) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "$e",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }
  }

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

  Future<void> generateCoverSheet({
    required String controlMissionName,
    required int examMissionId,
    required String path,
  }) async {
    isLoadingGeneratePdf = true;
    update([examMissionId]);

    final response = await ResponseHandler<UploadPdfResModel>().getResponse(
      path: path,
      converter: UploadPdfResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      isLoadingGeneratePdf = false;
      update([examMissionId]);
    }, (result) {
      if (result.url != null) {
        downloadFilePdf(result.url!, controlMissionName);
        isLoadingGeneratePdf = false;
        update([examMissionId]);
      }
    });
  }

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

  Future<void> getAllExamMissionsByControlMission(int controlMissionId) async {
    isLodingGetExamMission = true;

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
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsSubjects = items;

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
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsGrades = items;
    });
    isLoadingGrades = false;
  }

  @override
  void onInit() {
    geteducationyear();
    super.onInit();
  }

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
