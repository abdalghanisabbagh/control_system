import '../../Models/user/login_response/login_response.dart';
import '../interfaces/response_interface.dart';

class LoginResponseImplementationHandler
    extends ResponseInterface<LoginResponseModel> {
  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
    return LoginResponseModel.fromJson(json);
  }
}
