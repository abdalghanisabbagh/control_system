import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/privileges_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class AddNewPrivilegesWidget extends GetView<PrivilegesController> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // مفتاح الـ Form للتحقق من المدخلات

  AddNewPrivilegesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Form(
            key: _formKey, // تعيين المفتاح للـ Form
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add New Roles",
                  style: nunitoBlack.copyWith(
                    color: ColorManager.bgSideMenu,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MytextFormFiled(
                  myValidation: Validations.requiredValidator,
                  controller: nameController,
                  title: "Role Name",
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.addLoading
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: ElevatedBackButton(
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedAddButton(
                              onPressed: () async {
                                // التحقق من صحة الحقول
                                if (_formKey.currentState!.validate()) {
                                  // إذا كانت الحقول صحيحة، أضف الدور
                                  bool added = await controller.addNewRoles(
                                    name: nameController.text,
                                  );

                                  if (added) {
                                    nameController.clear();
                                    Get.back();
                                    MyFlashBar.showSuccess(
                                      'Role has been added successfully',
                                      'Success',
                                    ).show(Get.key.currentContext);
                                  } else {
                                    MyFlashBar.showError(
                                      'Failed to add role',
                                      'Error',
                                    ).show(Get.key.currentContext);
                                  }
                                } else {
                                  // عرض رسالة خطأ في حالة وجود خطأ في الإدخال
                                  MyFlashBar.showError(
                                    'Please fill in the required fields',
                                    'Error',
                                  ).show(Get.key.currentContext);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
