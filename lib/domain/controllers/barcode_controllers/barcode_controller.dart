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
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class BarcodeController extends GetxController {
  final TextEditingController barcodeController = TextEditingController();
  BarcodeResModel? barcodeResModel;
  bool isEdit = false;

  bool isLoading = false;

  final TextEditingController studentDegreeController = TextEditingController();

  @override
  void dispose() {
    barcodeController.dispose();
    studentDegreeController.dispose();
    super.dispose();
  }

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

  Future<bool> setStudentDegree() async {
    barcodeController.clear();
    studentDegreeController.clear();
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
    isLoading = false;
    update();

    return setDegreeSuccess;
  }
}
