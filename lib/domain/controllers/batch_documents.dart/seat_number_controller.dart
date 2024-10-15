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

  /// Downloads a file from the given url and saves it with the given name.
  ///
  /// The file will be saved with a .pdf extension.
  ///
  /// If an error occurs, a dialogue will be shown with the error message.
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

  /// Generates a PDF file for the given control mission and grade and downloads it.
  ///
  /// The file will be saved with a .pdf extension and the name 'seat-number.pdf'.
  ///
  /// If an error occurs, a dialogue will be shown with the error message.
  ///
  /// The UI will be updated to show a loading indicator while the request is being processed.
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
          ..setAttribute('download', 'seat-number.pdf')
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

  /// Gets all control missions for the given education year and school ID.
  //
  /// It takes the education year ID as a parameter.
  //
  /// The function will return a list of [ControlMissionResModel] objects
  /// and update the [optionsControlMission] with the control missions returned by the API.
  //
  /// If the response is a failure, the function will show an error dialog with the failure
  /// message.
  //
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  //
  /// [isLoadingGetControlMission] will be set to true while the request is being processed and
  /// set to false when the request is finished.
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
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        optionsControlMission = items;
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
  ///
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

  /// Gets all grades for the given control mission ID from the API and sets the
  /// [gradesList] with the grades returned by the API.
  ///
  /// It takes the control mission ID as a parameter.
  ///
  /// The function will return a list of [GradesResModel] objects
  /// and update the [gradesList] with the grades returned by the API.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure
  /// message.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// [isLoadingGrades] will be set to true while the request is being processed and
  /// set to false when the request is finished.
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

  /// Gets all the grades from the API and sets the
  /// [optionsGrades] with the grades returned by the API.
  ///
  /// It sets the [isLoadingGrades] variable to true and then to false
  /// depending on the response of the API.
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

  ///
  /// This is the onInit function of the SeatNumberController class.
  ///
  /// It calls the [getEducationYear] function and then calls the [onInit]
  /// function of the super class.
  ///
  void onInit() {
    getEducationYear();
    super.onInit();
  }

  ///
  /// Sets the selected item for the control mission dropdown.
  ///
  /// It takes a list of [ValueItem] as a parameter and checks if the list is not empty.
  /// If the list is not empty, it sets the [selectedItemControlMission] to the first item in the list.
  /// It then gets the control mission object from the list of control missions and sets it to the
  /// [controlMissionObject].
  ///
  /// It then sets the [isLoading] variable to true and updates the UI.
  /// It then waits for the [getGradesBySchoolId] and [getGradesByControlMission] functions to complete.
  /// After they complete, it sets the [isLoading] variable to false and updates the UI.
  /// It then calls the [updateFilteredList] function and passes the current value of [selectedItemControlMission]
  /// as a parameter.
  /// If the list is empty, it sets the [selectedItemControlMission] to null and clears the [gradesList] and
  /// [filteredGradesList].
  ///
  /// Finally, it updates the UI.
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

  /// It takes a list of [ValueItem] as a parameter and checks if the list is not empty.
  /// If the list is not empty, it sets the [selectedItemEducationYear] to the first item in the list.
  /// It then gets the education year id from the [selectedItemEducationYear] and calls the
  /// [getControlMissionByEducationYearAndBySchool] function with the education year id as a parameter.
  /// If the list is empty, it sets the [selectedItemEducationYear] to null, clears the [gradesList],
  /// and clears the [filteredGradesList].
  /// It also sets the [selectedItemControlMission] to null.
  /// Finally, it updates the UI.
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

  /// It takes a list of [ValueItem] as a parameter and checks if the list is not empty.
  /// If the list is not empty, it sets the [selectedItemGrade] to the first item in the list.
  /// It then calls the [updateFilteredList] function with the [selectedItemGrade] as a parameter.
  /// If the list is empty, it sets the [selectedItemGrade] to null and calls the
  /// [updateFilteredList] function with null as a parameter.
  /// Finally, it updates the UI.
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

  /// This function updates the [filteredGradesList] based on the selected grade.
  ///
  /// If [selectedItemGrade] is null, it sets the [filteredGradesList] to the
  /// [gradesList].
  ///
  /// If [selectedItemGrade] is not null, it filters the [gradesList] and sets the
  /// [filteredGradesList] to the filtered list. The filtered list contains only
  /// the grades that match the selected grade.
  ///
  /// Finally, it calls the [update] function to update the UI.
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
