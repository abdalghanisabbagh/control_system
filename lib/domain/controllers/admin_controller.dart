import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/school/school_response/schools_res_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/school/school_response/school_res_model.dart';
import '../../Data/Models/user/roles/role_res_model.dart';
import '../../Data/Models/user/roles/roleres_model.dart';
import '../../Data/Models/user/users_res/user_res_model.dart';
import '../../Data/Models/user/users_res/users_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import '../../presentation/resource_manager/constants/app_constatnts.dart';

class AdminController extends GetxController {
  List<UserResModel> allUsersList = <UserResModel>[];

  bool isLoading = false;
  bool isLoadingGetAllUsers = false;
  bool isLoadingGetUsersCreatedBy = false;
  bool isLoadingGetUsersInSchool = false;
  bool isLodingEditUser = false;
  bool isLodingEditUserRoles = false;
  bool isLodingEditUserSchools = false;
  bool isLodingGetRoles = false;
  bool isloadingGetSchools = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController nisIdController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  List<RoleResModel> rolesList = <RoleResModel>[];
  List<int> selectedRolesID = <int>[];
  List<SchoolResModel> schoolsList = <SchoolResModel>[];
  List<int> selectedSchoolID = <int>[];

  String? selectedDivision;
  String? selectedRoleType;
  bool showNewPassword = true;
  bool showOldPassord = true;
  List<UserResModel> userCreatedList = <UserResModel>[];
  List<UserResModel> userInSchoolList = <UserResModel>[];
  final TextEditingController usernameController = TextEditingController();

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

  Future<bool> editUser(Map<String, dynamic> data, int id) async {
    isLodingEditUser = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
        path: "${UserLinks.users}/$id",
        converter: UserResModel.fromJson,
        type: ReqTypeEnum.PATCH,
        body: data);

    isLodingEditUser = false;
    update();

    return response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        isLodingEditUser = false;
        update();
        return false;
      },
      (r) {
        fullNameController.clear();
        usernameController.clear();
        oldPasswordController.clear();
        newPasswordController.clear();
        nisIdController.clear();
        isLodingEditUser = false;
        onInit();
        update();
        return true;
      },
    );
  }

  Future<bool> editUserRoles(int roleId) async {
    isLodingEditUserRoles = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
      path: "${UserLinks.userEditRoles}/$roleId",
      converter: UserResModel.fromJson,
      type: ReqTypeEnum.PATCH,
      body: selectedRolesID.map((e) => {'Roles_ID': e}).toList(),
    );

    isLodingEditUserRoles = false;
    update();

    return response.fold(
      (l) {
        isLodingEditUserRoles = false;

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
        isLodingEditUserRoles = false;
        update();

        return true;
      },
    );
  }

  Future<bool> editUserSchool(int userId) async {
    isLodingEditUserSchools = true;
    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
      path: "${UserLinks.userEditUserHasSchools}/$userId",
      converter: UserResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: selectedSchoolID,
    );

    isLodingEditUserSchools = false;
    update();

    return response.fold(
      (l) {
        isLodingEditUserSchools = false;

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
        isLodingEditUserSchools = false;
        update();

        return true;
      },
    );
  }

  Future getAllRoles({required UserResModel userResModel}) async {
    isLodingGetRoles = true;
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

    isLodingGetRoles = false;
    update();
  }

  Future getAllSchool({required UserResModel userResModel}) async {
    isloadingGetSchools = true;
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

    isloadingGetSchools = false;
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

  @override
  void onInit() {
    getUserCreatedBy();
    getAllUsers();
    getUserInSchool();
    super.onInit();
  }
}
