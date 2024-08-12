import 'package:control_system/Data/Models/user/users_res/user_res_model.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/constants/app_constatnts.dart';
import '../../../resource_manager/validations.dart';

// ignore: must_be_immutable
class EditUserWidget extends GetView<AdminController> {
  const EditUserWidget({super.key, required this.userResModel});
  final UserResModel userResModel;

  @override
  Widget build(BuildContext context) {
    controller.fullNameController.text = userResModel.fullName ?? '';
    controller.usernameController.text = userResModel.userName ?? '';
    controller.passwordController.text = '';
    controller.confirmPasswordController.text = '';
    controller.selectedDivision = userResModel.isFloorManager;

    return SizedBox(
      width: Get.width * 0.25,
      height: Get.height * 0.55,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: GetBuilder<AdminController>(
            builder: (_) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Edit User",
                        style: nunitoBold.copyWith(fontSize: 25),
                      ),
                    ),
                    const Divider(),
                    _buildTextField(
                      "User Full Name",
                      controller.fullNameController,
                    ),
                    _buildTextField(
                      "Username",
                      controller.usernameController,
                    ),
                    if (userResModel.isFloorManager != null)
                      _buildDivisionDropdown(),
                    _buildPasswordField(),
                    _buildConfirmPasswordField(),
                    const SizedBox(height: 20),
                    controller.isLodingEditUser
                        ? Center(
                            child: SizedBox(
                                width: 40,
                                height: 40,
                                child: LoadingIndicators.getLoadingIndicator()),
                          )
                        : _buildActionButtons(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController controller) {
    return SizedBox(
      width: 450,
      child: MytextFormFiled(
        title: title,
        controller: controller,
        myValidation: Validations.requiredValidator,
      ),
    );
  }

  Widget _buildDivisionDropdown() {
    return FormField<List<ValueItem<dynamic>>>(
      initialValue: controller.selectedDivision != null
          ? [
              ValueItem(
                  label: controller.selectedDivision!,
                  value: controller.selectedDivision)
            ]
          : [],
      validator: Validations.multiSelectDropDownRequiredValidator,
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            MultiSelectDropDownView(
              optionSelected: [
                ValueItem(
                    label: controller.selectedDivision!,
                    value: controller.selectedDivision)
              ],
              options: AppConstants.schoolDivision
                  .map((e) => ValueItem(label: e, value: e))
                  .toList(),
              onOptionSelected: (value) {
                formFieldState.didChange(value);
                controller.selectedDivision =
                    value.isNotEmpty ? value.first.value : null;
              },
            ),
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  formFieldState.errorText!,
                  style: nunitoRegular.copyWith(
                    fontSize: FontSize.s10,
                    color: ColorManager.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      width: 450,
      child: MytextFormFiled(
        title: "Old Password",
        controller: controller.passwordController,
        obscureText: controller.showOldPassord,
        suffixIcon: IconButton(
          icon: Icon(
            controller.showOldPassord ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            controller.showOldPassord = !controller.showOldPassord;
            controller.update();
          },
        ),
        myValidation: (value) {
          if (value != null && value.isNotEmpty) {
            if (controller.confirmPasswordController.text.isEmpty) {
              return 'Please enter the new password';
            }
            if (value == controller.confirmPasswordController.text) {
              return 'New password must be different from the old password';
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return SizedBox(
      width: 450,
      child: MytextFormFiled(
        title: "New Password",
        controller: controller.confirmPasswordController,
        obscureText: controller.showNewPassword,
        suffixIcon: IconButton(
          icon: Icon(
            controller.showNewPassword
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            controller.showNewPassword = !controller.showNewPassword;
            controller.update();
          },
        ),
        myValidation: (value) {
          if (controller.passwordController.text.isNotEmpty && value!.isEmpty) {
            return 'Please enter the new password';
          }
          if (value != null &&
              value.isNotEmpty &&
              value == controller.passwordController.text) {
            return 'New password must be different from the old password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedBackButton(
            onPressed: () {
              controller.confirmPasswordController.clear();
              controller.passwordController.clear();
              controller.fullNameController.clear();
              controller.usernameController.clear();
              Get.back();
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedEditButton(
            onPressed: () {
              if (controller.formKey.currentState?.validate() ?? false) {
                final oldPassword = controller.passwordController.text;
                final newPassword = controller.confirmPasswordController.text;

                final data = {
                  'Full_Name': controller.fullNameController.text,
                  'User_Name': controller.usernameController.text,
                  if (oldPassword.isNotEmpty) 'OldPassword': oldPassword,
                  if (newPassword.isNotEmpty) 'NewPassword': newPassword,
                  'IsFloorManager': controller.selectedDivision,
                };

                controller.editUser(data, userResModel.iD!).then((value) {
                  if (value) {
                    Get.back();
                    MyFlashBar.showSuccess(
                      "User updated successfully",
                      "Success",
                    ).show(Get.key.currentContext!);
                  }
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
