import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/school/school_type/school_type_model.dart';
import '../../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class EditSubjectsController extends GetxController {
  bool addLoading = false;
  bool editLoading = false;
  bool getAllLoading = false;
  bool getSchoolTypeLoading = false;
  RxBool inExam = true.obs;
  List<int> initialSelectedSchoolTypeIds = <int>[];
  List<SchoolTypeResModel> schoolsType = <SchoolTypeResModel>[];
  List<int> selectedSchoolTypeIds = <int>[];
  List<SubjectResModel> subjects = <SubjectResModel>[];

  /// This function deletes a school type from a subject in the database.
  ///
  /// It takes the following parameters:
  ///
  /// - [idSubject]: The ID of the subject.
  /// - [idSchoolType]: The ID of the school type.
  ///
  /// The function will return a boolean indicating whether the delete was successful.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  Future<bool> deleteSchoolTypeInSubject({
    required int idSubject,
    required int idSchoolType,
  }) async {
    editLoading = true;
    update();
    bool subjectHasBeenUpdated = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path:
          '${SubjectsLinks.deleteSchoolTypeInSubjects}/$idSubject/$idSchoolType',
      converter: SubjectResModel.fromJson,
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
        subjectHasBeenUpdated = false;
      },
      (r) {
        subjectHasBeenUpdated = true;
        update();
      },
    );
    editLoading = false;
    update();
    return subjectHasBeenUpdated;
  }

  /// Edits a subject in the server and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [id]: The ID of the subject to be edited.
  /// - [schholTypeIds]: The IDs of the school types that the subject is associated with.
  /// - [name]: The name of the subject.
  /// - [inexam]: The value of the inexam field of the subject.
  /// - [active]: The value of the active field of the subject.
  ///
  /// The function will return a boolean indicating whether the subject was edited successfully.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  Future<bool> editSubject({
    required int id,
    required List schholTypeIds,
    required String name,
    required int inexam,
    required int active,
  }) async {
    editLoading = true;
    update();
    bool subjectHasBeenUpdated = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: '${SubjectsLinks.subjects}/$id',
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: {
        "Name": name,
        'schools_type_ID': schholTypeIds,
        "InExam": inexam,
        "Active": active
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        subjectHasBeenUpdated = false;
      },
      (r) {
        subjectHasBeenUpdated = true;
        update();
      },
    );
    editLoading = false;
    update();
    return subjectHasBeenUpdated;
  }

  /// Gets all the school types from the server and updates the UI.
  ///
  /// The function sets the [getSchoolTypeLoading] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, the function will show an error dialog with the
  /// failure message.
  ///
  /// The function also updates the UI with the schools types returned by the API.
  ///
  /// The function is used when the user navigates to the edit subject page.
  Future<void> getSchoolType() async {
    getSchoolTypeLoading = true;
    update();
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
        schoolsType = r.data!;
      },
    );
    getSchoolTypeLoading = false;
    update();
  }

  @override

  /// Called when the widget is initialized.
  ///
  /// Calls [getSchoolType] to load the school types and then calls the parent's
  /// [onInit] method.
  void onInit() {
    getSchoolType();
    super.onInit();
  }

  /// Called when an option is selected from the dropdown.
  ///
  /// The function takes the selected options as a parameter and updates
  /// the [selectedSchoolTypeIds] with the values of the selected options.
  ///
  /// The function also calls [update] to update the UI.
  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSchoolTypeIds =
        selectedOptions.map((e) => e.value).toList().cast<int>();
    update();
  }
}
