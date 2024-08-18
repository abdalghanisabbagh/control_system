import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Models/exam_mission/upload_pdf_res_models.dart';
import '../../../Data/Models/exam_room/exam_rooms_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

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

  Future<void> downloadFilePdf(String url, String attendanceName) async {
    try {
      await FileSaver.instance.saveFile(
        name: attendanceName,
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

  Future<void> generatePdfAttendance({required int roomId}) async {
    isLoadingGeneratePdf = true;
    update();

    final response = await ResponseHandler<UploadPdfResModel>().getResponse(
      path: '${GeneratePdfLinks.generatePdfAttendence}?roomid=$roomId',
      converter: UploadPdfResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      isLoadingGeneratePdf = false;
      update();
    }, (result) {
      if (result.url != null) {
        downloadFilePdf(result.url!, 'attendance report');
        isLoadingGeneratePdf = false;
        update();
      }
    });
  }

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

  @override
  void onInit() {
    geteducationyear();
    super.onInit();
  }

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

  void setSelectedItemEducationYear(List<ValueItem> items) {
    if (items.isNotEmpty) {
      selectedItemEducationYear = items.first;
      int educationYearId = selectedItemEducationYear!.value;
      getControlMissionByEducationYearAndBySchool(educationYearId);
    } else {
      selectedItemEducationYear = null;
      //gradesList.clear();
      //examMissionsList.clear();
      // filteredGradesList.clear();
      selectedItemControlMission = null;
      selectedItemExamRoom = null;
    }

    update();
  }

  void setSelectedItemExamRoom(List<ValueItem> items) async {
    if (items.isNotEmpty) {
      selectedItemExamRoom = items.first;

      update();
    }
  }
}
