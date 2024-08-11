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
import '../../presentation/resource_manager/constants/app_constatnts.dart';

class AdminController extends GetxController {
  bool isLoadingGetUsers = false;
  bool isLoading = false;
  String? selectedDivision;
  String? selectedRoleType;
  bool showPassord = true;

  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nisIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<UserResModel> usersList = <UserResModel>[];

  Future<bool> addNewUser() async {
    isLoading = true;
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
        "IsFloorManager": selectedRoleType == 'Principal' || selectedRoleType == 'Vice Principal'
            ? selectedDivision
            : null,
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
        passwordController.clear();
        confirmPasswordController.clear();
        nisIdController.clear();
        return true;
      },
    );
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
          user.roleType = AppConstants.roleTypes[user.type ?? 0];
          return user;
        }).toList();
      },
    );

    isLoadingGetUsers = false;
    update();
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
