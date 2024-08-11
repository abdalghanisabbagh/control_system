import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Models/user/users_res/user_res_model.dart';
import '../../Data/Models/user/users_res/users_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class AdminController extends GetxController {
  bool isLoadingGetUsers = false;

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  bool isLoading = false;
  final TextEditingController nisIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<UserResModel> usersList = <UserResModel>[];

  List<String> roleTypes = [
    'Control admin',
    'School Director',
    'Academic Dean',
    'Principal',
    'QR Reader',
    'Vice Principal'
  ];

  List<String> schoolDivision = [
    "Elementary",
    "Middle",
    "High",
    "Key Stage 1",
    "Key Stage 2",
    "Key Stage 3",
    "IGCSE",
  ];

  String? selectedDivision;
  String? selectedRoleType;
  bool showPassord = true;
  final TextEditingController usernameController = TextEditingController();

  Future<bool> addNewUser() async {
    isLoading = true;
    bool success = false;

    update();

    final response = await ResponseHandler<UserResModel>().getResponse(
      path: AuthLinks.user,
      converter: UserResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "School_Id": Hive.box('School').get('Id'),
        "Full_Name": fullNameController.text,
        "User_Name": usernameController.text,
        "Password": passwordController.text,
        "IsFloorManager": selectedRoleType == 'Principal' ||
                selectedRoleType == 'Vice Principal'
            ? selectedDivision
            : null,
        "Type": roleTypes.indexOf(selectedRoleType!),
      },
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
        success = true;
        fullNameController.clear();
        usernameController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        nisIdController.clear();
      },
    );

    isLoading = false;

    update();

    return success;
  }

  Future<void> getUser() async {
    isLoadingGetUsers = true;
    update();

    ResponseHandler<UsersResModel> responseHandler = ResponseHandler();
    Either<Failure, UsersResModel> response = await responseHandler.getResponse(
      path: AuthLinks.user,
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
        usersList = r.users!.map((user) {
          user.roleType =
              getRoleType(user.type!); 
          return user;
        }).toList();
      },
    );

    isLoadingGetUsers = false;
    update();
  }

  String getRoleType(int type) {
    if (type < 0 || type >= roleTypes.length) {
      return 'Unknown'; // Return a default value if the type is out of range
    }
    return roleTypes[type];
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
