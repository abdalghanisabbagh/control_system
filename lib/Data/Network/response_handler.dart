import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../handlers/interfaces/response_interface.dart';
import 'tools/failure_model.dart';

class ResponseHandler<T extends ResponseInterface> {
  T? data;

  Either<Failure, T> getResponse(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return Right(data!.fromJson(response.data));
    } else {
      return Left(Failure(response.statusCode ?? 0, response.data['message']));
    }
  }
}
