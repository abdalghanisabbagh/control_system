import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/control_mission/control_mission_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/education_year_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class ControlMissionController extends GetxController {
  List<EducationYearModel> educationYearList = [];

  List<ValueItem>? selectedEducationYear;
  bool isLoading = false;
  bool isLodingGetEducationYears = false;
  bool isLodingGetClassesRooms = false;

  List<ValueItem> optionsEducationYear = <ValueItem>[];
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  ValueItem? selectedItemEducationYear;

  // Future<void> getExamRoomByControlMissionId(int controlMissionId) async {
  //   isLodingGetClassesRooms = true;
  //   update();
  //   final response = await ResponseHandler<ExamRoomsResModel>().getResponse(
  //     path: "${ExamLinks.examRoomsControlMission}/$controlMissionId",
  //     converter: ExamRoomsResModel.fromJson,
  //     type: ReqTypeEnum.GET,
  //   );

  //   response.fold(
  //     (l) {
  //       MyAwesomeDialogue(
  //         title: 'title',
  //         desc: l.message,
  //         dialogType: DialogType.error,
  //       ).showDialogue(
  //         Get.key.currentContext!,
  //       );
  //     },
  //     (r) {
  //       //  print("dfghjk");
  //       // educationYearList = r.data!;
  //       // List<ValueItem> items = r.data!
  //       //     .map((item) => ValueItem(label: item.name!, value: item.id))
  //       //     .toList();
  //       // optionsEducationYear = items;
  //       update();
  //     },
  //   );

  //   isLodingGetClassesRooms = false;
  //   update();
  // }

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

  Future<bool> getControlMissionByEducationYear(int educationYearId) async {
    bool gotData = false;
    isLoading = true;
    update();
    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionSchool}/${Hive.box('School').get('Id')}/${ControlMissionLinks.controlMissionEducationYear}/$educationYearId",
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

        gotData = false;
      },
      (r) {
        controlMissionList = r.data!;
        gotData = true;
      },
    );
    isLoading = false;
    update();
    return gotData;
  }

  void setSelectedItemEducationYear(List<ValueItem> items) {
    selectedItemEducationYear = items.first;
    int educationYearId = selectedItemEducationYear!.value;
    getControlMissionByEducationYear(educationYearId);
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    getEducationYears();
  }
}
