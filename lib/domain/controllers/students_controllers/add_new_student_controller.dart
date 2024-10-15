import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../Data/Models/class_room/classes_rooms_res_model.dart';
import '../../../Data/Models/cohort/cohorts_res_model.dart';
import '../../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../../Data/Models/student/student_res_model.dart';
import '../../../Data/Models/user/login_response/user_profile_model.dart';
import '../../../Data/Network/response_handler.dart';
import '../../../Data/enums/req_type_enum.dart';
import '../../../app/configurations/app_links.dart';
import '../../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import '../profile_controller.dart';
import 'student_controller.dart';

class AddNewStudentController extends GetxController {
  bool checkSelectedClassRoom = false;
  bool checkSelectedCohort = false;
  bool checkSelectedGrade = false;
  bool isLoading = false;
  bool isLoadingAddStudent = false;
  List<ValueItem> optionsClassRoom = <ValueItem>[];
  List<ValueItem> optionsCohort = <ValueItem>[];
  List<ValueItem> optionsGrades = <ValueItem>[];
  ValueItem? selectedItemClassRoom;
  ValueItem? selectedItemCohort;
  ValueItem? selectedItemGrade;
  StudentController studentController = Get.find<StudentController>();

  final UserProfileModel? _userProfile =
      Get.find<ProfileController>().cachedUserProfile;

  /// Adds a new student to the server and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [blbID]: the id of the student's blb
  /// - [gradesId]: the id of the student's grade
  /// - [cohortId]: the id of the student's cohort
  /// - [schoolClassId]: the id of the student's school class
  /// - [firstName]: the first name of the student
  /// - [secondName]: the second name of the student
  /// - [thirdName]: the third name of the student
  /// - [secondLang]: the second language of the student
  /// - [religion]: the religion of the student
  /// - [citizenship]: the citizenship of the student
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the student has been added
  /// to the server.
  Future<bool> addNewStudent({
    required int blbID,
    required int gradesId,
    required int cohortId,
    required int schoolClassId,
    required String firstName,
    required String secondName,
    required String thirdName,
    required String secondLang,
    required String religion,
    required String citizenship,
  }) async {
    isLoadingAddStudent = true;

    update();
    bool addStudentHasBeenAdded = false;
    int schoolId = Hive.box('School').get('Id');
    ResponseHandler<StudentResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
        path: StudentsLinks.student,
        converter: StudentResModel.fromJson,
        type: ReqTypeEnum.POST,
        body: {
          "Blb_Id": blbID,
          "Grades_ID": gradesId,
          "Schools_ID": schoolId,
          "Cohort_ID": cohortId,
          "School_Class_ID": schoolClassId,
          "First_Name": firstName,
          "Second_Name": secondName,
          "Third_Name": thirdName,
          "Created_By": _userProfile?.iD,
          "Second_Lang": secondLang,
          "Religion": religion,
          "Citizenship": citizenship,
        });

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      addStudentHasBeenAdded = false;
    }, (result) {
      studentController.getStudents();
      addStudentHasBeenAdded = true;
    });
    isLoadingAddStudent = false;

    update();
    return addStudentHasBeenAdded;
  }

  /// Gets all the cohorts by school type from the API and sets the
  /// [optionsCohort] with the cohorts returned by the API.
  ///
  /// It sets the [isLoading] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the add new student
  /// page.
  ///
  /// The function returns a boolean indicating whether the cohorts were
  /// retrieved successfully.
  Future<bool> getCohortBySchoolTypeId() async {
    update();
    bool cohortHasBeenAdded = false;

    ResponseHandler<CohortsResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: CohortLinks.getCohortBySchoolType,
      converter: CohortsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      cohortHasBeenAdded = false;
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsCohort = items;
      cohortHasBeenAdded = true;
    });
    update();
    return cohortHasBeenAdded;
  }

  /// Gets all grades from the API and sets the
  /// [optionsGrades] with the grades returned by the API.
  ///
  /// It sets the [isLoadingGrades] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the failure
  /// message.
  ///
  /// The function is used when the user navigates to the add new student
  /// page.
  ///
  /// The function returns a boolean indicating whether the grades were
  /// retrieved successfully.
  Future<bool> getGradesBySchoolId() async {
    update();
    bool gradeHasBeenAdded = false;

    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: GradeLinks.gradesSchools,
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      gradeHasBeenAdded = false;
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsGrades = items;
    });
    gradeHasBeenAdded = true;
    update();
    return gradeHasBeenAdded;
  }

  /// Gets all school classes by school id from the API and sets the
  /// [optionsClassRoom] with the school classes returned by the API.
  ///
  /// It sets the [isLoading] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the add new student
  /// page.
  ///
  /// The function returns a boolean indicating whether the school classes
  /// were retrieved successfully.
  Future<bool> getSchoolsClassBySchoolId() async {
    update();
    bool classRoomHasBeenAdded = false;

    ResponseHandler<ClassesRoomsResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: SchoolsLinks.getSchoolsClassesBySchoolId,
      converter: ClassesRoomsResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold((failure) {
      MyAwesomeDialogue(
        title: 'Error',
        desc: "${failure.code} ::${failure.message}",
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!);
      classRoomHasBeenAdded = false;
    }, (result) {
      List<ValueItem> items = result.data!
          .map((item) => ValueItem(label: item.name!, value: item.iD))
          .toList();
      optionsClassRoom = items;
    });
    classRoomHasBeenAdded = true;
    update();
    return classRoomHasBeenAdded;
  }

  @override

  /// This function is called when the controller is initialized.
  ///
  /// It sets [isLoading] to true and then to false depending on the
  /// response of the API.
  ///
  /// It calls [getGradesBySchoolId], [getCohortBySchoolTypeId], and
  /// [getSchoolsClassBySchoolId] and waits for the three requests to
  /// finish using [Future.wait].
  ///
  /// It then updates the UI with the retrieved data.
  ///
  /// The function is called when the user navigates to the add new
  /// student page.
  void onInit() async {
    super.onInit();
    isLoading = true;
    update();
    await Future.wait([
      getGradesBySchoolId(),
      getCohortBySchoolTypeId(),
      getSchoolsClassBySchoolId()
    ]);
    isLoading = false;
    update();
  }

  ///
  /// Sets the selected item for the class room dropdown to the first item of
  /// [items] and updates the UI.
  ///
  /// The function takes one parameter, [items], which is a list of [ValueItem]
  /// objects representing the items in the class room dropdown.
  ///
  /// The function will return nothing.
  void setSelectedItemClassRoom(List<ValueItem> items) {
    selectedItemClassRoom = items.first;
    update();
  }

  /// Sets the selected item for the cohort dropdown to the first item of
  /// [items] and updates the UI.
  ///
  /// The function takes one parameter, [items], which is a list of [ValueItem]
  /// objects representing the items in the cohort dropdown.
  ///
  /// The function will return nothing.
  void setSelectedItemCohort(List<ValueItem> items) {
    selectedItemCohort = items.first;
    update();
  }

  /// Sets the selected item for the grade dropdown to the first item of
  /// [items] and updates the UI.
  ///
  /// The function takes one parameter, [items], which is a list of [ValueItem]
  /// objects representing the items in the grade dropdown.
  ///
  /// The function will return nothing.
  void setSelectedItemGrade(List<ValueItem> items) {
    selectedItemGrade = items.first;
    update();
  }
}
