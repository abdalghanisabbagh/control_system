import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../domain/controllers/auth_controller.dart';
import '../../domain/services/token_service.dart';
import '../Models/token/token_model.dart';
import '../enums/req_type_enum.dart';
import 'tools/dio_factory.dart';
import 'tools/failure_model.dart';

class ResponseHandler<T> {
  ResponseHandler() : _dio = DioFactory().getDio();

  Dio _dio;

  Future<Either<Failure, T>> getResponse({
    required String path,
    required T Function(dynamic) converter,
    required ReqTypeEnum type,
    Map<String, dynamic>? params,
    dynamic body,
  }) async {
    TokenService tokenService = Get.find<TokenService>();
    String dtoken =
        tokenService.tokenModel?.dToken ?? DateTime.now().toIso8601String();
    DateTime? tokenTime = DateTime.tryParse(dtoken);
    if (DateTime.now().difference(tokenTime!).inMinutes > 55) {
      String? newAccessToken = await Get.find<AuthController>().refreshToken();
      _dio = DioFactory().getDio(
        token: newAccessToken != null
            ? TokenModel( 
                aToken: newAccessToken,
                dToken: dtoken,
                rToken: tokenService.tokenModel!.rToken,
              )
            : null,
      );
    }

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

  Future<Either<Failure, T>> _request(
    T Function(dynamic) converter,
    Future<Response> Function() request,
  ) async {
    final Response response = await request.call();

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data['status'] == true) {
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
