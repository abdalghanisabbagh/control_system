import 'package:control_system/Data/Models/token/token_model.dart';
import 'package:control_system/Data/Models/user/login_response/login_response.dart';
import 'package:control_system/Data/Network/tools/dio_factory.dart';
import 'package:control_system/Data/handlers/implementation/login_response_implemantation_handler.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/domain/services/token_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get/get.dart';

import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/failure_model.dart';

class AuthController extends GetxController {
  TokenService tokenService = Get.find<TokenService>();

  RxBool isLogin = false.obs;
  bool showPass = true;

  RxBool isLoading = false.obs;
  List schools = [];
  setShowPass() {
    showPass = !showPass;
    update();
  }

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    var dio = await DioFactory().getDio();
    try {
      var response = await dio.post(AuthLinks.login, data: {
        "userName": username,
        "password": password,
      });

      ResponseHandler<LoginResponseImplementationHandler> responseHandler =
          ResponseHandler<LoginResponseImplementationHandler>();
      Either<Failure, LoginResponseImplementationHandler> result =
          responseHandler.getResponse(response.data['data']);
      if (result.isRight()) {
        LoginResponseImplementationHandler loginResponse = result.foldRight(
            LoginResponseImplementationHandler(), (r, previous) => previous);
        LoginResponse data = loginResponse.fromJson(response.data);
        TokenModel tokenModel = TokenModel(
          aToken: data.accessToken!,
          rToken: data.refreshToken!,
          dToken: DateTime.now().toIso8601String(),
        );
        tokenService.saveTokenModelToHiveBox(tokenModel);
      } else {
        isLoading.value = false;

        throw result.leftMap((l) => l);
      }

      isLogin.value = true;
      // debugPrint(response.data);

      // LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      // if (loginResponse.userProfile != null) {
      //   UserProfile userProfile =
      //       UserProfile.fromJson(response.data['userProfile']);
      //   Hive.box('Profile').put("CachedUserProfile", userProfile.toJson());

      // Hive.box('Profile').put("ID", loginResponse.userProfile!.iD);
      // Hive.box('Profile')
      //     .put("Full_Name", loginResponse.userProfile!.fullName);
      // Hive.box('Profile')
      //     .put("User_Name", loginResponse.userProfile!.userName);
      // Hive.box('Profile').put("Created_By", loginResponse.userProfile!.createdBy);
      // Hive.box('Profile').put("Created_At", loginResponse.userProfile!.createdAt);
      // }

      // TokenModel tokenModel = TokenModel(
      //   aToken: response.data['accessToken'],
      //   rToken: response.data['refreshToken'],
      //   dToken: DateTime.now().toIso8601String(),
      // );
      // tokenService.saveTokenModelToHiveBox(tokenModel);

      return true;

      //// TODO: save all user Data
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading.value = false;
    return false;
  }

  Future refreshToken() async {
    ///TODO: refresh token
    if (tokenService.tokenModel == null) {
      return;
    }
    String refresh = tokenService.tokenModel!.rToken;
    var dio = await DioFactory().getDio();
    var response =
        await dio.post(AuthLinks.refresh, data: {'refreshToken': refresh});

    /// if response is good we get new access token need to replace
    ///  update refresh token in local storage and profile controller
    TokenModel tokenModel = TokenModel.fromJson(response.data);
    tokenService.saveTokenModelToHiveBox(tokenModel);
  }

  checkLogin() {
    /// check token in local storage and it's time
    ///
    /// then forword to current page

    if (tokenService.tokenModel != null) {
      if (DateTime.tryParse(tokenService.tokenModel!.dToken)!
              .difference(DateTime.now())
              .inMinutes >
          55) {
        refreshToken();
      }
      isLogin.value = true;
    }
  }

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }
}
