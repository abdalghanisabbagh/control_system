// ignore_for_file: constant_identifier_names

import 'package:control_system/app/configurations/app_links.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";

const Duration timeOut = Duration(seconds: 120);

class DioFactory {
  Future<Dio> getDio({String? token}) async {
    Dio dio = Dio();

    // token = Hive.box('Token').get('aToken');

    // String dtoken = Hive.box('Token').get('dToken');
    // DateTime? tokenTime = DateTime.tryParse(dtoken);
    // if (tokenTime!.difference(DateTime.now()).inMinutes > 55) {
    //   /// TODO: get new access token
    // } else {
    //   token = Hive.box('Token').get('aToken');
    // }

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
