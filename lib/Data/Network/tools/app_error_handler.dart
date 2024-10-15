// ignore_for_file: constant_identifier_names

import 'package:control_system/Data/Network/tools/failure_model.dart';
import 'package:dio/dio.dart';

/// Converts a DioException to a Failure instance.
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

/// An enum that represents the source of the error.
///
/// The source of the error can be one of the following:
///  * [SUCCESS] - the request was successful
///  * [NO_CONTENT] - the request was successful but there was no content
///  * [BAD_REQUEST] - the request was invalid or cannot be processed
///  * [FORBIDDEN] - the request was forbidden or the user is not authorized
///  * [UNAUTORISED] - the request was unauthorized
///  * [NOT_FOUND] - the request was not found
///  * [INTERNAL_SERVER_ERROR] - the server encountered an unexpected condition
///  * [CONNECT_TIMEOUT] - the request timed out
///  * [CANCEL] - the request was cancelled
///  * [RECIEVE_TIMEOUT] - the request timed out
///  * [SEND_TIMEOUT] - the request timed out
///  * [CACHE_ERROR] - the request was cache related
///  * [NO_INTERNET_CONNECTION] - the device has no internet connection
///  * [DEFAULT] - the request has a default error
///  * [CONNECTION_ERROR] - the request had a connection error
///  * [BAD_CERTIFICATE] - the request had a bad certificate
///  * [BAD_RESPONSE] - the request had a bad response
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

/// A class that handles errors and converts them to a [Failure] instance.
///
/// The [ErrorHandler] class takes a dynamic error and checks if it is a
/// [DioException]. If it is, it calls the [_handleError] function to convert
/// the [DioException] to a [Failure] instance. If not, it sets the [failure]
/// property to a default [Failure] instance with a code of [ResponseCode.DEFAULT]
/// and a message of 'DEFAULT'.
class ErrorHandler implements Exception {
  /// The failure instance that will be returned.
  late Failure failure;

  /// A factory method that takes a dynamic error and returns a [Failure] instance.
  ///
  /// If the error is a [DioException], it calls the [_handleError] function to
  /// convert the [DioException] to a [Failure] instance. If not, it sets the
  /// [failure] property to a default [Failure] instance with a code of
  /// [ResponseCode.DEFAULT] and a message of 'DEFAULT'.
  factory ErrorHandler.handle(dynamic error) {
    ErrorHandler errorHandler = ErrorHandler._internal();

    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      errorHandler.failure = _handleError(error);
    } else {
      // default error
      errorHandler.failure = DataSource.DEFAULT.getFailure();
    }

    return errorHandler;
  }

  /// A private constructor that initializes the [ErrorHandler] class.
  ErrorHandler._internal();
}

/// Codes for response status.
class ResponseCode {
  /// Bad certificate.
  /// Failure, bad certificate.
  static const int BAD_CERTIFICATE = 600;

  /// Bad request.
  /// Failure, API rejected request.
  static const int BAD_REQUEST = 400;

  /// Bad response.
  /// Failure, bad response.
  static const int BAD_RESPONSE = -8;

  /// Cache error.
  /// Failure, cache error.
  static const int CACHE_ERROR = -5;

  /// Cancel.
  /// Failure, request was cancelled.
  static const int CANCEL = -2;

  /// Connect timeout.
  /// Failure, could not connect to the server.
  static const int CONNECT_TIMEOUT = -1;

  /// Default response code.
  /// Success, no data.
  static const int DEFAULT = 0000;

  /// Forbidden.
  /// Failure, API rejected request.
  static const int FORBIDDEN = 403;

  /// Internal server error.
  /// Failure, crash in server side.
  static const int INTERNAL_SERVER_ERROR = 500;

  /// Not found.
  /// Failure, not found.
  static const int NOT_FOUND = 404;

  /// No content.
  /// Success with no data (no content).
  static const int NO_CONTENT = 201;

  /// No internet connection.
  /// Failure, no internet connection.
  static const int NO_INTERNET_CONNECTION = -6;

  /// Receive timeout.
  /// Failure, receive timeout.
  static const int RECIEVE_TIMEOUT = -3;

  /// Send timeout.
  /// Failure, send timeout.
  static const int SEND_TIMEOUT = -4;

  /// Success.
  /// Success with data.
  static const int SUCCESS = 200;

  /// Unauthorised.
  /// Failure, user is not authorised.
  static const int UNAUTORISED = 401;
}

/// Class containing all the error messages from the API.
class ResponseMessage {
  /// Error message for a bad certificate.
  static const String BAD_CERTIFICATE = "Bad certificate";

  /// Error message for a bad request.
  /// Failure, API rejected request.
  static const String BAD_REQUEST = "Bad request, Try again later";

  /// Error message for a bad response.
  static const String BAD_RESPONSE = "Bad Response";

  /// Error message for a cache error.
  /// Failure, cache related.
  static const String CACHE_ERROR = "Cache error, Try again later";

  /// Error message for a cancelled request.
  /// Failure, request was cancelled.
  static const String CANCEL = "Request was cancelled, Try again later";

  /// Error message for a connection error.
  /// Failure, connection related.
  static const String CONNECTION_ERROR =
      "Some thing went wrong, Try again later";

  // local status code
  /// Error message for a connect timeout.
  /// Failure, request timed out.
  static const String CONNECT_TIMEOUT = "Time out error, Try again later";

  /// Default error message.
  /// Failure, unknown error.
  static const String DEFAULT = "Some thing went wrong, Try again later";

  /// Error message for a forbidden request.
  /// Failure, API rejected request.
  static const String FORBIDDEN = "Forbidden request, Try again later";

  /// Error message for an internal server error.
  /// Failure, crash in server side.
  static const String INTERNAL_SERVER_ERROR =
      "Some thing went wrong, Try again later";

  /// Error message for a not found error.
  /// Failure, not found.
  static const String NOT_FOUND = "Some thing went wrong, Try again later";

  /// Error message for a no content error.
  /// Success with no data (no content).
  static const String NO_CONTENT = "success";

  /// Error message for a no internet connection error.
  /// Failure, no internet connection.
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";

  /// Error message for a receive timeout.
  /// Failure, request timed out.
  static const String RECIEVE_TIMEOUT = "Time out error, Try again later";

  /// Error message for a send timeout.
  /// Failure, request timed out.
  static const String SEND_TIMEOUT = "Time out error, Try again later";

  /// Error message for a success error.
  /// Success with data.
  static const String SUCCESS = "success";

  /// Error message for an unauthorised error.
  /// Failure, user is not authorised.
  static const String UNAUTORISED = "User is unauthorised, Try again later";
}

extension DataSourceExtension on DataSource {
  /// Returns a [Failure] instance based on the [DataSource] enum value.
  ///
  /// The returned [Failure] instance will have a code and message based on the
  /// [DataSource] enum value.
  ///
  Failure getFailure() {
    return switch (this) {
      DataSource.SUCCESS =>
        const Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS),
      DataSource.NO_CONTENT =>
        const Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT),
      DataSource.BAD_REQUEST =>
        const Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST),
      DataSource.FORBIDDEN =>
        const Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN),
      DataSource.UNAUTORISED =>
        const Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED),
      DataSource.NOT_FOUND =>
        const Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND),
      DataSource.INTERNAL_SERVER_ERROR => const Failure(
          ResponseCode.INTERNAL_SERVER_ERROR,
          ResponseMessage.INTERNAL_SERVER_ERROR),
      DataSource.CONNECT_TIMEOUT => const Failure(
          ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT),
      DataSource.CANCEL =>
        const Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL),
      DataSource.RECIEVE_TIMEOUT => const Failure(
          ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT),
      DataSource.SEND_TIMEOUT =>
        const Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT),
      DataSource.CACHE_ERROR =>
        const Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR),
      DataSource.NO_INTERNET_CONNECTION => const Failure(
          ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION),
      DataSource.DEFAULT =>
        const Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT),
      DataSource.CONNECTION_ERROR =>
        const Failure(ResponseCode.DEFAULT, ResponseMessage.CONNECTION_ERROR),
      DataSource.BAD_CERTIFICATE => const Failure(
          ResponseCode.BAD_CERTIFICATE, ResponseMessage.BAD_CERTIFICATE),
      DataSource.BAD_RESPONSE =>
        const Failure(ResponseCode.BAD_RESPONSE, ResponseMessage.BAD_RESPONSE),
    };
  }
}
