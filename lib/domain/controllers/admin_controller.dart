import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/user/users_res/user_res_model.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Data/Network/response_handler.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class AdminController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nisIdController = TextEditingController();

  String? selectedRoleType;
  List<String> roleTypes = [
    'Control admin',
    'School Director',
    'Academic Dean',
    'Principal',
    'QR Reader',
    'Vice Principal'
  ];

  String? selectedDivision;

  List<String> schoolDivision = [
    "Elementary",
    "Middle",
    "High",
    "Key Stage 1",
    "Key Stage 2",
    "Key Stage 3",
    "IGCSE",
  ];

  bool isLoading = false;

  bool showPassord = true;

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
}
