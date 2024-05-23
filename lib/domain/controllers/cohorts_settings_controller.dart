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

  bool addLoading = false;
  bool getAllLoading = false;

  Future getAllCohorts() async {
    getAllLoading = true;
    update();
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
    getAllLoading = false;
    update();
  }

  Future<bool> addnewCohort(String name) async {
    addLoading = true;
    update();
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

    addLoading = false;
    update();
    return cohortHasBeenAdded;
  }

  Future<bool> deleteCohort(int id) async {
    bool cohortHasBeenDeleted = false;
    ResponseHandler<CohortResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.cohort}/$id',
      converter: CohortResModel.fromJson,
      type: ReqTypeEnum.DELETE,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        cohortHasBeenDeleted = false;
      },
      (r) {
        cohorts.removeWhere((element) => element.iD == id);
        cohortHasBeenDeleted = true;
        update();
      },
    );

    return cohortHasBeenDeleted;
  }

  @override
  void onInit() {
    getAllCohorts();
    super.onInit();
  }
}
