// ignore_for_file: constant_identifier_names

import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../domain/services/token_service.dart';
import '../../Models/token/token_model.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";

const Duration timeOut = Duration(seconds: 120);

class DioFactory {
  Future<Dio> getDio({TokenModel? token}) async {
    Dio dio = Dio();

    TokenService tokenService = Get.find<TokenService>();

    TokenModel? result = tokenService.tokenModel;

    String dtoken =
        tokenService.tokenModel?.dToken ?? DateTime.now().toIso8601String();
    DateTime? tokenTime = DateTime.tryParse(dtoken);
    if (tokenTime!.difference(DateTime.now()).inMinutes > 55) {
      /// TODO: get new access token

      Get.find<AuthController>().refreshToken();
    } else {
      token = Hive.box('Token').get('aToken');
    }

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      if (token != null) AUTHORIZATION: "Bearer $token",
    };

    dio.options = BaseOptions(
      baseUrl: AppLinks.baseUrl,
      headers: headers,
      receiveTimeout: timeOut,
      sendTimeout: timeOut,
    );

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
