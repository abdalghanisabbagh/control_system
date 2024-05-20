import 'package:control_system/Data/Models/token/token_model.dart';
import 'package:control_system/Data/Models/user/login_response/user_profile.dart';
import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:control_system/domain/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Models/user/login_response/login_response.dart';
import 'profile_controller.dart';

class AuthMiddleWare extends GetMiddleware {
  LoginResponse? loginObject;
  String? expireTime;
  String? aToken;
  String? rToken;
  @override
  int? get priority => 1;

  bool isAuthenticated = false;

  @override
  RouteSettings? redirect(String? route) {
    checktoken();
    if (!isAuthenticated) return const RouteSettings(name: '/login');
    return null;
    // return super.redirect(route);
  }

  checktoken() async {
    if (loginObject == null) {
      TokenModel? tokenModel = Get.find<TokenService>().tokenModel;
      UserProfile? userProfile =
          Get.find<ProfileController>().getProfileFromHiveBox();
      aToken = tokenModel?.aToken;
      expireTime = tokenModel?.dToken;
      if (aToken != null && rToken != null && userProfile != null) {
        loginObject = LoginResponse(
          accessToken: aToken,
          refreshToken: rToken,
          userProfile: userProfile,
        );

        return isAuthenticated = await validateor();
      } else {
        return isAuthenticated = false;
      }
    } else {
      /// valid time
      return isAuthenticated = await validateor();
    }
  }

  Future<bool> validateor() async {
    if (expireTime != null) {
      DateTime expireDate = DateTime.parse(expireTime!);
      if (DateTime.now().difference(expireDate).inMinutes > 50) {
        // refresh Token
        Get.lazyPut(() => AuthController());
        AuthController authController = Get.find();
        String? newAccessToken = await authController.refreshToken();
        return newAccessToken != null
            ? isAuthenticated = true
            : isAuthenticated = false;
        // return isAuthenticated = false;
      } else {
        return isAuthenticated = true;
      }
    } else {
      return false;
    }
  }
}
