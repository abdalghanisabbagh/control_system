import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/profile_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Models/proctor/proctor_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';

class ProctorController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nisIdController = TextEditingController();

  bool showPassord = true;

  bool isLoading = false;

  Future<bool> createNewProctor() async {
    bool createdSuccessfully = false;
    isLoading = true;
    update();
    ResponseHandler<ProctorResModel> responseHandler = ResponseHandler();
    Either<Failure, ProctorResModel> response =
        await responseHandler.getResponse(
      path: ProctorsLinks.proctor,
      converter: ProctorResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "Full_Name": fullNameController.text,
        "User_Name": usernameController.text,
        "Password": passwordController.text,
        "Created_By": Get.find<ProfileController>().cachedUserProfile?.iD,
      },
    );
    isLoading = false;
    update();
    response.fold(
      (l) {
        MyAwesomeDialogue(
          title: 'Error',
          desc: l.message,
          dialogType: DialogType.error,
        ).showDialogue(Get.key.currentContext!);
        createdSuccessfully = false;
      },
      (r) {
        createdSuccessfully = true;
      },
    );
    return createdSuccessfully;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nisIdController.dispose();
    super.onClose();
  }
}
