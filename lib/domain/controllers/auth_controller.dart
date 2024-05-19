import 'package:control_system/Data/Models/user/login_response/login_response.dart';
import 'package:control_system/Data/Network/tools/dio_factory.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthController extends GetxController {
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
      isLogin.value = true;
      debugPrint(response.data);

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      if (loginResponse.userProfile != null) {
        Hive.box('Profile').put("ID", loginResponse.userProfile!.iD);
        Hive.box('Profile')
            .put("Full_Name", loginResponse.userProfile!.fullName);
        Hive.box('Profile')
            .put("User_Name", loginResponse.userProfile!.userName);
        // Hive.box('Profile').put("Created_By", loginResponse.userProfile!.createdBy);
        // Hive.box('Profile').put("Created_At", loginResponse.userProfile!.createdAt);
      }

      Hive.box('Token').put("aToken", response.data['accessToken']);
      Hive.box('Token').put("dToken", DateTime.now().toIso8601String());
      Hive.box('Token').put("rToken", response.data['refreshToken']);

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
    var refresh = Hive.box('Token').get('refresh');
    var dio = await DioFactory().getDio();
    var response =
        await dio.post(AuthLinks.refresh, data: {'refreshToken': refresh});

    /// if response is good we get new access token need to replace
    ///  update refresh token in local storage and profile controller
    Hive.box('Token').put("aToken", response.data['accessToken']);
    Hive.box('Token').put("dToken", DateTime.now().toIso8601String());
  }

  checkLogin() {
    /// check token in local storage and it's time
    ///
    /// then forword to current page
  }
  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }
}
