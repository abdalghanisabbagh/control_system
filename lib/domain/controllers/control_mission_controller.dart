import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/education_year/education_year_model.dart';
import 'package:control_system/Data/Models/education_year/educations_years_res_model.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:get/get.dart';

import '../../Data/Network/response_handler.dart';
import '../../Data/enums/req_type_enum.dart';

class ControlMissionController extends GetxController {
  List<EducationYearModel> educationYearList = [];
  String? selectedStartDate;
  String? selectedEndDate;

  int selectedEducationYearId = -1;
  bool isLoading = false;

  Future<void> getEducationYears() async {
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
        update();
      },
    );
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

  @override
  void onInit() {
    super.onInit();
    getEducationYears();
  }
}
