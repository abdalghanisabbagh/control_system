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
import 'index.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  bool isLogin = false;
  ProfileController profileController = Get.find<ProfileController>();
  RxBool showPass = true.obs;
  TokenService tokenService = Get.find<TokenService>();

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  setShowPass() {
    showPass.value = !showPass.value;
  }

  Future<bool> login(String username, String password) async {
    isLoading = true;
    update();
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
      isLogin = true;
    });

    isLoading = false;
    update();
    return isLogin;
  }

  Future<String?> refreshToken() async {
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
    // if response is good we get new access token need to replace
    //  update refresh token in local storage and profile controller

    tokenService.saveNewAccessToken(response.data['data']);
    return response.data['data'];
  }

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

  Future<void> signOut() async {
    await Future.wait([
      tokenService.deleteTokenModelFromHiveBox(),
      profileController.deleteProfileFromHiveBox(),
      SchoolController().deleteFromSchoolBox(),
    ]);
    isLogin = false;
  }
}
