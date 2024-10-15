import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../Data/Models/control_mission/control_missions_res_model.dart';
import '../../../Data/Models/education_year/education_year_model.dart';
import '../../../Data/Models/education_year/educations_years_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class ControlMissionController extends GetxController {
  List<ControlMissionResModel> controlMissionList = <ControlMissionResModel>[];
  List<EducationYearModel> educationYearList = [];
  List<ControlMissionResModel> filteredControlMissionList =
      <ControlMissionResModel>[];

  bool isLoading = false;
  bool isLoadingGetClassesRooms = false;
  bool isLoadingGetEducationYears = false;
  List<ValueItem> optionsEducationYear = <ValueItem>[];
  String searchQuery = '';
  List<ValueItem>? selectedEducationYear;
  ValueItem? selectedItemEducationYear;

  /// A function that activates a control mission by its ID and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [id]: The ID of the control mission to be activated.
  ///
  /// If the response is a failure, the function shows an error dialog with the failure
  /// message and sets [examMissionHasBeenDeleted] to false.
  ///
  /// If the response is a success, the function sets [examMissionHasBeenDeleted] to true,
  /// updates the UI by calling [update] and calls
  /// [getControlMissionByEducationYear] to update the list of control missions.
  ///
  /// The function returns [examMissionHasBeenDeleted].
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

  /// A function that deletes a control mission by its ID and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [id]: The ID of the control mission to be deleted.
  ///
  /// If the response is a failure, the function shows an error dialog with the failure
  /// message and sets [examMissionHasBeenDeleted] to false.
  ///
  /// If the response is a success, the function sets [examMissionHasBeenDeleted] to true,
  /// updates the UI by calling [update] and calls
  /// [getControlMissionByEducationYear] to update the list of control missions.
  ///
  /// The function returns [examMissionHasBeenDeleted].
  ///
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

  /// A function that gets the control missions of a school by education year ID
  ///
  /// The function takes the following parameters:
  ///
  /// - [educationYearId]: The ID of the education year.
  ///
  /// The function will return a boolean indicating whether the data was retrieved successfully.
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  Future<bool> getControlMissionByEducationYear(int educationYearId) async {
    bool gotData = false;
    isLoading = true;
    update();
    ResponseHandler<ControlMissionsResModel> responseHandler =
        ResponseHandler();
    Either<Failure, ControlMissionsResModel> response =
        await responseHandler.getResponse(
      path:
          "${ControlMissionLinks.controlMissionActiveSchool}/${Hive.box('School').get('Id')}/${ControlMissionLinks.controlMissionEducationYear}/$educationYearId",
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

  /// Gets all the education years from the API and sets the [educationYearList] with the education years returned by the API.
  ///
  /// It takes no parameters.
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// The function will return a boolean indicating whether the data was retrieved successfully.
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

  /// This function is called when the Getx controller is initialized.
  ///
  /// It calls the superclass's [onInit] method and then
  /// sets the [selectedItemEducationYear] to an empty list and
  /// calls [getEducationYears] to get the education years from the API.
  ///
  /// The call to [getEducationYears] will update the UI with a loading indicator
  /// while the request is being processed.
  void onInit() async {
    super.onInit();
    setSelectedItemEducationYear([]);
    getEducationYears();
  }

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

  /// A function that updates the search query and filters the list of control missions accordingly.
  ///
  /// The function takes the following parameters:
  ///
  /// - [query]: The search query.
  ///
  /// If the query is empty, the function sets [filteredControlMissionList] to
  /// [controlMissionList].
  ///
  /// If the query is not empty, the function sets [filteredControlMissionList]
  /// to a list of control missions from [controlMissionList] where the name
  /// of the control mission contains the query.
  ///
  /// The function calls [update] to update the UI.
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
