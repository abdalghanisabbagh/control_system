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
//   String atoken = '';
//   SchoolResponse? selectedSchool;
//   EducationResponse? selectedEduction;
//   StudentExamBRCResponseModel? stdExBRCResMod;
//   bool buildwidget = false;
//   bool edit = false;
//   TextEditingController degreeTextController = TextEditingController();

//   final FocusNode brCodeFoucs = FocusNode();

//   FocusNode degreeController = FocusNode();
  bool isLoading = false;

  final TextEditingController studentDegreeController = TextEditingController();

  @override
  void dispose() {
    barcodeController.dispose();
    studentDegreeController.dispose();
    super.dispose();
  }

  //   @override
//   void onReady() {
//     super.onReady();
//     brCodeFoucs.requestFocus();
//     atoken = Hive.box('Token').get('token');
//     selectedSchool = SchoolResponse(
//         id: Hive.box('School').get("Id"), name: Hive.box('School').get("Name"));
//     selectedEduction = EducationResponse(
//       id: Hive.box('Education').get("Id"),
//       name: Hive.box('Education').get("Name"),
//     );

//     GradesControllers gradesControllers = Get.find();
//     ClassesControllers classesControllers = Get.find();
//   }

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
        barcodeController.clear();
        studentDegreeController.clear();
        setDegreeSuccess = true;
      },
    );
    isLoading = false;
    update();

    return setDegreeSuccess;
  }

//   editStudentGrades() {
//     edit = true;
//     stdExBRCResMod!.studentDegree = null;
//     update();
//   }

//   updateSubjectGrade(String gradeData) async {
//     await StudentExamBarcodeService.updateDegree(
//         token: atoken, barCode: stdExBRCResMod!.barCode, degree: gradeData);

//     buildwidget = false;
//     barcodeController.clear();
//     brCodeFoucs.requestFocus();
//     update();
//   }
// }

// class SubjectDegrees {
//   String title;
//   String degree;
//   SubjectDegrees({
//     required this.title,
//     required this.degree,
//   });
}
