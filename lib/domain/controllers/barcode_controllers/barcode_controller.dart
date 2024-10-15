import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Data/Models/barcodes/barcode_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class BarcodeController extends GetxController {
  final TextEditingController barcodeController = TextEditingController();
  BarcodeResModel? barcodeResModel;
  bool isEdit = false;
  bool isLoading = false;
  final TextEditingController studentDegreeController = TextEditingController();

  @override

  /// Releases the resources used by the [TextEditingController]s.
  ///
  /// This method is invoked when the [GetxController] is removed from the
  /// widget tree.
  ///
  /// It is important to call [dispose] to prevent memory leaks.
  ///
  /// This method is automatically called when the [GetxController] is
  /// removed from the widget tree.
  void dispose() {
    barcodeController.dispose();
    studentDegreeController.dispose();
    super.dispose();
  }

  /// Gets student data from the barcode.
  ///
  /// This function sends a GET request to the server with the barcode
  /// and updates the [barcodeResModel] with the result.
  ///
  /// If the request is successful, it updates the UI with the student's
  /// data. If the request fails, it shows an error dialog with the
  /// error message.
  ///
  /// This function is called when the user clicks the "Search" button.
  ///
  Future<void> getDataFromBarcode() async {
    isLoading = true;
    update();

    ResponseHandler<BarcodeResModel> responseHandler =
        ResponseHandler<BarcodeResModel>();

    Either<Failure, BarcodeResModel> response =
        await responseHandler.getResponse(
      path:
          '${StudentsLinks.studentBarcodes}/barcode/${barcodeController.text}',
      converter: BarcodeResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        isLoading = false;
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        isLoading = false;
        barcodeResModel = r;
      },
    );

    update();
  }

  /// Sets the degree of the student based on the barcode and the given degree.
  ///
  /// This function sends a PATCH request to the server with the barcode
  /// and the degree and updates the [barcodeResModel] with the result.
  ///
  /// If the request is successful, it updates the UI by clearing the
  /// [barcodeController] and [studentDegreeController] and returns true.
  ///
  /// If the request fails, it returns false.
  ///
  /// This function is called when the user clicks the "Set Degree" button.
  Future<bool> setStudentDegree() async {
    isLoading = true;
    bool setDegreeSuccess = false;
    update();

    ResponseHandler<BarcodeResModel> responseHandler =
        ResponseHandler<BarcodeResModel>();
    Either<Failure, BarcodeResModel> response =
        await responseHandler.getResponse(
      path: '${StudentsLinks.studentBarcodes}/${barcodeResModel?.iD}',
      converter: BarcodeResModel.fromJson,
      body: {
        'ID': barcodeResModel?.iD,
        'StudentDegree': studentDegreeController.text,
      },
      type: ReqTypeEnum.PATCH,
    );
    response.fold(
      (l) {
        setDegreeSuccess = false;
      },
      (r) {
        barcodeResModel = null;
        setDegreeSuccess = true;
      },
    );
    barcodeController.clear();
    studentDegreeController.clear();
    isLoading = false;
    update();

    return setDegreeSuccess;
  }
}
