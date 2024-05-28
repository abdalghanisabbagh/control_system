import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/token/token_model.dart';
import 'package:control_system/Data/Models/user/login_response/login_res_model.dart';
import 'package:control_system/Data/Network/response_handler.dart';
import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/domain/controllers/profile_controller.dart';
import 'package:control_system/domain/services/token_service.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;

import '../../Data/Network/tools/app_error_handler.dart';
import '../../Data/enums/req_type_enum.dart';

class AuthController extends GetxController {
  TokenService tokenService = Get.find<TokenService>();
  ProfileController profileController = Get.find<ProfileController>();

  RxBool isLogin = false.obs;
  RxBool showPass = true.obs;

  RxBool isLoading = false.obs;
  List schools = [];
  setShowPass() {
    showPass.value = !showPass.value;
  }

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
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
            ), (r) {
      tokenService.saveTokenModelToHiveBox(TokenModel(
        aToken: r.accessToken!,
        rToken: r.refreshToken!,
        dToken: DateTime.now().toIso8601String(),
      ));
      profileController.saveProfileToHiveBox(r.userProfile!);
      isLogin.value = true;
      isLoading.value = false;
    });

    isLoading.value = false;
    return isLogin.value;
  }

  Future<String?> refreshToken() async {
    ///TODO: refresh token
    if (tokenService.tokenModel == null) {
      return null;
    }
    String refresh = tokenService.tokenModel!.rToken;
    var dio = Dio(
      BaseOptions(
        baseUrl: AppLinks.baseUrl,
      ),
    );

    // DioException Error in the networklayer can not be resolved by the library
    var response = await dio
        .post(AuthLinks.refresh, data: {'refreshToken': refresh}).onError(
      (error, stackTrace) {
        ErrorHandler.handle(error);
        return Response(requestOptions: RequestOptions(path: 'error'));
      },
    );
    debugPrint('refresh token:${response.data}');
    // if response is good we get new access token need to replace
    //  update refresh token in local storage and profile controller
    return null;
  }

  checkLogin() {
    /// check token in local storage and it's time
    ///
    /// then forword to current page

    // debugPrint(DateTime.now()
    //     .difference(DateTime.tryParse(tokenService.tokenModel!.dToken)!)
    //     .toString());

    if (tokenService.tokenModel != null) {
      if (DateTime.now()
              .difference(DateTime.tryParse(tokenService.tokenModel!.dToken)!)
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
