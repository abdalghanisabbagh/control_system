import 'package:control_system/Data/Models/user/roles/role_res_model.dart';
import 'package:control_system/domain/controllers/roles_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_add_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_back_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

class AddScreensToRolesWidget extends GetView<RolesController> {
  const AddScreensToRolesWidget({super.key, required this.role});
  final RoleResModel role;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Add ScreenS To > ${role.name} < Role",
          style: nunitoBlack.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 30,
          ),
        ),
        MultiSelectDropDownView(
          hintText: "Select Screens",
          searchEnabled: true,
          options: controller.screens
              .map((e) => ValueItem(label: e.name, value: e.id))
              .toList(),
          onOptionSelected: controller.onOptionSelected,
          multiSelect: true,
          showChipSelect: true,
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
                          controller.addScreensToRole(role.id).then((isAdded) {
                            if (isAdded) {
                              Get.back();
                              MyFlashBar.showSuccess(
                                      'Screen has ben added to ${role.name}',
                                      role.name)
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
    );
  }
}
