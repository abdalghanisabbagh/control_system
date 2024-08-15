import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../Data/Models/user/roles/role_res_model.dart';
import '../../../../domain/controllers/roles_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

class AddScreensToRolesWidget extends GetView<RolesController> {
  final RoleResModel role;

  const AddScreensToRolesWidget({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Screens To ${role.name} Role",
            style: nunitoBlack.copyWith(
              color: ColorManager.bgSideMenu,
              fontSize: 30,
            ),
          ),
          MultiSelectDropDownView(
            hintText: "Select Screens",
            searchEnabled: true,
            options: controller.screens
                .where((screen) =>
                    !role.screens!.map((e) => e.id).contains(screen.id))
                .map((e) => ValueItem(label: e.name, value: e.id))
                .toList(),
            onOptionSelected: controller.onOptionSelected,
            multiSelect: true,
            showChipSelect: true,
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<RolesController>(
            builder: (controller) {
              return controller.connectLoading
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
                              controller.addScreensToRole(role.id!).then(
                                (isAdded) {
                                  if (isAdded) {
                                    Get.back();
                                    MyFlashBar.showSuccess(
                                            'Screen has ben added to ${role.name}',
                                            role.name!)
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
    );
  }
}
