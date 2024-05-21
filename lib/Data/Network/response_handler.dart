import 'package:control_system/Data/Network/tools/app_error_handler.dart';
import 'package:control_system/Data/enums/req_type_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'tools/dio_factory.dart';
import 'tools/failure_model.dart';

class ResponseHandler<T> {
  ResponseHandler() : _dio = DioFactory.dioInstance;

  final Dio _dio;

  Future<Either<Failure, T>> getResponse(
      String path,
      T Function(Map<String, dynamic>) converter,
      ReqTypeEnum type,
      Map<String, dynamic>? params) async {
    switch (type) {
      case ReqTypeEnum.GET:
        return await _get(path, converter, params);
      case ReqTypeEnum.POST:
        return await _post(path, converter, params);
      case ReqTypeEnum.PUT:
        return await _put(path, converter, params);
      case ReqTypeEnum.DELETE:
        return await _delete(path, converter, params);
      case ReqTypeEnum.PATCH:
        return await _patch(path, converter, params);
    }
  }

  Future<Either<Failure, T>> _get(
      String path,
      T Function(Map<String, dynamic>) converter,
      Map<String, dynamic>? params) async {
    return await _request(
      converter,
      () => _dio.get(
        path,
        queryParameters: params,
      ),
    );
  }

  Future<Either<Failure, T>> _post(
      String path,
      T Function(Map<String, dynamic>) converter,
      Map<String, dynamic>? params) async {
    return await _request(
      converter,
      () => _dio.post(
        path,
        data: params,
      ),
    );
  }

  Future<Either<Failure, T>> _put(
      String path,
      T Function(Map<String, dynamic>) converter,
      Map<String, dynamic>? params) async {
    return await _request(
      converter,
      () => _dio.put(
        path,
        data: params,
      ),
    );
  }

  Future<Either<Failure, T>> _delete(
      String path,
      T Function(Map<String, dynamic>) converter,
      Map<String, dynamic>? params) async {
    return await _request(
      converter,
      () => _dio.delete(
        path,
        data: params,
      ),
    );
  }

  Future<Either<Failure, T>> _patch(
      String path,
      T Function(Map<String, dynamic>) converter,
      Map<String, dynamic>? params) async {
    return await _request(
      converter,
      () => _dio.patch(
        path,
        data: params,
      ),
    );
  }

  Future<Either<Failure, T>> _request(
    T Function(Map<String, dynamic>) converter,
    Future<Response> Function() request,
  ) async {
    final Response response = await request.call().catchError(
      (error) {
        ErrorHandler.handle(error);
        return Response(requestOptions: RequestOptions(path: 'error'));
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(converter(response.data['data']));
    } else {
      return Left(Failure(
        response.statusCode ?? 0,
        response.data['message'],
      ));
    }
  }
}
