import 'package:control_system/Data/Network/tools/dio_factry.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLogin = false.obs;
  RxBool isLoading = false.obs;
  List schools = [];

  Future login(String username, String password) async {
    isLoading.value = true;
    var dio = await DioFactory().getDio();
    try {
      var response = await dio.post(AuthLinks.login, data: {
        "userName": username,
        "password": password,
      });
      isLogin.value = true;
      debugPrint(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading.value = false;
    return true;
  }
}
