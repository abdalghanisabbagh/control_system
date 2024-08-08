import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/roles_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class AddNewRolesWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  AddNewRolesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Form(
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
                MytextFormFiled(
                  myValidation: Validations.requiredValidator,
                  controller: nameController,
                  title: "Role Name",
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<RolesController>(
                  builder: (controller) {
                    return controller.addLoading
                        ? Center(
                            child: LoadingIndicators.getLoadingIndicator(),
                          )
                        : Row(
                            children: [
                              const Expanded(
                                child: ElevatedBackButton(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedAddButton(
                                  onPressed: () async {
                                    controller
                                        .addNewRoles(
                                      name: nameController.text,
                                    )
                                        .then(
                                      (added) {
                                        if (added) {
                                          nameController.clear();
                                          Get.back();
                                          MyFlashBar.showSuccess(
                                                  'Roles has ben added',
                                                  'Roles')
                                              .show(Get.key.currentContext);
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
