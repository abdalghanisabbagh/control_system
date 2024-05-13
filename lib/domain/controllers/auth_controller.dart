import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLogin = false.obs;
  RxBool isLoading = false.obs;
  List schools = [];

  Future login(String username, String password) async {
    isLoading.value = true;

    var response = await Dio().post('http://localhost:3333/auth/login', data: {
      "username": username,
      "password": password,
    });

    isLoading.value = false;
    isLogin.value = true;
  }
}
