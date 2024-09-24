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
  bool isLoadingGetAllUsers = false;
  bool isLoadingGetUsersCreatedBy = false;
  bool isLoadingGetUsersInSchool = false;
  bool isLoadingEditUser = false;
  bool isLoadingEditUserRoles = false;
  bool isLoadingEditUserSchools = false;
  bool isLoadingGetRoles = false;
  bool isLoadingGetSchools = false;
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

  Future<void> getUserInSchool() async {
    debugPrint('get user in school');
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
        debugPrint('user in school error ${l.message}');
      },
      (r) {
        debugPrint('user in school ${r.users!.length}');
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
  void onInit() {
    getUserCreatedBy();
    getAllUsers();
    getUserInSchool();
    super.onInit();
  }
}
