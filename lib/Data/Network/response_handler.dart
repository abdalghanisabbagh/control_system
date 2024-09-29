import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../enums/req_type_enum.dart';
import 'tools/dio_factory.dart';
import 'tools/failure_model.dart';

class ResponseHandler<T> {
  final Dio _dio;

  ResponseHandler() : _dio = DioFactory().getDio();


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
          return Left(
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