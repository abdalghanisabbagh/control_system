import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Models/cohort/cohort_res_model.dart';
import '../../Data/Models/cohort/cohorts_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import 'operation_cohort_controller.dart';

class CohortsSettingsController extends GetxController {
  bool addLoading = false;
  List<CohortResModel> cohorts = <CohortResModel>[];
  bool deleteSubjectLoading = false;
  bool getAllLoading = false;
  List<int> selectedSubjectsIds = <int>[];
  List<int> slectedSchoolTypeId = <int>[];

  Future<bool> addnewCohort(String name) async {
    addLoading = true;
    update();
    bool cohortHasBeenAdded = false;
    ResponseHandler<void> responseHandler = ResponseHandler();

    Either<Failure, void> response = await responseHandler.getResponse(
      path: CohortLinks.operationCreateCohort,
      converter: (_) {},
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "School_Type_ID": slectedSchoolTypeId.firstOrNull ??
            Hive.box('School').get('SchoolTypeID'),
      },
    );
    ////////
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
        getAllCohorts();
        cohortHasBeenAdded = true;
        update();
      },
    );
    Get.find<OperationCohortController>().onInit();
    addLoading = false;
    update();
    return cohortHasBeenAdded;
  }

  Future<bool> addNewsubjecstToCohort(int id) async {
    addLoading = true;
    bool cohortHasBeenAdded = false;
    update();
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${CohortLinks.connectSubjectToCohort}/$id',
      converter: (_) {},
      type: ReqTypeEnum.POST,
      body: selectedSubjectsIds,
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
        getAllCohorts();
        cohortHasBeenAdded = true;
        update();
      },
    );

    selectedSubjectsIds.clear();
    addLoading = false;
    update();
    return cohortHasBeenAdded;
  }

  Future<bool> deleteCohort(int id) async {
    bool cohortHasBeenDeleted = false;
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${CohortLinks.cohort}/$id',
      converter: (_) {},
      type: ReqTypeEnum.DELETE,
      body: {},
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
        getAllCohorts();
        cohortHasBeenDeleted = true;
        update();
      },
    );

    return cohortHasBeenDeleted;
  }

  Future<bool> deleteSubjectFromCohort({
    required int cohortId,
    required int subjectId,
  }) async {
    deleteSubjectLoading = true;
    bool subjectHasBeenDeleted = false;
    update(['delete_${cohortId}_$subjectId']);
    ResponseHandler<void> responseHandler = ResponseHandler();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${CohortLinks.disConnectSubjectFromCohort}/$cohortId',
      converter: (_) {},
      type: ReqTypeEnum.POST,
      body: subjectId,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        subjectHasBeenDeleted = false;
      },
      (r) {
        getAllCohorts();
        subjectHasBeenDeleted = true;
      },
    );
    deleteSubjectLoading = false;
    update(['delete_${cohortId}_$subjectId']);
    return subjectHasBeenDeleted;
  }

  Future<bool> editCohort(int id, String name, int? schoolTypeID) async {
    addLoading = true;
    update();
    bool cohortHasBeenAdded = false;
    ResponseHandler<CohortResModel> responseHandler = ResponseHandler();

    Either<Failure, CohortResModel> response =
        await responseHandler.getResponse(
      path: '${CohortLinks.cohort}/$id',
      converter: CohortResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {
        "Name": name,
        if (schoolTypeID != null) "School_Type_ID": schoolTypeID,
      },
    );
    ////////
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
        getAllCohorts();
        cohortHasBeenAdded = true;
        update();
      },
    );
    Get.find<OperationCohortController>().onInit();
    addLoading = false;
    update();
    return cohortHasBeenAdded;
  }

  Future getAllCohorts() async {
    getAllLoading = true;
    update();
    final response = await ResponseHandler<CohortsResModel>().getResponse(
      path: '${CohortLinks.cohort}/school-type',
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

  @override
  void onInit() {
    getAllCohorts();
    super.onInit();
  }

  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSubjectsIds =
        selectedOptions.map((e) => e.value as int).toList().cast<int>();
    update();
  }
}
