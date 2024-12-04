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
  List<int> selectedSchoolTypeId = <int>[];
  List<int> selectedSubjectsIds = <int>[];

  /// Adds a new cohort to the server and updates the UI.
  ///
  /// The function takes the name of the cohort as a parameter.
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the cohort has been added
  /// to the server.
  ///
  /// The function returns a boolean indicating whether the cohort was added
  /// successfully.
  Future<bool> addNewCohort(String name) async {
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
        "School_Type_ID": selectedSchoolTypeId.firstOrNull ??
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

  /// Adds the selected subjects to the cohort with the given [id].
  ///
  /// The function first sets [addLoading] to true and calls [update].
  ///
  /// Then, it makes a POST request to the server to connect the selected
  /// subjects to the cohort.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is a success, it sets [addLoading] to false, calls [update]
  /// and clears [selectedSubjectsIds].
  ///
  /// The function returns a boolean indicating whether the subjects were added
  /// successfully.
  Future<bool> addNewSubjectsToCohort(int id) async {
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

  /// Deletes a cohort from the server and updates the UI.
  ///
  /// The function makes a DELETE request to the server to delete the cohort
  /// with the given [id].
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

  /// Deletes a subject from a cohort and updates the UI.
  ///
  /// The function takes two parameters: [cohortId] and [subjectId].
  ///
  /// It makes a POST request to the server to delete the subject with the given
  /// [subjectId] from the cohort with the given [cohortId].
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is a success, it calls [getAllCohorts] and updates the UI
  /// to show that the subject has been deleted from the cohort.
  ///
  /// The function returns a boolean indicating whether the subject was deleted
  /// successfully.
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

  /// Edits a cohort in the server and updates the UI.
  ///
  /// The function takes three parameters: [id], [name], and [schoolTypeID].
  ///
  /// It makes a PATCH request to the server to update the cohort with the given
  /// [id] with the given [name] and [schoolTypeID].
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is a success, it calls [getAllCohorts] and updates the UI
  /// to show that the cohort has been updated.
  ///
  /// The function returns a boolean indicating whether the cohort was updated
  /// successfully.
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

  /// Gets all cohorts from the server and updates the UI.
  ///
  /// The function sends a GET request to the server to get all cohorts
  /// for the current school type. The response is handled by the
  /// [ResponseHandler].
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// If the response is a success, it updates the [cohorts] list and updates
  /// the UI to show the new list of cohorts.
  ///
  /// The function returns a Future of void.
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

  /// This function is called when the widget is initialized.
  ///
  /// It calls [getAllCohorts] to get all cohorts from the server and
  /// then calls the [onInit] function of the superclass to complete the
  /// initialization process.
  void onInit() {
    getAllCohorts();
    super.onInit();
  }

  /// Updates the [selectedSubjectsIds] with the IDs of the selected subjects in the
  /// [selectedOptions] list. Then calls [update] to update the UI.
  ///
  /// [selectedOptions] is a list of [ValueItem] objects where the value is the ID of the subject.
  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSubjectsIds =
        selectedOptions.map((e) => e.value as int).toList().cast<int>();
    update();
  }

  /// Sorts the [cohorts] list by the creation time of the cohorts.
  ///
  /// The sorting is done in ascending order by default, but can be changed
  /// to descending order by setting [asc] to false.
  ///
  /// After sorting, the UI is updated by calling [update].
  ///
  void sortCohortsByCreationTime({bool asc = true}) {
    cohorts.sort((a, b) => asc
        ? a.createdAt!.compareTo(b.createdAt!)
        : b.createdAt!.compareTo(a.createdAt!));
    update();
  }

  /// Sorts the [cohorts] list by name in ascending or descending order, using the same
  /// logic as [sortCohortsByCreationTime].
  ///
  /// [asc] is a boolean that defaults to true, indicating that the cohorts should
  /// be sorted in ascending order of name. If [asc] is false, the cohorts are sorted
  /// in descending order of name.
  ///
  /// The function updates the UI after sorting the list.
  ///
  /// The function is used in the cohort settings page to sort the cohorts list
  /// by name.
  void sortCohortsByName({bool asc = true}) {
    cohorts.sort((a, b) {
      final regex = RegExp(r'(\d+)|(\D+)');
      final aMatches = regex.allMatches(a.name!).map((m) => m[0]).toList();
      final bMatches = regex.allMatches(b.name!).map((m) => m[0]).toList();

      for (int i = 0; i < aMatches.length && i < bMatches.length; i++) {
        final aPart = aMatches[i]!;
        final bPart = bMatches[i]!;

        final isANumeric = int.tryParse(aPart) != null;
        final isBNumeric = int.tryParse(bPart) != null;

        if (isANumeric && isBNumeric) {
          final compareNumeric = int.parse(aPart).compareTo(int.parse(bPart));
          if (compareNumeric != 0) {
            return asc ? compareNumeric : -compareNumeric;
          }
        } else {
          final compareAlpha = aPart.compareTo(bPart);
          if (compareAlpha != 0) return asc ? compareAlpha : -compareAlpha;
        }
      }

      return asc ? a.name!.compareTo(b.name!) : b.name!.compareTo(a.name!);
    });
    update();
  }
}
