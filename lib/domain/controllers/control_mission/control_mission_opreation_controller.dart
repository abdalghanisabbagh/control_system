import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/education_year_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class ControlMissionOperationController extends GetxController {
  bool isLoading = false;
  bool isLoadingGetEducationYears = false;
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  List<EducationYearModel> educationYearList = [];
  List<ControlMissionResModel> filteredControlMissionList =
      <ControlMissionResModel>[];
  List<ValueItem> optionsEducationYear = <ValueItem>[];

  String searchQuery = '';
  List<ValueItem>? selectedEducationYear;
  ValueItem? selectedItemEducationYear;

  /// Activates a control mission by its ID and refreshes the list of control missions.
  ///
  /// Returns a boolean indicating whether the control mission was activated successfully.
  ///
  /// The function takes the following parameters:
  ///
  /// - [id]: The ID of the control mission to be activated.
  ///
  /// The function performs the following actions:
  ///
  /// - Sends a PATCH request to the server to activate the control mission.
  /// - If the response is a success, sets [examMissionHasBeenDeleted] to true and
  ///   refreshes the list of control missions by calling [getControlMissionByEducationYear]
  ///   with the selected education year.
  /// - If the response is a failure, shows an error dialogue with the failure message.
  /// - Updates the UI to reflect the changes.
  Future<bool> activeControlMission({
    required int id,
  }) async {
    bool examMissionHasBeenDeleted = false;

    ResponseHandler<void> responseHandler = ResponseHandler();

    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${ControlMissionLinks.controlMissionActivate}/$id',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {},
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        examMissionHasBeenDeleted = false;
      },
      (r) {
        examMissionHasBeenDeleted = true;
        getControlMissionByEducationYear(selectedItemEducationYear!.value);
      },
    );
    update();
    return examMissionHasBeenDeleted;
  }

  /// Deactivates a control mission by its ID.
  ///
  /// The function takes the ID of the control mission to be deactivated as a parameter.
  ///
  /// The function performs the following actions:
  ///
  /// - Sends a PATCH request to the server to deactivate the control mission.
  /// - If the response is a success, sets [examMissionHasBeenDeleted] to true and
  ///   refreshes the list of control missions by calling [getControlMissionByEducationYear]
  ///   with the selected education year.
  /// - If the response is a failure, shows an error dialogue with the failure message.
  /// - Updates the UI to reflect the changes.
  ///
  /// Returns a boolean indicating whether the control mission was deactivated successfully.
  Future<bool> deleteControlMission({
    required int id,
  }) async {
    bool examMissionHasBeenDeleted = false;

    ResponseHandler<void> responseHandler = ResponseHandler();

    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${ControlMissionLinks.controlMissionDeactivate}/$id',
      converter: (_) {},
      type: ReqTypeEnum.PATCH,
      body: {},
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        examMissionHasBeenDeleted = false;
      },
      (r) {
        examMissionHasBeenDeleted = true;
        getControlMissionByEducationYear(selectedItemEducationYear!.value);
      },
    );
    update();
    return examMissionHasBeenDeleted;
  }

  /// Gets the list of control missions by the given education year ID.
  ///
  /// The function takes the education year ID as a parameter.
  ///
  /// The function performs the following actions:
  ///
  /// - Sends a GET request to the server to get the list of control missions
  ///   by the given education year ID.
  /// - If the response is a success, assigns the response data to
  ///   [controlMissionList] and [filteredControlMissionList] and sets [gotData]
  ///   to true.
  /// - If the response is a failure, shows an error dialogue with the failure
  ///   message and sets [gotData] to false.
  /// - Updates the UI to reflect the changes.
  ///
  /// Returns a boolean indicating whether the data was obtained successfully.
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
        filteredControlMissionList = controlMissionList;
        gotData = true;
      },
    );
    isLoading = false;
    update();
    return gotData;
  }

  /// Gets all education years from the API and sets the [educationYearList] and
  /// [optionsEducationYear] with the education years returned by the API.
  ///
  /// The function performs the following actions:
  ///
  /// - Sends a GET request to the server to get the list of education years.
  /// - If the response is a success, assigns the response data to
  ///   [educationYearList] and generates a list of [ValueItem] objects from the
  ///   response data and assigns it to [optionsEducationYear].
  /// - If the response is a failure, shows an error dialogue with the failure
  ///   message.
  /// - Updates the UI to reflect the changes.
  ///
  /// Sets [isLoadingGetEducationYears] to true while the request is being processed
  /// and sets it to false when the request is finished.
  Future<void> getEducationYears() async {
    isLoadingGetEducationYears = true;
    update();

    final response = await ResponseHandler<EducationsYearsModel>().getResponse(
      path: EducationYearsLinks.educationYear,
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

    isLoadingGetEducationYears = false;
    update();
  }

  @override

  ///
  /// Called when the widget is initialized.
  ///
  /// Sets the default selected education year to an empty list.
  ///
  /// Calls [getEducationYears] to get the education years from the API.
  ///
  /// Calls [super.onInit] to initialize the parent class.
  ///
  void onInit() {
    setSelectedItemEducationYear([]);

    getEducationYears();

    super.onInit();
  }

  /// Sets the selected education year to the given list of [ValueItem] objects.
  ///
  /// If the given list is empty, sets the selected education year to null and clears
  /// the [controlMissionList].
  ///
  /// If the given list is not empty, sets the selected education year to the first
  /// element of the list and calls [getControlMissionByEducationYear] to get the
  /// list of control missions for the selected education year.
  ///
  /// Updates the UI to reflect the changes.
  void setSelectedItemEducationYear(List<ValueItem> items) {
    if (items.isEmpty) {
      selectedItemEducationYear = null;
      controlMissionList.clear();
    } else {
      selectedItemEducationYear = items.first;
      int educationYearId = selectedItemEducationYear!.value;
      getControlMissionByEducationYear(educationYearId);
    }
    update();
  }

  /// Updates the [searchQuery] with the given query and filters the
  /// [controlMissionList] to get the [filteredControlMissionList] that matches
  /// the query.
  ///
  /// If the query is empty, sets the [filteredControlMissionList] to the
  /// [controlMissionList]. Otherwise, filters the [controlMissionList] to only
  /// include control missions whose name contains the query.
  ///
  /// Updates the UI to reflect the changes.
  void updateSearchQuery(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredControlMissionList = controlMissionList;
    } else {
      filteredControlMissionList = controlMissionList.where((mission) {
        return mission.name?.toLowerCase().contains(query.toLowerCase()) ??
            false;
      }).toList();
    }
    update();
  }
}
