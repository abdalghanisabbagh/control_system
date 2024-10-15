import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../Data/Models/school/grade_response/grades_res_model.dart';
import '../../Data/Models/school/school_response/school_res_model.dart';
// import '../../Data/Models/school/school_response/schools_res_model.dart';
import '../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../Data/Models/token/token_model.dart';
import '../../Data/Models/user/login_response/login_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import '../services/token_service.dart';
import 'profile_controller.dart';

class SchoolController extends GetxController {
  List<GradeResModel> grades = <GradeResModel>[];
  bool isLoading = false;
  bool isLoadingAddGrades = true;
  bool isLoadingAddSchool = false;
  bool isLoadingGrades = false;
  bool isLoadingSchools = false;
  List<ValueItem> options = <ValueItem>[];
  List schoolType = [];
  List<SchoolResModel> schools = <SchoolResModel>[];
  ValueItem? selectedItem;
  int selectedSchoolId = (-1);
  int selectedSchoolIndex = (-1);
  String selectedSchoolName = "";

  /// Adds a new grade to the server and updates the UI.
  ///
  /// The function takes the following parameter:
  ///
  /// - [name]: the name of the grade
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the grade has been added
  /// to the server.
  Future<bool> addNewGrade({
    required String name,
  }) async {
    isLoadingAddGrades = true;
    update();
    bool gradeHasBeenAdded = false;
    ResponseHandler<GradeResModel> responseHandler = ResponseHandler();
    Either<Failure, GradeResModel> response = await responseHandler.getResponse(
      path: GradeLinks.grades,
      converter: GradeResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Schools_ID": selectedSchoolId,
        "Name": name,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        gradeHasBeenAdded = false;
      },
      (r) {
        // spread operator to add new grade
        grades = [...grades, r];
      },
    );

    gradeHasBeenAdded = true;
    isLoadingAddGrades = false;
    update();
    return gradeHasBeenAdded;
  }

  /// Adds a new school to the server and updates the UI.
  ///
  /// The function takes the following parameters:
  ///
  /// - [schoolTypeId]: the id of the school type
  /// - [name]: the name of the school
  ///
  /// The function will show an error dialog if the response is a failure.
  ///
  /// The function will also update the UI to show that the school has been added
  /// to the server.
  Future<bool> addNewSchool({
    required int schoolTypeId,
    required String name,
  }) async {
    isLoadingAddSchool = true;
    update();
    bool schoolHasBeenAdded = false;
    ResponseHandler<SchoolResModel> responseHandler = ResponseHandler();
    Either<Failure, SchoolResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.schools,
      converter: SchoolResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "School_Type_ID": schoolTypeId,
        "Name": name,
      },
    );
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        schoolHasBeenAdded = false;
      },
      (r) {
        onInit();
      },
    );
    schoolHasBeenAdded = true;
    isLoadingAddGrades = false;
    update();
    return schoolHasBeenAdded;
  }

  /// Deletes all the data from the school box in Hive. This function is used to log out from the app and clear the school data from the local storage.
  Future<void> deleteFromSchoolBox() async {
    await Hive.box('School').clear();
  }

  /// Gets all the grades from the API and sets the
  /// [grades] with the grades returned by the API.
  ///
  /// It sets the [isLoadingGrades] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the grades page.
  ///
  /// The function returns a boolean indicating whether the grades were
  /// retrieved successfully.
  Future<bool> getGradesBySchoolId() async {
    isLoadingGrades = true;
    update();
    ResponseHandler<GradesResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: "${GradeLinks.gradesSchools}/$selectedSchoolId",
      converter: GradesResModel.fromJson,
      type: ReqTypeEnum.GET,
    );

    response.fold(
      (failure) {
        /// handel error
        MyAwesomeDialogue(
          title: 'Error',
          desc: "${failure.code} ::${failure.message}",
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
      },
      (result) {
// handel el response

        grades = result.data!;
        isLoadingGrades = false;
        update();
      },
    );
    isLoadingGrades = false;

    return true;
  }

  /// Gets all the school types from the API and sets the
  /// [options] with the school types returned by the API.
  ///
  /// It sets the [isLoadingAddGrades] variable to true and then to false
  /// depending on the response of the API.
  ///
  /// If the response is a failure, it shows an error dialog with the
  /// failure message.
  ///
  /// The function is used when the user navigates to the add new school page.
  ///
  /// The function returns a boolean indicating whether the school types were
  /// retrieved successfully.
  Future<bool> getSchoolType() async {
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
        List<ValueItem> items = r.data!
            .map((item) => ValueItem(label: item.name!, value: item.iD))
            .toList();
        options = items;
      },
    );
    isLoadingAddGrades = false;
    update();
    return true;
  }

  @override

  /// Called when the widget is initialized.
  ///
  /// Retrieves the school types from the API by calling [getSchoolType].
  ///
  void onInit() {
    super.onInit();
    getSchoolType();
  }

  /// Saves the school to the school box in the local storage and updates the UI
  /// accordingly.
  ///
  /// The function takes a [SchoolResModel] object as a parameter which contains
  /// the details of the school to be saved.
  ///
  /// The function first gets a new access token by making a GET request to the
  /// server with the school ID as a parameter.
  ///
  /// If the response is a failure, the function shows an error dialog with the
  /// failure message.
  ///
  /// If the response is a success, the function saves the new access token and
  /// the user profile to the local storage using the [TokenService] and
  /// [ProfileController] respectively.
  ///
  /// Then, it saves the school to the school box in the local storage using the
  /// [Hive] box.
  ///
  /// Finally, it waits for the data to be written to the local storage and
  /// flushes the box.
  ///
  /// The function is used when the user selects a school from the list of
  /// schools in the school selection page.
  Future<void> saveToSchoolBox(SchoolResModel currentSchool) async {
    TokenService tokenService = Get.find<TokenService>();
    ProfileController profileController = Get.find<ProfileController>();
    ResponseHandler<LoginResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: '${AuthLinks.getNewAccessToken}/${currentSchool.iD}',
      converter: LoginResModel.fromJson,
      type: ReqTypeEnum.GET,
    );
    response.fold(
      (l) => MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!),
      (r) {
        tokenService.saveTokenModelToHiveBox(TokenModel(
          aToken: r.accessToken!,
          rToken: r.refreshToken!,
        ));
        profileController.saveProfileToHiveBox(r.userProfile!);
      },
    );
    await Future.wait(
      [
        Hive.box('School').put('Id', currentSchool.iD),
        Hive.box('School').put('Name', currentSchool.name),
        Hive.box('School').put('SchoolTypeID', currentSchool.schoolTypeID),
        Hive.box('School')
            .put('SchoolTypeName', currentSchool.schoolType?.name),
      ],
    );
    await Hive.box('School').flush();
  }

  /// Sets the [selectedItem] to the given [ValueItem] and updates the UI by
  /// calling [update].
  ///
  /// The function is used when the user selects a school type from the dropdown
  /// in the add new school page.
  ///
  /// The function takes a [ValueItem] object as a parameter which contains the
  /// details of the selected school type. The function sets the [selectedItem]
  /// to the given [ValueItem] and updates the UI by calling [update].
  ///
  /// The function does not return any value.
  void setSelectedItem(ValueItem? item) {
    selectedItem = item;
    update();
  }

  /// Updates the [selectedSchoolIndex], [selectedSchoolId], and [selectedSchoolName]
  /// to the given index, id, and name respectively. Then, it calls [update] to
  /// update the UI.
  ///
  /// The function is used when the user selects a school from the list of schools
  /// in the school selection page.
  ///
  /// The function takes three parameters: an integer [index], an integer [id],
  /// and a string [name]. The function sets the [selectedSchoolIndex] to the
  /// given [index], the [selectedSchoolId] to the given [id], and the
  /// [selectedSchoolName] to the given [name]. Then, it calls [update] to update
  /// the UI.
  ///
  /// The function does not return any value.
  void updateSelectedSchool(int index, int id, String name) {
    selectedSchoolIndex = index;
    selectedSchoolId = id;
    selectedSchoolName = name;
    update();
  }
}
