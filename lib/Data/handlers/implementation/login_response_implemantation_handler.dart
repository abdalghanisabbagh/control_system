import '../../Models/user/login_response/login_response.dart';
import '../interfaces/response_interface.dart';

class LoginResponseImplementationHandler
    extends ResponseInterface<LoginResponse> {
  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }
}
