import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../enums/req_type_enum.dart';
import 'tools/dio_factory.dart';
import 'tools/failure_model.dart';

class ResponseHandler<T> {
  final Dio _dio;

  ResponseHandler() : _dio = DioFactory().getDio();

  /// A generic function to send a request to the server and get a response
  ///
  /// The function takes the following parameters:
  ///
  /// - [path]: The path of the request
  /// - [converter]: A function that takes the response data and converts it to
  ///   the required type [T]
  /// - [type]: The type of the request
  /// - [params]: An optional map of parameters to be sent with the request
  /// - [body]: An optional body to be sent with the request
  ///
  /// The function returns a [Future] that resolves to an [Either] of a
  /// [Failure] or the required type [T]
  Future<Either<Failure, T>> getResponse({
    required String path,
    required T Function(dynamic) converter,
    required ReqTypeEnum type,
    Map<String, dynamic>? params,
    dynamic body,
  }) async {
    switch (type) {
      case ReqTypeEnum.GET:
        return await _get(path, converter, params, body);
      case ReqTypeEnum.POST:
        return await _post(path, converter, params, body);
      case ReqTypeEnum.PUT:
        return await _put(path, converter, params, body);
      case ReqTypeEnum.DELETE:
        return await _delete(path, converter, params, body);
      case ReqTypeEnum.PATCH:
        return await _patch(path, converter, params, body);
    }
  }

  /// A function to send a DELETE request to the server
  ///
  /// The function takes the following parameters:
  ///
  /// - [path]: The path of the request
  /// - [converter]: A function that takes the response data and converts it to
  ///   the required type [T]
  /// - [params]: An optional map of parameters to be sent with the request
  /// - [body]: An optional body to be sent with the request
  ///
  /// The function returns a [Future] that resolves to an [Either] of a
  /// [Failure] or the required type [T]
  Future<Either<Failure, T>> _delete(
    String path,
    T Function(dynamic) converter,
    Map<String, dynamic>? params,
    dynamic body,
  ) async {
    return await _request(
      converter,
      () => _dio
          .delete(
        path,
        queryParameters: params,
        data: body,
      )
          .catchError(
        (error) {
          return Response(
            statusCode: error.response.statusCode,
            data: {"message": error.response.data['message']},
            requestOptions: RequestOptions(),
          );
        },
      ),
    );
  }

  /// A function to send a GET request to the server
  //
  /// The function takes the following parameters:
  //
  /// - [path]: The path of the request
  /// - [converter]: A function that takes the response data and converts it to
  ///   the required type [T]
  /// - [params]: An optional map of parameters to be sent with the request
  /// - [body]: An optional body to be sent with the request
  //
  /// The function returns a [Future] that resolves to an [Either] of a
  /// [Failure] or the required type [T]
  Future<Either<Failure, T>> _get(
    String path,
    T Function(dynamic) converter,
    Map<String, dynamic>? params,
    dynamic body,
  ) async {
    return await _request(
      converter,
      () => _dio
          .get(
        path,
        queryParameters: params,
        data: body,
      )
          .catchError(
        (error) {
          return Response(
            statusCode: error.response.statusCode,
            data: {"message": error.response.data['message']},
            requestOptions: RequestOptions(),
          );
        },
      ),
    );
  }

  /// A function to send a PATCH request to the server
  ///
  /// The function takes the following parameters:
  ///
  /// - [path]: The path of the request
  /// - [converter]: A function that takes the response data and converts it to
  ///   the required type [T]
  /// - [params]: An optional map of parameters to be sent with the request
  /// - [body]: An optional body to be sent with the request
  ///
  /// The function returns a [Future] that resolves to an [Either] of a
  /// [Failure] or the required type [T]
  Future<Either<Failure, T>> _patch(
    String path,
    T Function(dynamic) converter,
    Map<String, dynamic>? params,
    dynamic body,
  ) async {
    return await _request(
      converter,
      () => _dio
          .patch(
        path,
        queryParameters: params,
        data: body,
      )
          .catchError(
        (error) {
          return Response(
            statusCode: error.response.statusCode,
            data: {"message": error.response.data['message']},
            requestOptions: RequestOptions(),
          );
        },
      ),
    );
  }

  /// A function to send a POST request to the server
  ///
  /// The function takes the following parameters:
  ///
  /// - [path]: The path of the request
  /// - [converter]: A function that takes the response data and converts it to
  ///   the required type [T]
  /// - [params]: An optional map of parameters to be sent with the request
  /// - [body]: An optional body to be sent with the request
  ///
  /// The function returns a [Future] that resolves to an [Either] of a
  /// [Failure] or the required type [T]
  Future<Either<Failure, T>> _post(
    String path,
    T Function(dynamic) converter,
    Map<String, dynamic>? params,
    dynamic body,
  ) async {
    return await _request(
      converter,
      () => _dio
          .post(
        path,
        queryParameters: params,
        data: body,
      )
          .catchError(
        (error) {
          return Response(
            statusCode: error.response.statusCode,
            data: {"message": error.response.data['message']},
            requestOptions: RequestOptions(),
          );
        },
      ),
    );
  }

  /// A function to send a PUT request to the server
  ///
  /// The function takes the following parameters:
  ///
  /// - [path]: The path of the request
  /// - [converter]: A function that takes the response data and converts it to
  ///   the required type [T]
  /// - [params]: An optional map of parameters to be sent with the request
  /// - [body]: An optional body to be sent with the request
  ///
  /// The function returns a [Future] that resolves to an [Either] of a
  /// [Failure] or the required type [T]
  Future<Either<Failure, T>> _put(
    String path,
    T Function(dynamic) converter,
    Map<String, dynamic>? params,
    dynamic body,
  ) async {
    return await _request(
      converter,
      () => _dio
          .put(
        path,
        queryParameters: params,
        data: body,
      )
          .catchError(
        (error) {
          return Response(
            statusCode: error.response.statusCode,
            data: {"message": error.response.data['message']},
            requestOptions: RequestOptions(),
          );
        },
      ),
    );
  }

  /// A private function that makes the actual request to the server and handles
  /// the response.
  ///
  /// The function takes two parameters:
  ///
  /// - [converter]: A function that takes the response data and converts it to
  ///   the required type [T]
  /// - [request]: A function that returns a [Future] of a [Response] instance
  ///
  /// The function will return a [Future] that resolves to an [Either] of a
  /// [Failure] or the required type [T].
  ///
  /// The function will check the status code of the response and the value of
  /// the 'status' key in the response data. If the status code is 200 or 201 and
  /// the 'status' is true, the function will assume that the response is successful
  /// and will try to convert the data to the required type [T] using the
  /// [converter] function. If the conversion is successful, the function will
  /// return a [Right] instance with the converted data. If the conversion fails,
  /// the function will return a [Left] instance with a [Failure] instance with
  /// code 2025 and a message 'error while convert $T from json'.
  ///
  /// If the status code is not 200 or 201 or the 'status' is not true, the
  /// function will return a [Left] instance with a [Failure] instance with the
  /// status code and the message from the response data.
  Future<Either<Failure, T>> _request(
    T Function(dynamic) converter,
    Future<Response> Function() request,
  ) async {
    final Response response = await request.call();

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data['status'] is bool
          ? response.data['status'] == true
          : response.data['data'] is String
              ? response.data['data'] == 'OK'
              : false) {
        if (response.data['data'] != null) {
          try {
            return Right(converter(response.data['data']));
          } catch (e) {
            return Left(Failure(2025, 'error while convert $T from json'));
          }
        } else {
          return const Left(
            Failure(
              2025,
              'No data found',
            ),
          );
        }
      } else {
        return Left(
          Failure(
            response.statusCode ?? 0,
            response.data['message'],
          ),
        );
      }
    } else {
      return Left(
        Failure(
          response.statusCode ?? 0,
          response.data['message'],
        ),
      );
    }
  }
}
