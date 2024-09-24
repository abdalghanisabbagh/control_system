import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/constants/app_constatnts.dart';
import '../../../resource_manager/validations.dart';

class AddNewUserWidget extends GetView<AdminController> {
  const AddNewUserWidget({super.key});

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
                          myValidation: Validations.requiredValidator,
                        ),
                      ),
                      SizedBox(
                        width: 450,
                        child: MyTextFormFiled(
                          title: "Username",
                          controller: userController.usernameController,
                          myValidation: Validations.requiredValidator,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormField<List<ValueItem<dynamic>>>(
                        validator:
                            Validations.multiSelectDropDownRequiredValidator,
                        builder: (formFieldState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MultiSelectDropDownView(
                                hintText: "Select Role",
                                options: AppConstants.roleTypes
                                    .map((e) => ValueItem(label: e, value: e))
                                    .toList(),
                                onOptionSelected: (value) {
                                  formFieldState.didChange(value);
                                  controller.selectedRoleType =
                                      value.first.value;
                                  controller.update();
                                },
                              ),
                              if (formFieldState.hasError)
                                Text(
                                  formFieldState.errorText!,
                                  style: nunitoRegular.copyWith(
                                    fontSize: FontSize.s10,
                                    color: ColorManager.error,
                                  ),
                                ).paddingOnly(left: 10),
                            ],
                          );
                        },
                      ),
                      controller.selectedRoleType == "Principal" ||
                              controller.selectedRoleType == "Vice Principal"
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                FormField<List<ValueItem<dynamic>>>(
                                  validator: Validations
                                      .multiSelectDropDownRequiredValidator,
                                  builder: (formFieldState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MultiSelectDropDownView(
                                          hintText: "Select Division",
                                          options: AppConstants.schoolDivision
                                              .map((e) =>
                                                  ValueItem(label: e, value: e))
                                              .toList(),
                                          onOptionSelected: (value) {
                                            formFieldState.didChange(value);
                                            controller.selectedDivision =
                                                value.first.value;
                                          },
                                        ),
                                        if (formFieldState.hasError)
                                          Text(
                                            formFieldState.errorText!,
                                            style: nunitoRegular.copyWith(
                                              fontSize: FontSize.s10,
                                              color: ColorManager.error,
                                            ),
                                          ).paddingOnly(left: 10),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                        width: 450,
                        child: MyTextFormFiled(
                          title: "Password",
                          controller: userController.oldPasswordController,
                          myValidation: Validations.requiredValidator,
                          obscureText: userController.showOldPassord,
                          suffixIcon: IconButton(
                            icon: Icon(
                              userController.showOldPassord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              userController.showOldPassord =
                                  !userController.showOldPassord;
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
                          obscureText: userController.showOldPassord,
                          suffixIcon: IconButton(
                            icon: Icon(
                              userController.showOldPassord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              userController.showOldPassord =
                                  !userController.showOldPassord;
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
                                        userController.addNewUser().then(
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
