import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/system_logger/system_loggers_res_model.dart';
import 'package:control_system/Data/Models/user/users_res/user_res_model.dart';
import 'package:control_system/Data/Network/tools/dio_factory.dart';
import 'package:control_system/Data/Network/tools/failure_model.dart';
import 'package:control_system/app/extensions/pluto_row_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:universal_html/html.dart' as html;

import '../../Data/Models/system_logger/system_logger_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class SystemLoggerController extends GetxController {
  bool isLoadingGetSystemLogs = false;
  bool isLoadingGetUserInfo = false;
  String? userName;
  String? fullName;

  List<SystemLoggerResModel> systemLogsList = [];
  List<PlutoRow> systemLogsRows = <PlutoRow>[];

  /// Downloads a Excel file for the system logs.
  ///
  /// The file is downloaded with the name 'logs.xlsx'.
  ///
  /// If the file is not downloaded successfully, an error is shown in a dialog.
  Future<void> exportExcel() async {
    var dio = DioFactory().getDio();
    try {
      var response = await dio.get(
        SystemLogLinks.systemLogExportExcel,
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
          ..setAttribute('download', 'logs.xlsx')
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
  }

  /// Downloads a text file for the system logs.
  ///
  /// The file is downloaded with the name 'logs.txt'.
  ///
  /// If the file is not downloaded successfully, an error is shown in a dialog.
  Future<void> exportText() async {
    var dio = DioFactory().getDio();
    try {
      var response = await dio.get(
        SystemLogLinks.systemLogExportText,
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
          ..setAttribute('download', 'logs.txt')
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
  }

  /// A function that gets the system logs from the server and returns a boolean indicating whether the request was successful.
  ///
  /// The function will set [isLoadingGetSystemLogs] to true and then to false depending on the response of the server.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update [systemLogsList] and [systemLogsRows] with the system logs returned by the server.
  ///
  /// The function will then call [update] to update the UI.
  Future<bool> getSystemLogs() async {
    isLoadingGetSystemLogs = true;
    update();
    ResponseHandler<SystemLoggersResModel> responseHandler = ResponseHandler();
    Either<Failure, SystemLoggersResModel> response =
        await responseHandler.getResponse(
      path: SystemLogLinks.systemLog,
      converter: SystemLoggersResModel.fromJson,
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
        systemLogsList = r.data!;
        systemLogsRows = r.data!.convertSystemLogsToRows();
      },
    );
    isLoadingGetSystemLogs = false;
    update();
    return true;
  }

  /// A function that gets the user information from the server and updates the UI with the user's full name and user name.
  ///
  /// The function takes a [userId] parameter which is the ID of the user whose information is to be retrieved.
  ///
  /// The function will set [isLoadingGetUserInfo] to true and then to false depending on the response of the server.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update [userName] and [fullName] with the user's full name and user name returned by the server.
  ///
  /// The function will then call [update] to update the UI.
  Future<void> getUserInfo(
    String userId,
  ) async {
    isLoadingGetUserInfo = true;
    update();
    ResponseHandler<UserResModel> responseHandler = ResponseHandler();
    Either<Failure, UserResModel> response = await responseHandler.getResponse(
      path: '${SystemLogLinks.systemLogUser}?user-id=$userId',
      converter: UserResModel.fromJson,
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
        userName = r.userName;
        fullName = r.fullName!;
      },
    );
    isLoadingGetUserInfo = false;
    update();
  }

  @override

  /// Called when the widget is initialized. It calls [getSystemLogs] to get
  /// the system logs and then calls the parent's [onInit].
  void onInit() {
    getSystemLogs();
    super.onInit();
  }

  ///
  /// This method will clear the system log and then download the log as an Excel file.
  ///
  /// If the download fails, an error dialogue will be shown with the error message.
  ///
  Future<void> resetAndExportToText() async {
    var dio = DioFactory().getDio();
    try {
      var response = await dio.get(
        SystemLogLinks.systemLogResetAndExportToText,
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
          ..setAttribute('download', 'logs.txt')
          ..click();

        // Revoke the object URL after download
        html.Url.revokeObjectUrl(blobUrl);
        getSystemLogs();
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      MyAwesomeDialogue(
              title: 'Error', desc: "$e", dialogType: DialogType.error)
          .showDialogue(Get.key.currentContext!);
    }
  }
}
