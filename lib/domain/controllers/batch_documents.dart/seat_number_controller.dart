import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:universal_html/html.dart' as html;

import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/dio_factory.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class SeatNumberController extends GetxController {
  List<ControlMissionResModel> controlMissionList = [];
  ControlMissionResModel? controlMissionObject;
  List<GradeResModel> filteredGradesList = [];
  List<GradeResModel> gradesList = [];
  bool isLoading = false;
  bool isLoadingGeneratePdf = false;
  bool isLoadingGetControlMission = false;
  bool isLoadingGetEducationYear = false;
  bool isLoadingGetExamMission = false;
  bool isLoadingGrades = false;
  List<ValueItem> optionsControlMission = [];
  List<ValueItem> optionsEducationYear = [];
  List<ValueItem> optionsGrades = [];
  final int schoolId = Hive.box('School').get('Id');
  ValueItem? selectedItemControlMission;
  ValueItem? selectedItemEducationYear;
  ValueItem? selectedItemGrade;

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

  Future<void> generatePdfSeatNumber(
      {required String controlMissionName,
      required int controlMissionId,
      required int gradeId}) async {
    isLoadingGeneratePdf = true;
    update([gradeId]);

    var dio = DioFactory().getDio();

    try {
      var response = await dio.get<List<int>>(
        '${GeneratePdfLinks.generatePdfSeat}/$controlMissionId?gradeid=$gradeId',
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      isLoadingGeneratePdf = false;
      update([gradeId]);
      if (response.statusCode == 200) {
        final bytes = Uint8List.fromList(response.data!);
        final blob = html.Blob([bytes]);
        final blobUrl = html.Url.createObjectUrlFromBlob(blob);

        // Create an anchor element and trigger the download
        html.AnchorElement(href: blobUrl)
          ..setAttribute('download', 'attendance.pdf')
          ..click();

        // Revoke the object URL after download
        html.Url.revokeObjectUrl(blobUrl);
      }
    } catch (e) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "$e",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }

    isLoadingGeneratePdf = false;
    update([gradeId]);
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

  Future<void> getGradesByControlMission(int controlMissionId) async {
    isLoadingGrades = true;
    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.getGradesByControlMission}/$controlMissionId",
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
      isLoadingGrades = false;
      update();
    });
    isLoadingGrades = false;
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
  void onInit() {
    getEducationYear();
    super.onInit();
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
        getGradesByControlMission(selectedItemControlMission!.value),
      ]);
      isLoading = false;
      update();

      updateFilteredList(null);
    } else {
      selectedItemControlMission = null;
      gradesList.clear();
      filteredGradesList.clear();
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
      gradesList.clear();
      //examMissionsList.clear();
      filteredGradesList.clear();
      selectedItemControlMission = null;
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

  Future<void> updateFilteredList(ValueItem? selectedItemGrade) async {
    if (selectedItemGrade == null) {
      filteredGradesList = gradesList;
    } else {
      filteredGradesList = gradesList.where((grade) {
        bool matchesGrade = grade.iD == selectedItemGrade.value;

        return matchesGrade;
      }).toList();
    }
    update();
  }
}
