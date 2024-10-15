import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../Data/Models/exam_mission/upload_pdf_res_models.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import '../controllers.dart';

class EditCoverSheetController extends GetxController {
  bool isImportedFile = false;

  bool isLoadingUpdateExamMission = false;
  bool isLoadingUploadPdf = false;
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
  String? pdfName;

  String? pdfUrl;
  DateTime? selectedEndTime;
  ValueItem? selectedIExamDuration;
  DateTime? selectedStartTime;

  /// A function that allows the user to select a PDF file and returns the selected file as a [Uint8List] and its name as a [String].
  ///
  /// The function will show an error dialog if the user does not select a file.
  ///
  /// The function will also update the UI to show that a file has been imported.
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

  /// A function that updates an exam mission with the given parameters and returns a boolean indicating whether the update was successful.
  ///
  /// The function takes the following parameters:
  ///
  /// - [id]: The ID of the exam mission to update.
  /// - [startTime]: The start time of the exam mission.
  /// - [endTime]: The end time of the exam mission.
  /// - [duration]: The duration of the exam mission.
  /// - [pdfUrl]: The URL of the PDF file for the exam mission.
  /// - [period]: The period of the exam mission.
  ///
  /// The function will return a boolean indicating whether the update was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the list of exam missions in the [CoversSheetsController] and reset the UI to show that no file has been imported.
  Future<bool> updateExamMission({
    required int id,
    required String? startTime,
    required String? endTime,
    required int? duration,
    required String? pdfUrl,
    required bool? period,
  }) async {
    isLoadingUpdateExamMission = true;

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
        path: '${ExamMissionLinks.examMission}/$id',
        converter: ExamMissionResModel.fromJson,
        type: ReqTypeEnum.PATCH,
        body: examMissionResModel.toJson());

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
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
    isLoadingUpdateExamMission = false;

    update();
    return updateExamMission;
  }

  /// Updates an exam mission by office.
  ///
  /// This function updates an exam mission by office by sending a PATCH request to the server.
  /// It takes the following parameters:
  ///
  /// - [id]: The ID of the exam mission to update.
  /// - [duration]: The new duration of the exam mission.
  /// - [period]: The new period of the exam mission.
  /// - [year]: The new year of the exam mission.
  /// - [month]: The new month of the exam mission.
  ///
  /// The function will return a boolean indicating whether the exam mission was updated successfully.
  ///
  /// The function will also show an error dialog with the failure message if the request fails.
  Future<bool> updateExamMissionByOffice({
    required int id,
    required int? duration,
    required bool? period,
    required String? year,
    required String? month,
  }) async {
    isLoadingUpdateExamMission = true;

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
        path: '${ExamMissionLinks.examMission}/$id',
        converter: ExamMissionResModel.fromJson,
        type: ReqTypeEnum.PATCH,
        body: examMissionResModel.toJson());

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      updateExamMission = false;
    }, (result) {
      Get.find<CoversSheetsController>()
          .getAllExamMissionsByControlMission(result.controlMissionID!);
      updateExamMission = true;
    });
    isLoadingUpdateExamMission = false;

    update();
    return updateExamMission;
  }

  /// A function that uploads a PDF file to the server and sets the [pdfUrl] with the returned URL.
  ///
  /// The function will return a boolean indicating whether the upload was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the [pdfUrl] and reset the UI to show that no file has been imported.
  Future<bool> uploadPdfInExamMission() async {
    bool uploadPdfFile = false;
    ResponseHandler<PdfExamMissionResModel> responseHandler = ResponseHandler();

    (Uint8List?, String?) pdfData = await pickPdfFile();
    isLoadingUploadPdf = true;
    update();

    var response = await responseHandler.getResponse(
      path: ExamMissionLinks.examMissionUpload,
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

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      uploadPdfFile = false;
    }, (result) {
      pdfUrl = result.data!;
      uploadPdfFile = true;
    });
    isLoadingUploadPdf = false;
    update();
    return uploadPdfFile;
  }
}
