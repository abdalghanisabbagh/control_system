import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/school/school_type/school_type_model.dart';
import '../../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../Data/Models/subject/subjects_res_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/Network/tools/failure_model.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';

class SubjectsController extends GetxController {
  bool addLoading = false;
  bool editLoading = false;
  bool getAllLoading = false;
  bool getSchoolTypeLoading = false;
  RxBool inExam = true.obs;
  List<SchoolTypeResModel> schoolsType = <SchoolTypeResModel>[];
  List<int> selectedSchoolTypeIds = <int>[];
  List<SubjectResModel> subjects = <SubjectResModel>[];

  /// Adds a new subject to the server and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [name]: The name of the subject.
  /// - [inExam]: The value of the inexam field of the subject.
  /// - [schholTypeIds]: The IDs of the school types that the subject is associated with.
  ///
  /// The function will return a boolean indicating whether the subject was added successfully.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is a failure, the function will show an error dialog with the failure message.
  ///
  /// If the response is successful, the function will update the list of subjects in the [SubjectsController] and reset the UI to show that no file has been imported.
  Future<bool> addNewSubject({
    required String name,
    required bool inExam,
    required List schholTypeIds,
  }) async {
    addLoading = true;
    update();
    bool subjectHasBeenAdded = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response =
        await responseHandler.getResponse(
      path: SubjectsLinks.subjects,
      converter: SubjectResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Name": name,
        "InExam": inExam ? 1 : 0,
        'schools_type_ID': schholTypeIds
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        subjectHasBeenAdded = false;
      },
      (r) {
        getAllSubjects();
        subjectHasBeenAdded = true;
      },
    );
    // getSubjectsFromServerbyGradeId();
    addLoading = false;
    update();
    return subjectHasBeenAdded;
  }

  /// Deletes a subject from the server and updates the UI.
  ///
  /// The function takes the ID of the subject to be deleted as a parameter.
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the subject has been deleted
  /// from the server.
  ///
  /// The function returns a boolean indicating whether the subject was deleted
  /// successfully.
  Future<bool> deleteSubject({required int id}) async {
    bool subjectHasBeenDeleted = false;
    ResponseHandler<SubjectResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectResModel> response = await responseHandler
        .getResponse(
            path: '${SubjectsLinks.subjectsDeactivate}/$id',
            converter: SubjectResModel.fromJson,
            type: ReqTypeEnum.PATCH,
            body: {});
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
        getAllSubjects();
        update();
        subjectHasBeenDeleted = true;
      },
    );
    return subjectHasBeenDeleted;
  }

  /// Edits a subject in the server and updates the UI.
  //
  /// The function takes the following parameters:
  //
  /// - [id]: The ID of the subject to be edited.
  /// - [schoolTypeIds]: The IDs of the school types that the subject is associated with.
  //
  /// The function will show an error dialog if the response is a failure.
  //
  /// The function will also update the UI to show that the subject has been edited
  /// in the server.
  //
  /// The function returns a boolean indicating whether the subject was edited
  /// successfully.
  Future<bool> editSubject({
    required int id,
    // required String name,
    required List schoolTypeIds,
    // required int inExam,
    // required String title,
    // required bool inExam,
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
        //"Name": name,
        'schools_type_ID': schoolTypeIds,
        "InExam": 1,
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
        getAllSubjects();
        subjectHasBeenUpdated = true;
        update();
      },
    );
    editLoading = false;
    update();
    return subjectHasBeenUpdated;
  }

  /// Gets all subjects from the server and updates the UI
  ///
  /// This function sends a GET request to the server to get all subjects
  /// for the current school type. The response is handled by the
  /// [ResponseHandler]. If the response is successful, the subjects list
  /// is updated and the UI is updated. If the response is not successful,
  /// an error dialog is shown with the error message from the response.
  ///
  /// The function also updates the options for the subject dropdown
  /// with the subjects from the response.
  Future getAllSubjects() async {
    getAllLoading = true;
    update();
    ResponseHandler<SubjectsResModel> responseHandler = ResponseHandler();
    Either<Failure, SubjectsResModel> response =
        await responseHandler.getResponse(
      path:
          '${SubjectsLinks.subjectsBySchoolType}${Hive.box('School').get('SchoolTypeID')}',
      converter: SubjectsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        getAllLoading = false;
        update();
      },
      (r) {
        subjects.assignAll(r.data!);
        getAllLoading = false;
        update();
      },
    );
  }

  /// Gets all the school types from the server and updates the UI
  ///
  /// This function sends a GET request to the server to get all school types.
  /// The response is handled by the [ResponseHandler]. If the response is
  /// successful, the school types list is updated and the UI is updated. If
  /// the response is not successful, an error dialog is shown with the error
  /// message from the response.
  ///
  /// The function also updates the loading indicator in the UI.
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

  /// Initializes the controller by calling [getSchoolType] and [getAllSubjects] to
  /// populate the school types and subjects lists respectively. Then calls the
  /// [onInit] method of the superclass.
  void onInit() {
    getSchoolType();
    getAllSubjects();
    super.onInit();
  }

  /// Updates the [selectedSchoolTypeIds] with the IDs of the selected school types in the
  /// [selectedOptions] list. Then calls [update] to update the UI.
  ///
  /// [selectedOptions] is a list of [ValueItem] objects where the value is the ID of the school type.
  ///
  void onOptionSelected(List<ValueItem<dynamic>> selectedOptions) {
    selectedSchoolTypeIds =
        selectedOptions.map((e) => e.value).toList().cast<int>();
    update();
  }

  /// Sorts the subjects list by creation time in ascending or descending order.
  //
  /// [asc] is a boolean that defaults to true, indicating that the subjects should
  /// be sorted in ascending order of creation time. If [asc] is false, the subjects
  /// are sorted in descending order of creation time.
  //
  /// The function updates the UI after sorting the list.
  //
  /// The function is used in the subject settings page to sort the subjects list
  /// by creation time.
  void sortSubjectsByCreationTime({bool asc = true}) {
    subjects.sort((a, b) => asc
        ? a.createdAt!.compareTo(b.createdAt!)
        : b.createdAt!.compareTo(a.createdAt!));
    update();
  }

  /// Sorts the subjects list by name in ascending or descending order, using the same
  /// logic as [sortCohortsByName].
  ///
  /// [asc] is a boolean that defaults to true, indicating that the subjects should
  /// be sorted in ascending order of name. If [asc] is false, the subjects are sorted
  /// in descending order of name.
  ///
  /// The function updates the UI after sorting the list.
  ///
  /// The function is used in the subject settings page to sort the subjects list
  /// by name.
  void sortSubjectsByName({bool asc = true}) {
    subjects.sort((a, b) {
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
