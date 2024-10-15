import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:universal_html/html.dart' as html;

import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/dio_factory.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class AttendanceController extends GetxController {
  bool isLoadingGeneratePdf = false;
  bool isLoadingGetControlMission = false;
  bool isLoadingGetEducationYear = false;
  bool isLoadingGetExamRoom = false;
  List<ValueItem> optionsControlMission = [];
  List<ValueItem> optionsEducationYear = [];
  List<ValueItem> optionsExamRoom = [];
  final int schoolId = Hive.box('School').get('Id');
  ValueItem? selectedItemControlMission;
  ValueItem? selectedItemEducationYear;
  ValueItem? selectedItemExamRoom;

  /// Downloads a PDF file for the attendance in the room with the given room id
  ///
  /// The file is downloaded with the name 'attendance.pdf'.
  ///
  /// If the file is not downloaded successfully, an error is shown in a dialog.
  ///
  /// [roomId] The id of the room whose attendance is being downloaded.
  Future<void> generatePdfAttendance({required int roomId}) async {
    isLoadingGeneratePdf = true;
    update();

    var dio = DioFactory().getDio();

    var response = await dio.get<List<int>>(
      '${GeneratePdfLinks.generatePdfAttendance}?roomid=$roomId',
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    try {
      if (response.statusCode == 200) {
        final bytes = Uint8List.fromList(response.data!);
        final blob = html.Blob([bytes]);
        final blobUrl = html.Url.createObjectUrlFromBlob(blob);

        html.AnchorElement(href: blobUrl)
          ..setAttribute('download', 'attendance.pdf')
          ..click();

        html.Url.revokeObjectUrl(blobUrl);
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "$e",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }
    isLoadingGeneratePdf = false;
    update();
  }

  /// Gets all the exam rooms by control mission id
  ///
  /// Updates the isLoadingGetExamRoom variable to true at the start of the
  /// function and to false at the end of it.
  ///
  /// If the response is successful, it updates the optionsExamRoom list with
  /// the exam rooms returned by the server.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// [controlMissionId] The id of the control mission whose exam rooms are
  /// being requested.
  Future<void> getAllExamMissionsByControlMission(int controlMissionId) async {
    isLoadingGetExamRoom = true;

    update();
    ResponseHandler<ExamRoomsResModel> responseHandler = ResponseHandler();
    Either<Failure, ExamRoomsResModel> response =
        await responseHandler.getResponse(
      path: "${ExamRoomLinks.examRoomsControlMission}/$controlMissionId",
      converter: ExamRoomsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLoadingGetExamRoom = false;

        update();
      },
      (r) {
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.id))
            .toList();
        optionsExamRoom = items;
        isLoadingGetExamRoom = false;

        update();
      },
    );
  }

  /// Gets all the control missions for the selected education year and school.
  ///
  /// Shows an error dialog if the response is a failure.
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
  /// Shows an error dialog if the response is a failure.
  ///
  /// Updates the [optionsEducationYear] list with the education years.
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

  @override

  /// Called when the widget is initialized.
  ///
  /// It calls the [getEducationYear] function and then calls the super class
  /// [onInit] function.
  void onInit() {
    getEducationYear();
    super.onInit();
  }

  /// Sets the [selectedItemControlMission] with the first item of [items] if
  /// [items] is not empty.
  ///
  /// If [items] is not empty, it calls the [getAllExamMissionsByControlMission]
  /// function with the value of [selectedItemControlMission] as argument.
  ///
  /// If [items] is empty, it sets [selectedItemControlMission] and
  /// [selectedItemExamRoom] to null.
  ///
  /// Finally, it calls the [update] function to notify the widgets that depend
  /// on this controller to rebuild.
  void setSelectedItemControlMission(List<ValueItem> items) async {
    if (items.isNotEmpty) {
      selectedItemControlMission = items.first;
      getAllExamMissionsByControlMission(selectedItemControlMission!.value);

      update();
    } else {
      selectedItemControlMission = null;
      selectedItemExamRoom = null;
      update();
    }
  }

  /// Sets the [selectedItemEducationYear] with the first item of [items] if
  /// [items] is not empty.
  ///
  /// If [items] is not empty, it calls the [getControlMissionByEducationYearAndBySchool]
  /// function with the value of [selectedItemEducationYear] as argument.
  ///
  /// If [items] is empty, it sets [selectedItemEducationYear],
  /// [selectedItemControlMission] and [selectedItemExamRoom] to null.
  ///
  /// Finally, it calls the [update] function to notify the widgets that depend
  /// on this controller to rebuild.
  void setSelectedItemEducationYear(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedItemEducationYear = items.first;
      int educationYearId = selectedItemEducationYear!.value;
      getControlMissionByEducationYearAndBySchool(educationYearId);
    } else {
      selectedItemEducationYear = null;
      selectedItemControlMission = null;
      selectedItemExamRoom = null;
    }

    update();
  }

  /// Sets the [selectedItemExamRoom] with the first item of [items] if
  /// [items] is not empty.
  ///
  /// If [items] is not empty, it updates the UI by calling the [update] function.
  ///
  /// If [items] is empty, it does nothing.
  ///
  void setSelectedItemExamRoom(List<ValueItem> items) async {
    if (items.isNotEmpty) {
      selectedItemExamRoom = items.first;

      update();
    }
  }
}
