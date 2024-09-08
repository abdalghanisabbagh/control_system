import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../Data/Models/token/token_model.dart';
import '../../Data/Models/user/login_response/login_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import '../services/token_service.dart';
import 'profile_controller.dart';
import 'school_controller.dart';

class AuthController extends GetxController {
  PackageInfo? packageInfo;

  bool isLoading = false;
  bool isLogin = false;
  ProfileController profileController = Get.find<ProfileController>();
  bool showPass = true;
  TokenService tokenService = Get.find<TokenService>();

  Future<bool> login(String username, String password) async {
    isLoading = true;
    update(['login_btn']);
    ResponseHandler<LoginResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: AuthLinks.login,
      converter: LoginResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "userName": username,
        "password": password,
      },
    );

    response.fold(
      (l) => MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!),
      (r) {
        tokenService.saveTokenModelToHiveBox(
          TokenModel(
            aToken: r.accessToken!,
            rToken: r.refreshToken!,
          ),
        );

        profileController.saveProfileToHiveBox(r.userProfile!);

        isLogin = true;
      },
    );

    isLoading = false;
    update();
    return isLogin;
  }

  @override
  void onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    isLogin = false;
    update();
    super.onInit();
  }

  setShowPass() {
    showPass = !showPass;
    update(['pass_icon']);
  }

  Future<void> signOut() async {
    await Future.wait([
      tokenService.deleteTokenModelFromHiveBox(),
      profileController.deleteProfileFromHiveBox(),
      SchoolController().deleteFromSchoolBox(),
      Hive.box('ControlMission').clear(),
      Hive.box('ExamRoom').clear(),
      Hive.box('SideMenueIndex').clear(),
    ]);
    ResponseHandler<void>().getResponse(
      path: AuthLinks.logout,
      converter: (_) {},
      type: ReqTypeEnum.DELETE,
      body: {
        'refreshToken': tokenService.tokenModel?.rToken,
      },
    );
    isLogin = false;
  }
}
