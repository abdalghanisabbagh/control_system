import 'package:control_system/Data/Models/User/login_response/login_response.dart';
import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AuthMiddleWare extends GetMiddleware {
  LoginResponse? loginObject;
  String? expireTime;
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
      String? atoken = Hive.box('Token').get('token');
      String? rtoken = Hive.box('Token').get('refresh');
      expireTime = Hive.box('Token').get("time");
      if (atoken != null && rtoken != null) {
        loginObject = LoginResponse(
          accessToken: atoken,
          refreshToken: rtoken,
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
