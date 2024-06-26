import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class CreateCoversSheetsController extends GetxController {
  String atoken = '';
  TextEditingController dateController = TextEditingController();
  List<int> examDurations = [
    15,
    25,
    45,
    60,
    70,
    75,
    85,
    90,
    100,
    105,
    120,
    130,
    150
  ];

  TextEditingController examFinalDegreeController = TextEditingController();
  TextEditingController examTimeController = TextEditingController();
  bool is2Version = false;
  RxBool isLoading = false.obs;
  bool isLoadingGetEducationYear = false;
  bool isNight = false;
  List<ValueItem> options = <ValueItem>[];
  DateTime selectedDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    geteducationyear();
  }

  Future<bool> geteducationyear() async {
    isLoadingGetEducationYear = true;
    update();
    bool getEducationYear = false;
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
        getEducationYear = false;
      },
      (r) {
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.id))
            .toList();
        options = items;
      },
    );
    getEducationYear = true;

    isLoadingGetEducationYear = false;
    update();
    return getEducationYear;
  }
}
