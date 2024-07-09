import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Models/cohort/cohort_res_model.dart';
import '../../Data/Models/cohort/cohorts_res_model.dart';
import '../../Data/Models/user/login_response/user_profile_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'profile_controller.dart';

class CohortsSettingsController extends GetxController {
  final UserProfileModel? _userProfile =
      Get.find<ProfileController>().cachedUserProfile;

  bool addLoading = false;
  List<CohortResModel> cohorts = <CohortResModel>[];
  bool getAllLoading = false;
  List<int> selectedSubjectsIds = <int>[];

  @override
  void onInit() {
    getAllCohorts();
    super.onInit();
  }

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
        "School_Type_ID": Hive.box('School').get('SchoolTypeID'),
        "Created_By": _userProfile?.iD,
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
        getAllCohorts();
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
        getAllCohorts();
        cohortHasBeenDeleted = true;
        update();
      },
    );

    return cohortHasBeenDeleted;
  }

  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSubjectsIds =
        selectedOptions.map((e) => e.value as int).toList().cast<int>();
    update();
  }

  Future<bool> addNewsubjecstToCohort(int id) async {
    addLoading = true;
    bool cohortHasBeenAdded = false;
    update();
    ResponseHandler<CohortResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.connectSubjectToCohort}/$id',
      converter: CohortResModel.fromJson,
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

  Future<bool> deleteSubjectFromCohort({
    required int cohortId,
    required int subjectId,
  }) async {
    bool subjectHasBeenDeleted = false;
    update();
    ResponseHandler<CohortResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortResModel> response =
        await responseHandler.getResponse(
      path: '${SchoolsLinks.disConnectSubjectFromCohort}/$cohortId',
      converter: CohortResModel.fromJson,
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
    update();
    return subjectHasBeenDeleted;
  }
}
