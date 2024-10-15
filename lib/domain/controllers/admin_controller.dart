import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/school/school_response/school_res_model.dart';
import '../../Data/Models/school/school_response/schools_res_model.dart';
import '../../Data/Models/user/roles/role_res_model.dart';
import '../../Data/Models/user/roles/roles_res_model.dart';
import '../../Data/Models/user/users_res/user_res_model.dart';
import '../../Data/Models/user/users_res/users_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import '../../presentation/resource_manager/constants/app_constants.dart';

class AdminController extends GetxController {
  List<UserResModel> allUsersList = <UserResModel>[];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  bool isLoading = false;
  bool isLoadingEditUser = false;
  bool isLoadingEditUserRoles = false;
  bool isLoadingEditUserSchools = false;
  bool isLoadingGetAllUsers = false;
  bool isLoadingGetRoles = false;
  bool isLoadingGetSchools = false;
  bool isLoadingGetUsersCreatedBy = false;
  bool isLoadingGetUsersInSchool = false;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController nisIdController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  List<RoleResModel> rolesList = <RoleResModel>[];
  List<SchoolResModel> schoolsList = <SchoolResModel>[];
  String? selectedDivision;
  String? selectedRoleType;
  List<int> selectedRolesID = <int>[];
  List<int> selectedSchoolID = <int>[];
  bool showNewPassword = true;
  bool showOldPassword = true;
  List<UserResModel> userCreatedList = <UserResModel>[];
  List<UserResModel> userInSchoolList = <UserResModel>[];
  final TextEditingController usernameController = TextEditingController();

  /// A function that activates a user with the given [userId] and returns a boolean
  /// indicating whether the user was activated successfully.
  ///
  /// The function takes one parameter [userId] which is the ID of the user to be
  /// activated.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will call [onInit] to refresh the
  /// UI and return true. If the response is a failure, the function will return
  /// false.
  Future<bool> activateUser({required int userId}) async {
    bool activateUser = false;
    update();
    ResponseHandler<void> responseHandler = ResponseHandler<void>();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${UserLinks.activateUser}/$userId',
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
        activateUser = false;
      },
      (r) {
        activateUser = true;
        onInit();
      },
    );
    update();
    return activateUser;
  }

  /// A function that adds a new user to the server and returns a boolean
  /// indicating whether the user was added successfully.
  ///
  /// The function takes the following parameters:
  ///
  /// - [School_Id]: The ID of the school to which the user will be added.
  /// - [Full_Name]: The full name of the user to be added.
  /// - [User_Name]: The username of the user to be added.
  /// - [Password]: The password of the user to be added.
  /// - [IsFloorManager]: The role of the user to be added.
  /// - [Type]: The type of the user to be added.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will return true and clear the
  /// fields of the form. If the response is a failure, the function will return
  /// false.
  Future<bool> addNewUser() async {
    isLoading = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
      path: UserLinks.users,
      converter: UserResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "School_Id": Hive.box('School').get('Id'),
        "Full_Name": fullNameController.text,
        "User_Name": usernameController.text,
        "Password": oldPasswordController.text,
        "IsFloorManager": selectedDivision,
        "Type": AppConstants.roleTypes.indexOf(selectedRoleType!),
      },
    );

    isLoading = false;
    update();

    return response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        return false;
      },
      (r) {
        fullNameController.clear();
        usernameController.clear();
        oldPasswordController.clear();
        newPasswordController.clear();
        nisIdController.clear();
        return true;
      },
    );
  }

  /// Adds a reader user to the database and returns a boolean indicating
  /// whether the add was successful.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show a loading indicator while the request is being
  /// processed.
  ///
  /// If the response is a failure, the function will show an error dialog with
  /// the failure message.
  ///
  /// If the response is successful, the function will clear the UI of any input
  /// fields and notify the listeners of the [includedStudentsStateManager] to
  /// update the UI.
  Future<bool> addReaderUser() async {
    isLoading = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
      path: UserLinks.createUsersReader,
      converter: UserResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "School_Id": Hive.box('School').get('Id'),
        "Full_Name": fullNameController.text,
        "User_Name": usernameController.text,
        "Password": oldPasswordController.text,
        "IsFloorManager": selectedDivision,
        "Type": AppConstants.roleTypes.indexOf('Reader'),
      },
    );

    isLoading = false;
    update();

    return response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        return false;
      },
      (r) {
        fullNameController.clear();
        usernameController.clear();
        oldPasswordController.clear();
        newPasswordController.clear();
        nisIdController.clear();
        return true;
      },
    );
  }

  /// A function that deactivates a user with the given [userId] and returns a boolean
  /// indicating whether the user was deactivated successfully.
  ///
  /// The function takes one parameter [userId] which is the ID of the user to be deactivated.
  ///
  /// The function will show an error dialog with the failure message if the response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the request is being processed.
  ///
  /// If the response is successful, the function will call [onInit] to refresh the UI and return true. If the response is a failure, the function will return false.
  Future<bool> deactivateUser({required int userId}) async {
    bool deactivateUser = false;
    update();
    ResponseHandler<void> responseHandler = ResponseHandler<void>();
    Either<Failure, void> response = await responseHandler.getResponse(
      path: '${UserLinks.deactivateUser}/$userId',
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
        deactivateUser = false;
      },
      (r) {
        deactivateUser = true;
        onInit();
      },
    );
    update();
    return deactivateUser;
  }

  /// A function that edits a user with the given [id] and [data] and returns a boolean
  /// indicating whether the user was edited successfully.
  ///
  /// The function takes two parameters [id] and [data] which are the ID and data of the
  /// user to be edited.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will call [onInit] to refresh the UI
  /// and return true. If the response is a failure, the function will return false.
  Future<bool> editUser(Map<String, dynamic> data, int id) async {
    isLoadingEditUser = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
        path: "${UserLinks.users}/$id",
        converter: UserResModel.fromJson,
        type: ReqTypeEnum.PATCH,
        body: data);

    isLoadingEditUser = false;
    update();

    return response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLoadingEditUser = false;
        update();
        return false;
      },
      (r) {
        fullNameController.clear();
        usernameController.clear();
        oldPasswordController.clear();
        newPasswordController.clear();
        nisIdController.clear();
        isLoadingEditUser = false;
        onInit();
        update();
        return true;
      },
    );
  }

  /// A function that edits the roles of the user with the given [roleId] and the
  /// roles in [selectedRolesID] and returns a boolean indicating whether the
  /// roles were edited successfully.
  ///
  /// The function takes one parameter [roleId] which is the ID of the user whose
  /// roles are to be edited.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will call [onInit] to refresh the
  /// UI and return true. If the response is a failure, the function will return
  /// false.
  Future<bool> editUserRoles(int roleId) async {
    isLoadingEditUserRoles = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
      path: "${UserLinks.userEditRoles}/$roleId",
      converter: UserResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: selectedRolesID.map((e) => {'Roles_ID': e}).toList(),
    );

    isLoadingEditUserRoles = false;
    update();

    return response.fold(
      (l) {
        isLoadingEditUserRoles = false;

        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        update();
        return false;
      },
      (r) {
        onInit();
        isLoadingEditUserRoles = false;
        update();

        return true;
      },
    );
  }

  /// A function that edits the schools of the user with the given [userId] and the
  /// schools in [selectedSchoolID] and returns a boolean indicating whether the
  /// schools were edited successfully.
  ///
  /// The function takes one parameter [userId] which is the ID of the user whose
  /// schools are to be edited.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will call [onInit] to refresh the
  /// UI and return true. If the response is a failure, the function will return
  /// false.
  Future<bool> editUserSchool(int userId) async {
    isLoadingEditUserSchools = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
      path: "${UserLinks.userEditUserHasSchools}/$userId",
      converter: UserResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: selectedSchoolID,
    );

    isLoadingEditUserSchools = false;
    update();

    return response.fold(
      (l) {
        isLoadingEditUserSchools = false;

        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        update();
        return false;
      },
      (r) {
        onInit();
        isLoadingEditUserSchools = false;
        update();

        return true;
      },
    );
  }

  /// Gets all the roles from the server and sets the [rolesList] and [selectedRolesID]
  /// with the roles returned by the server.
  ///
  /// The function takes a [UserResModel] as a parameter which is the user data
  /// of the user whose roles are to be edited.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will set the [selectedRolesID]
  /// with the roles of the user and the [rolesList] with all the roles returned
  /// by the server.
  Future getAllRoles({required UserResModel userResModel}) async {
    isLoadingGetRoles = true;
    update();
    ResponseHandler<RolesResModel> responseHandler = ResponseHandler();
    Either<Failure, RolesResModel> response = await responseHandler.getResponse(
      path: UserRolesSystemsLink.userRolesSystems,
      converter: RolesResModel.fromJson,
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
        selectedRolesID.clear();
        rolesList = r.data!;
        selectedRolesID.addAll(userResModel.userHasRoles!.roleID ?? []);
      },
    );

    isLoadingGetRoles = false;
    update();
  }

  /// Gets all schools from the server and updates the UI.
  ///
  /// The function takes a [UserResModel] as a parameter which is the user data
  /// of the user whose schools are to be edited.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will set the [selectedSchoolID]
  /// with the schools of the user and the [schoolsList] with all the schools
  /// returned by the server.
  Future getAllSchool({required UserResModel userResModel}) async {
    isLoadingGetSchools = true;
    update();
    ResponseHandler<SchoolsResModel> responseHandler = ResponseHandler();
    Either<Failure, SchoolsResModel> response =
        await responseHandler.getResponse(
      path: SchoolsLinks.getAllSchools,
      converter: SchoolsResModel.fromJson,
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
        selectedSchoolID.clear();
        schoolsList = r.data!;
        selectedSchoolID
            .addAll(userResModel.userHasSchoolResModel!.schoolId ?? []);
      },
    );

    isLoadingGetSchools = false;
    update();
  }

  /// Gets all the users from the server and sets the [allUsersList] with the
  /// users returned by the server.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will set the [allUsersList] with
  /// all the users returned by the server and update the UI with the users.
  Future<void> getAllUsers() async {
    isLoadingGetAllUsers = true;
    update();

    ResponseHandler<UsersResModel> responseHandler = ResponseHandler();
    Either<Failure, UsersResModel> response = await responseHandler.getResponse(
      path: UserLinks.users,
      converter: UsersResModel.fromJson,
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
        allUsersList = r.users!.map((user) {
          user.roleType = AppConstants.roleTypes[user.type ?? 0];
          return user;
        }).toList();
      },
    );

    isLoadingGetAllUsers = false;
    update();
  }

  /// Gets all the users created by the user from the server and sets the
  /// [userCreatedList] with the users returned by the server.
  ///
  /// The function takes no parameters.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will set the [userCreatedList]
  /// with all the users returned by the server and update the UI with the users.
  Future<void> getUserCreatedBy() async {
    isLoadingGetUsersCreatedBy = true;
    update();

    ResponseHandler<UsersResModel> responseHandler = ResponseHandler();
    Either<Failure, UsersResModel> response = await responseHandler.getResponse(
      path: UserLinks.getUsersByCreated,
      converter: UsersResModel.fromJson,
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
        userCreatedList = r.users!.map((user) {
          user.roleType = AppConstants.roleTypes[user.type ?? 0];
          return user;
        }).toList();
      },
    );

    isLoadingGetUsersCreatedBy = false;
    update();
  }

  /// Gets all users in the school and updates the UI.
  ///
  /// The function will show an error dialog with the failure message if the
  /// response is a failure.
  ///
  /// The function will also update the UI to show a loading indicator while the
  /// request is being processed.
  ///
  /// If the response is successful, the function will set the [userInSchoolList]
  /// with all the users returned by the server and update the UI with the users.
  Future<void> getUserInSchool() async {
    isLoadingGetUsersInSchool = true;
    update();

    ResponseHandler<UsersResModel> responseHandler = ResponseHandler();
    Either<Failure, UsersResModel> response = await responseHandler.getResponse(
      path: UserLinks.usersInSchool,
      converter: UsersResModel.fromJson,
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
        userInSchoolList = r.users!.map((user) {
          user.roleType = AppConstants.roleTypes[user.type ?? 0];
          return user;
        }).toList();
      },
    );
    isLoadingGetUsersInSchool = false;
    update();
  }

  @override

  /// This function is called when the widget is initialized.
  ///
  /// It calls the following functions to get the users created by the current
  /// user, all users in the school and all users in the school.
  ///
  /// It then calls the onInit function of the super class.
  void onInit() {
    getUserCreatedBy();
    getAllUsers();
    getUserInSchool();
    super.onInit();
  }
}
