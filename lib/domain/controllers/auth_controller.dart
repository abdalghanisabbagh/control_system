import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../Data/Models/token/token_model.dart';
import '../../Data/Models/user/login_response/login_res_model.dart';
import '../../Data/Network/response_handler.dart';
import '../../Data/Network/tools/app_error_handler.dart';
import '../../Data/enums/req_type_enum.dart';
import '../../app/configurations/app_links.dart';
import '../../presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import '../services/token_service.dart';
import 'profile_controller.dart';
import 'school_controller.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  bool isLogin = false;
  ProfileController profileController = Get.find<ProfileController>();
  bool showPass = true;
  TokenService tokenService = Get.find<TokenService>();

  checkLogin() {
    /// check token in local storage and it's time
    ///
    /// then forword to current page

    if (tokenService.tokenModel != null) {
      if (DateTime.now()
              .difference(DateTime.tryParse(tokenService.tokenModel!.dToken)!)
              .inMinutes >
          55) {
        refreshToken();
      }
      isLogin = true;
    }
  }

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
            ).showDialogue(Get.key.currentContext!), (r) {
      tokenService.saveTokenModelToHiveBox(TokenModel(
        aToken: r.accessToken!,
        rToken: r.refreshToken!,
        dToken: DateTime.now().toIso8601String(),
      ));
      profileController.saveProfileToHiveBox(r.userProfile!);
      isLogin = true;
    });

    isLoading = false;
    update();
    return isLogin;
  }

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  Future<String?> refreshToken() async {
    if (tokenService.tokenModel == null) {
      return null;
    }
    String refresh = tokenService.tokenModel!.rToken;

    var dio = Dio(
      BaseOptions(
        baseUrl: AppLinks.baseUrlProd,
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
    // if response is good we get new access token need to replace
    //  update refresh token in local storage and profile controller

    TokenModel tokenModel = TokenModel(
      aToken: response.data['data'],
      rToken: tokenService.tokenModel!.rToken,
      dToken: DateTime.now().toIso8601String(),
    );
    tokenService.saveNewAccessToken(tokenModel);
    return response.data['data'];
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
    ]);
    isLogin = false;
  }
}
