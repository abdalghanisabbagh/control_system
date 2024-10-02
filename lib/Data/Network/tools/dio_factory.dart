// ignore_for_file: constant_identifier_names

import 'package:control_system/app/configurations/app_links.dart';
import 'package:control_system/app/configurations/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../domain/services/token_service.dart';
import '../../Models/token/token_model.dart';

/// The header key for the Accept header.
const String ACCEPT = "accept";

/// The mime type for JSON data.
const String APPLICATION_JSON = "application/json";

/// The header key for the Authorization header.
const String AUTHORIZATION = "authorization";

/// The header key for the Content-Type header.
const String CONTENT_TYPE = "content-type";

/// The default connection timeout for the Dio client.
const Duration timeOut = Duration(seconds: 120);

/// Dio Factory to create Dio instances with interceptors, headers and
/// custom settings
class DioFactory {
  /// Create a Dio instance with interceptors, headers and custom settings
  ///
  /// [token] is an optional parameter to set the token for the Authorization
  /// header
  Dio getDio({TokenModel? token}) {
    Dio dio = Dio()..interceptors.add(TokenInterceptor());

    TokenService tokenService = Get.find<TokenService>();

    TokenModel? tokenModel = tokenService.tokenModel;

    // Set the headers for the dio instance
    /// The headers for the dio instance
    ///
    /// The headers contains the:
    ///  * [CONTENT_TYPE] with value [APPLICATION_JSON]
    ///  * [ACCEPT] with value [APPLICATION_JSON]
    ///  * [AUTHORIZATION] with the token if it exists
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,

      // Add the Authorization header only if we have a token
      if (token != null || tokenModel?.aToken != null)
        AUTHORIZATION: "Bearer ${token?.aToken ?? tokenModel?.aToken}",
    };

    // Set the dio options
    dio.options = BaseOptions(
      baseUrl: AppLinks.baseUrlStaging,
      headers: headers,

      // Set the time out for the dio instance
      receiveTimeout: timeOut,
      sendTimeout: timeOut,
    );

    // Only print the logs in debug mode
    if (!kReleaseMode) {
      // dio.interceptors.add(PrettyDioLogger(
      //   5,
      //   requestHeader: true,
      //   requestBody: true,
      //   responseHeader: true,
      // ));
    }

    return dio;
  }
}
