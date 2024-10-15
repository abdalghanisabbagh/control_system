import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../Data/Models/cohort/cohort_res_model.dart';
import '../../Data/Models/cohort/cohorts_res_model.dart';
import '../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class OperationCohortController extends GetxController {
  List<CohortResModel> cohorts = <CohortResModel>[];
  bool loadingCohorts = false;
  SchoolsTypeResModel? schoolsType;
  List<int> selectedSubjectsIds = <int>[];

  /// Deletes a cohort from the server and updates the UI.
  ///
  /// The function takes the ID of the cohort to be deleted as a parameter.
  ///
  /// It makes a DELETE request to the server to delete the cohort with the given
  /// [id].
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is a success, it calls [getAllCohorts] and updates the UI
  /// to show that the cohort has been deleted from the server.
  ///
  /// The function returns a boolean indicating whether the cohort was deleted
  /// successfully.
  Future<bool> deleteCohort(int id) async {
    bool cohortHasBeenDeleted = false;
    ResponseHandler<CohortResModel> responseHandler = ResponseHandler();
    Either<Failure, CohortResModel> response =
        await responseHandler.getResponse(
      path: '${CohortLinks.cohort}/$id',
      converter: CohortResModel.fromJson,
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

    getAllCohorts();

    return cohortHasBeenDeleted;
  }

  /// Gets all cohorts from the server and updates the UI.
  ///
  /// The function is asynchronous and returns a future of void.
  ///
  /// The function makes a GET request to the server to get all cohorts.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is a success, it assigns the returned list of cohorts to
  /// [cohorts] and updates the UI.
  ///
  /// The function also updates the UI to show a loading indicator while the
  /// request is being processed.
  Future getAllCohorts() async {
    loadingCohorts = true;
    update();
    final response = await ResponseHandler<CohortsResModel>().getResponse(
      path: CohortLinks.cohort,
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
    loadingCohorts = false;
    update();
  }

  /// Gets all school types from the server and updates the UI.
  ///
  /// The function is asynchronous and returns a future of void.
  ///
  /// The function makes a GET request to the server to get all school types.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is a success, it assigns the returned list of school types
  /// to [schoolsType] and updates the UI.
  Future<void> getAllSchoolTypes() async {
    ResponseHandler<SchoolsTypeResModel> responseHandler = ResponseHandler();

    Either<Failure, SchoolsTypeResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.schoolsType,
      converter: SchoolsTypeResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (r) {
        schoolsType = r;
        update();
      },
    );
  }

  @override

  /// This function is called when the widget is initialized.
  ///
  /// It first calls the [onInit] function of the parent class.
  ///
  /// Then, it calls [getAllCohorts] to get all cohorts from the server
  /// and updates the UI.
  ///
  /// Finally, it calls [getAllSchoolTypes] to get all school types from the
  /// server and updates the UI.
  void onInit() async {
    super.onInit();
    getAllCohorts();
    await getAllSchoolTypes();
  }
}
