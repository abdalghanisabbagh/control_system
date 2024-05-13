// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:control_system/Data/Network/tools/failure_model.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    log(error.toString());
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionError =>
      DataSource.CONNECTION_ERROR.getFailure(),
    DioExceptionType.badCertificate => DataSource.BAD_CERTIFICATE.getFailure(),
    DioExceptionType.sendTimeout => DataSource.SEND_TIMEOUT.getFailure(),
    DioExceptionType.receiveTimeout => DataSource.RECIEVE_TIMEOUT.getFailure(),
    DioExceptionType.badResponse => DataSource.BAD_RESPONSE.getFailure(),
    DioExceptionType.connectionTimeout =>
      DataSource.CONNECT_TIMEOUT.getFailure(),
    DioExceptionType.cancel => DataSource.CANCEL.getFailure(),
    DioExceptionType.unknown => DataSource.NOT_FOUND.getFailure(),
  };
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    return switch (this) {
      DataSource.SUCCESS =>
        Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS),
      DataSource.NO_CONTENT =>
        Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT),
      DataSource.BAD_REQUEST =>
        Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST),
      DataSource.FORBIDDEN =>
        Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN),
      DataSource.UNAUTORISED =>
        Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED),
      DataSource.NOT_FOUND =>
        Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND),
      DataSource.INTERNAL_SERVER_ERROR => Failure(
          ResponseCode.INTERNAL_SERVER_ERROR,
          ResponseMessage.INTERNAL_SERVER_ERROR),
      DataSource.CONNECT_TIMEOUT =>
        Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT),
      DataSource.CANCEL => Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL),
      DataSource.RECIEVE_TIMEOUT =>
        Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT),
      DataSource.SEND_TIMEOUT =>
        Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT),
      DataSource.CACHE_ERROR =>
        Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR),
      DataSource.NO_INTERNET_CONNECTION => Failure(
          ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION),
      DataSource.DEFAULT =>
        Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT),
      DataSource.CONNECTION_ERROR =>
        Failure(ResponseCode.DEFAULT, ResponseMessage.CONNECTION_ERROR),
      DataSource.BAD_CERTIFICATE =>
        Failure(ResponseCode.BAD_CERTIFICATE, ResponseMessage.BAD_CERTIFICATE),
      DataSource.BAD_RESPONSE =>
        Failure(ResponseCode.BAD_RESPONSE, ResponseMessage.BAD_RESPONSE),
    };
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int BAD_CERTIFICATE = 600; // failure, bad certificate

  // local status code
  static const int DEFAULT = 0000;
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int BAD_RESPONSE = -8; // failure, bad response
}

class ResponseMessage {
  static const String SUCCESS = "success"; // success with data
  static const String NO_CONTENT =
      "success"; // success with no data (no content)
  static const String BAD_REQUEST =
      "Bad request, Try again later"; // failure, API rejected request
  static const String UNAUTORISED =
      "User is unauthorised, Try again later"; // failure, user is not authorised
  static const String FORBIDDEN =
      "Forbidden request, Try again later"; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      "Some thing went wrong, Try again later"; // failure, crash in server side
  static const String NOT_FOUND =
      "Some thing went wrong, Try again later"; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = "Time out error, Try again later";
  static const String CANCEL = "Request was cancelled, Try again later";
  static const String RECIEVE_TIMEOUT = "Time out error, Try again later";
  static const String SEND_TIMEOUT = "Time out error, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
  static const String DEFAULT = "Some thing went wrong, Try again later";
  static const String CONNECTION_ERROR =
      "Some thing went wrong, Try again later";

  static const String BAD_CERTIFICATE = "Bad certificate";
  static const String BAD_RESPONSE = "Bad Response";
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  CONNECTION_ERROR,
  BAD_CERTIFICATE,
  BAD_RESPONSE,
}
