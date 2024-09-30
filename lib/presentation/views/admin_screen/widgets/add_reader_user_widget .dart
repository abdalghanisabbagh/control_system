import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class AddReaderUserWidget extends GetView<AdminController> {
  const AddReaderUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.25,
      height: Get.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: GetBuilder<AdminController>(
            builder: (userController) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 450,
                        child: MyTextFormFiled(
                          title: "User Full Name",
                          controller: userController.fullNameController,
                          myValidation: Validations.validateName,
                        ),
                      ),
                      SizedBox(
                        width: 450,
                        child: MyTextFormFiled(
                          title: "Username",
                          controller: userController.usernameController,
                          myValidation: Validations.validateUsername,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 450,
                        child: MyTextFormFiled(
                          title: "Password",
                          controller: userController.oldPasswordController,
                          myValidation: Validations.requiredValidator,
                          obscureText: userController.showOldPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              userController.showOldPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              userController.showOldPassword =
                                  !userController.showOldPassword;
                              userController.update();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 450,
                        child: MyTextFormFiled(
                          title: "Confirm Password",
                          controller: userController.newPasswordController,
                          obscureText: userController.showOldPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              userController.showOldPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              userController.showOldPassword =
                                  !userController.showOldPassword;
                              userController.update();
                            },
                          ),
                          myValidation: (value) {
                            return Validations.validateConfirmPassword(value,
                                userController.oldPasswordController.text);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      userController.isLoading
                          ? Center(
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child:
                                      LoadingIndicators.getLoadingIndicator()),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: ElevatedBackButton(
                                    onPressed: () {
                                      userController.fullNameController.clear();
                                      userController.usernameController.clear();
                                      userController.oldPasswordController
                                          .clear();
                                      userController.newPasswordController
                                          .clear();
                                      userController.nisIdController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: ElevatedAddButton(
                                    onPressed: () {
                                      if (userController.formKey.currentState!
                                          .validate()) {
                                        userController.addReaderUser().then(
                                          (value) {
                                            if (value) {
                                              Get.back();
                                              MyFlashBar.showSuccess(
                                                      'User has been created successfully',
                                                      'Success')
                                                  .show(
                                                      Get.key.currentContext!);
                                              controller.onInit();
                                            }
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
