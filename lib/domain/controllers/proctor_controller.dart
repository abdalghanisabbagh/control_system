import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProctorController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nisIdController = TextEditingController();

  bool showPassord = false;
  @override
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nisIdController.dispose();
    super.onClose();
  }
}
