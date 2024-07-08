import 'package:control_system/domain/controllers/roles_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_add_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_back_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

class AddNewRolesWidget extends StatelessWidget {
  AddNewRolesWidget({super.key});
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
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
          GetBuilder<RolesController>(builder: (controller) {
            return controller.addLoading
                ? const Center(
                    child: CircularProgressIndicator(),
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
                                    name: nameController.text,)
                                .then((added) {
                              if (added) {
                                nameController.clear();
                                Get.back();
                                MyFlashBar.showSuccess(
                                        'Roles has ben added', 'Roles')
                                    .show(Get.key.currentContext);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  );
          }),
        ],
      ),
    );
  }
}
