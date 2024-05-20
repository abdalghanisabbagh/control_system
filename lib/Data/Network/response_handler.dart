import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../handlers/interfaces/response_interface.dart';
import 'tools/failure_model.dart';

class ResponseHandler<T extends ResponseInterface, R> {
  T data;

  ResponseHandler({required this.data});

  Either<Failure, R> getResponse(Response<dynamic> response) {
    if (response.data['status'] == true) {
      return Right(data.fromJson(response.data['data']));
    } else {
      return Left(Failure(response.statusCode ?? 0, response.data['message']));
    }
  }
}
