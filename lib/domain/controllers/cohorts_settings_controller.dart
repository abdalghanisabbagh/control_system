import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/cohort/cohort_res_model.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../Data/Models/cohort/cohorts_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class CohortsSettingsController extends GetxController {
  List<CohortResModel> cohorts = <CohortResModel>[];

  Future getAllCohorts() async {
    final response = await ResponseHandler<CohortsResModel>().getResponse(
      path: SchoolsLinks.cohort,
      converter: CohortsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) => MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!),
      (r) {
        cohorts = r.data!;
        update();
      },
    );
  }

  Future<bool> addnewCohort(String name) async {
    bool cohortHasBeenAdded = false;
    ResponseHandler<CohortResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.cohort,
      converter: CohortResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "Created_By": 1,
        "School_Type_ID": 1,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);

        cohortHasBeenAdded = false;
      },
      (r) {
        cohorts = [...cohorts, r];
        cohortHasBeenAdded = true;
        update();
      },
    );
    return cohortHasBeenAdded;
  }

  @override
  void onInit() {
    getAllCohorts();
    super.onInit();
  }
}
