import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../Data/Models/token/token_model.dart';
import '../../Data/Models/user/login_response/login_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialogue.dart';
import '../services/token_service.dart';
import 'profile_controller.dart';
import 'school_controller.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  bool isLogin = false;
  PackageInfo? packageInfo;
  final passwordController = TextEditingController();
  ProfileController profileController = Get.find<ProfileController>();
  bool showPass = true;
  TokenService tokenService = Get.find<TokenService>();
  final usernameController = TextEditingController();

  /// Checks whether the user is still logged in by comparing the difference
  /// between the current time and the time when the token was created to 17 hours.
  /// If the difference is greater than 17 hours, the user is considered logged out,
  /// else the user is considered logged in.
  ///
  /// The function sets the [isLogin] variable to true or false based on the
  /// comparison and calls [update] to notify the UI of the change.
  Future<void> checkLoginStatus() async {
    if (tokenService.tokenModel == null) {
      isLogin = false;
    } else {
      isLogin = DateTime.now().difference(tokenService.tokenModel!.createdAt!) >
              const Duration(hours: 17)
          ? false
          : true;
    }
    update();
    return;
  }

  /// Logs in the user to the server and saves the token to the local storage
  /// using the [TokenService].
  ///
  /// The function takes the username and password from the text fields
  /// [usernameController] and [passwordController] respectively.
  ///
  /// If the response is a failure, the function shows an error dialog with the
  /// failure message.
  ///
  /// If the response is successful, the function saves the token and the user
  /// profile to the local storage using the [TokenService] and
  /// [ProfileController] respectively.
  ///
  /// The function returns a boolean indicating whether the login was successful.
  ///
  /// The function is used in the login screen.
  Future<bool> login() async {
    isLoading = true;
    update(['login_btn']);
    ResponseHandler<LoginResModel> responseHandler = ResponseHandler();

    var response = await responseHandler.getResponse(
      path: AuthLinks.login,
      converter: LoginResModel.fromJson,
      type: ReqTypeEnum.POST,
      body: {
        "userName": usernameController.text,
        "password": passwordController.text,
      },
    );

    response.fold(
      (l) => MyAwesomeDialogue(
        title: 'Error',
        desc: l.message,
        dialogType: DialogType.error,
      ).showDialogue(Get.key.currentContext!),
      (r) async {
        tokenService.saveTokenModelToHiveBox(
          TokenModel(
            aToken: r.accessToken!,
            rToken: r.refreshToken!,
          ),
        );

        profileController.saveProfileToHiveBox(r.userProfile!);
        isLogin = true;
        await Hive.box('Token').put('isLogin', true);
      },
    );

    isLoading = false;
    update();
    return isLogin;
  }

  @override

  /// Called when the controller is closed. Sets [isLogin] to false and
  /// calls [update] to update the UI. Also calls [super.onClose] to
  /// perform any other necessary cleanup.
  void onClose() async {
    isLogin = false;
    update();
    super.onClose();
  }

  @override

  /// Called when the controller is initialized. Checks the login status
  /// using [checkLoginStatus], gets the package information using
  /// [PackageInfo.fromPlatform], updates the UI using [update], and calls
  /// [super.onInit].
  void onInit() async {
    await checkLoginStatus();
    packageInfo = await PackageInfo.fromPlatform();
    update();
    super.onInit();
  }

  /// Toggles the [showPass] variable which determines whether the password
  /// should be shown or hidden in the login form. Calls [update] with the
  /// argument `['pass_icon']` to update the UI.
  void setShowPass() {
    showPass = !showPass;
    update(['pass_icon']);
  }

  /// Signs the user out of the application. Deletes the token model from
  /// the Hive box, deletes the profile from the Hive box, deletes the
  /// school from the Hive box, clears the control mission box, clears the
  /// exam room box, clears the side menu index box, and sends a DELETE
  /// request to the logout endpoint with the refresh token. Sets [isLogin]
  /// to false and calls [update] to update the UI.
  Future<void> signOut() async {
    isLogin = false;
    await Future.wait([
      tokenService.deleteTokenModelFromHiveBox(),
      profileController.deleteProfileFromHiveBox(),
      SchoolController().deleteFromSchoolBox(),
      Hive.box('ControlMission').clear(),
      Hive.box('ExamRoom').clear(),
      Hive.box('SideMenuIndex').clear(),
    ]);
    ResponseHandler<void>().getResponse(
      path: AuthLinks.logout,
      converter: (_) {},
      type: ReqTypeEnum.DELETE,
      body: {
        'refreshToken': tokenService.tokenModel?.rToken,
      },
    );
    update();
  }
}
