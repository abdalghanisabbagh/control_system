import '../../Models/user/login_response/login_res_model.dart';
import '../interfaces/response_interface.dart';

class LoginResponseImplementationHandler
    extends ResponseInterface<LoginResModel> {
  @override
  LoginResModel fromJson(Map<String, dynamic> json) {
    return LoginResModel.fromJson(json);
  }
}
