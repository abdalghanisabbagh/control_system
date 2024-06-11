import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/education_year/education_year_model.dart';
import 'package:control_system/Data/Models/education_year/educations_years_res_model.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Models/control_mission/control_mission_model.dart';
import '../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';

class ControlMissionController extends GetxController {
  List<EducationYearModel> educationYearList = [];
  String? batchName;
  String? selectedStartDate;
  String? selectedEndDate;
  int currentStep = 0;

  List<ValueItem>? selectedEducationYear;
  bool isLoading = false;
  bool isLodingGetEducationYears = false;
  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ControlMissionModel> controlMissionList = <ControlMissionModel>[];
  ValueItem? selectedItemEducationYear;
  Future<void> getEducationYears() async {
    isLodingGetEducationYears = true;
    update();

    final response = await ResponseHandler<EducationsYearsModel>().getResponse(
      path: EducationYearsLinks.educationyear,
      converter: EducationsYearsModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'title',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(
          Get.key.currentContext!,
        );
      },
      (r) {
        educationYearList = r.data!;
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.id))
            .toList();
        optionsEducationYear = items;
        update();
      },
    );

    isLodingGetEducationYears = false;
    update();
  }

  Future<bool> addControlMission() async {
    bool success = false;
    isLoading = true;
    update();
    // final response =
    //     await ResponseHandler<ControlMissionResModel>().getResponse(
    //   path: ControlMissionLinks.addControlMission,
    //   converter: ControlMissionResModel.fromJson,
    //   type: ReqTypeEnum.POST,
    //   body: {
    //     'start_date': selectedStartDate,
    //     'end_date': selectedEndDate,
    //     'education_year_id': selectedEducationYearId,
    //   },
    // );

    // response.fold(
    //   (l) {
    //     MyAwesomeDialogue(
    //       title: 'title',
    //       desc: l.message,
    //       dialogType: DialogType.error,
    //     ).showDialogue(
    //       Get.key.currentContext!,
    //     );
    // success = false;
    //   },
    //   (r) {
    //     success = true;
    // },
    // );
    isLoading = false;
    update();
    return success;
  }

  Future<bool> getControlMissionByEducationYear(int educationYearId) async {
    bool gotData = false;
    isLoading = true;
    update();

    ResponseHandler<ControlMissionsModel> responseHandler = ResponseHandler();
    Either<Failure, ControlMissionsModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionEducationYear}/$educationYearId",
      converter: ControlMissionsModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);

        gotData = false;
      },
      (r) {
        controlMissionList = r.data!;
        gotData = true;
      },
    );
    update();
    return gotData;
  }

  void setSelectedItemEducationYear(List<ValueItem> items) {
    selectedItemEducationYear = items.first;
    int educationYearId = selectedItemEducationYear!.value;
    getControlMissionByEducationYear(educationYearId);

    update();
  }

  bool canMoveToNextStep() {
    return selectedEndDate != null &&
        (batchName != null || batchName != null
            ? batchName!.isNotEmpty
            : false);
  }

  void continueToNextStep() {
    if (currentStep == 0) {
      currentStep++;
    }
    update();
  }

  void backToPreviousStep() {
    if (currentStep == 1) {
      currentStep--;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getEducationYears();
  }
}
