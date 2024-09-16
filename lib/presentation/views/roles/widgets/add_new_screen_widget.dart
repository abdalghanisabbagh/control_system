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

class AddNewScreenWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController screenIdController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // مفتاح الـ Form للتحقق من المدخلات

  AddNewScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // تعيين المفتاح للـ Form
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add New Screen",
            style: nunitoBlack.copyWith(
              color: ColorManager.bgSideMenu,
              fontSize: 30,
            ),
          ),
          MytextFormFiled(
            myValidation: Validations.requiredValidator,
            controller: nameController,
            title: "Screen Name",
          ),
          MytextFormFiled(
            myValidation: Validations.requiredValidator,
            controller: screenIdController,
            title: "Screen Id",
          ),
          GetBuilder<PrivilegesController>(
            builder: (controller) {
              return controller.addLoading
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
                              if (_formKey.currentState!.validate()) {
                                bool added = await controller.addNewScreen(
                                  name: nameController.text,
                                  frontId: screenIdController.text,
                                );

                                if (added) {
                                  nameController.clear();
                                  screenIdController.clear();
                                  Get.back();
                                  MyFlashBar.showSuccess(
                                    'Screen has been added successfully',
                                    'Success',
                                  ).show(Get.key.currentContext);
                                } else {
                                  MyFlashBar.showError(
                                    'Failed to add screen',
                                    'Error',
                                  ).show(Get.key.currentContext);
                                }
                              } else {
                                // عرض رسالة خطأ في حالة وجود خطأ في الإدخال
                                MyFlashBar.showError(
                                  'Please fill in all required fields',
                                  'Error',
                                ).show(Get.key.currentContext);
                              }
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
