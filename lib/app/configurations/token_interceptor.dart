import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../Data/Models/token/token_model.dart';
import '../../Data/Network/tools/app_error_handler.dart';
import '../../domain/services/token_service.dart';
import 'app_links.dart';

/// A custom dio interceptor that will handle refresh token for us
///
/// when the access token is expired the server will return 401 status code
/// so we will catch this error and send a request to refresh token endpoint
/// if the refresh token is valid we will get a new access token and will
/// replace the old one in the local storage and profile controller
///
/// then we will retry the request with the new access token
class TokenInterceptor extends Interceptor {
  /// an instance of the token service to get the current token model
  final TokenService tokenService = Get.find();

  /// the constructor of the interceptor
  TokenInterceptor();

  @override

  /// when the request fail this method will be called
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    /// if the request failed due to expired access token
    if (err.response != null && err.response!.statusCode == 401) {
      /// get the current refresh token
      String refresh = tokenService.tokenModel!.rToken;

      /// create a new dio instance to send the request to refresh token endpoint
      var dio = Dio(
        BaseOptions(
          baseUrl: AppLinks.baseUrlStaging,
        ),
      );

      try {
        /// send a request to the refresh token endpoint
        var response =
            await dio.post(AuthLinks.refresh, data: {'refreshToken': refresh});

        /// if the response is good we get a new access token
        /// so we need to replace the old one in the local storage and profile controller
        TokenModel tokenModel = TokenModel(
          aToken: response.data['data'],
          rToken: tokenService.tokenModel!.rToken,
        );
        tokenService.saveNewAccessToken(tokenModel);

        /// get the original request options
        final requestOptions = err.requestOptions;

        /// create a new request options with the new access token
        final newOptions = requestOptions.copyWith(
          headers: {
            'Authorization': 'Bearer ${response.data['data']}',
          },
        );

        /// retry the request with the new access token
        final retryResponse = await dio.fetch(newOptions);

        /// return the response of the retried request
        return handler.resolve(retryResponse);
      } catch (error) {
        /// if the refresh token is invalid we will handle the error
        ErrorHandler.handle(error);

        /// return the error response
        return handler
            .resolve(Response(requestOptions: RequestOptions(path: 'error')));
      }
    }

    /// if the error is not due to expired access token we will call the super method
    super.onError(err, handler);
  }
}
