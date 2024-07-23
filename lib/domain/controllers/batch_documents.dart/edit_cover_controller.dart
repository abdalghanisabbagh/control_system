import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/controllers.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../Data/Models/exam_mission/upload_pdf_res_models.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class EditCoverSheetController extends GetxController {
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;

  bool isLodingUpdateExamMission = false;
  bool isLodingUploadPdf = false;
  bool isImportedFile = false;

  ValueItem? selectedIExamDuration;
  String? pdfUrl;
  String? pdfName;

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

  Future<(Uint8List?, String?)> pickPdfFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (pickedFile != null) {
      Uint8List? fileBytes = pickedFile.files.single.bytes;
      isImportedFile = true;
      update();

      if (fileBytes != null) {
        pdfName = pickedFile.files.single.name;

        return (fileBytes, pickedFile.files.single.name);
      }
    } else {
      MyAwesomeDialogue(
        title: 'Error',
        desc: 'No file selected',
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
    }

    return (null, null);
  }

  Future<bool> uplodPdfInExamMission() async {
    bool uploadPdfFile = false;
    ResponseHandler<PdfExamMissionResModel> responseHandler = ResponseHandler();

    (Uint8List?, String?) pdfData = await pickPdfFile();
    isLodingUploadPdf = true;
    update();

    var response = await responseHandler.getResponse(
      path: ExamLinks.examMissionUpload,
      converter: PdfExamMissionResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: FormData.fromMap(
        {
          'file': pdfData.$1 == null
              ? null
              : MultipartFile.fromBytes(pdfData.$1!, filename: pdfData.$2),
        },
      ),
    );

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      uploadPdfFile = false;
    }, (result) {
      pdfUrl = result.data!;
      uploadPdfFile = true;
    });
    isLodingUploadPdf = false;
    update();
    return uploadPdfFile;
  }

  Future<bool> updateExamMission({
    required int id,
    required String? startTime,
    required String? endTime,
    required int? duration,
    required String? pdfUrl,
    required bool? period,
  }) async {
    isLodingUpdateExamMission = true;

    update();
    bool updateExamMission = false;
    ResponseHandler<ExamMissionResModel> responseHandler = ResponseHandler();

    ExamMissionResModel examMissionResModel = ExamMissionResModel(
      startTime: startTime,
      duration: duration,
      pdf: pdfUrl,
      period: period,
      endTime: endTime,
    );

    var response = await responseHandler.getResponse(
        path: '${ExamLinks.examMission}/$id',
        converter: ExamMissionResModel.fromJson,
        type: ReqTypeEnum.PATCH,
        body: examMissionResModel.toJson());

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      updateExamMission = false;
    }, (result) {
      Get.find<CoversSheetsController>()
          .getAllExamMissionsByControlMission(result.controlMissionID!);
      updateExamMission = true;

      isImportedFile = false;
      update();
    });
    isLodingUpdateExamMission = false;

    update();
    return updateExamMission;
  }

  Future<bool> updateExamMissionByOffice({
    required int id,
    required int? duration,
    required bool? period,
    required String? year,
    required String? month,
  }) async {
    isLodingUpdateExamMission = true;

    update();
    bool updateExamMission = false;
    ResponseHandler<ExamMissionResModel> responseHandler = ResponseHandler();

    ExamMissionResModel examMissionResModel = ExamMissionResModel(
      duration: duration,
      pdf: pdfUrl,
      period: period,
      year: year,
      month: month,
    );

    var response = await responseHandler.getResponse(
        path: '${ExamLinks.examMission}/$id',
        converter: ExamMissionResModel.fromJson,
        type: ReqTypeEnum.PATCH,
        body: examMissionResModel.toJson());

    response.fold((fauilr) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${fauilr.code} ::${fauilr.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      updateExamMission = false;
    }, (result) {
      Get.find<CoversSheetsController>()
          .getAllExamMissionsByControlMission(result.controlMissionID!);
      updateExamMission = true;
    });
    isLodingUpdateExamMission = false;

    update();
    return updateExamMission;
  }
}
