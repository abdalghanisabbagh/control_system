import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/school_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';

class AddNewSchoolWidget extends GetView<SchoolController> {
  const AddNewSchoolWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController schoolNameController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Add New School",
          style: nunitoRegular.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          cursorColor: ColorManager.bgSideMenu,
          style: nunitoRegular.copyWith(
              fontSize: 14, color: ColorManager.bgSideMenu),
          decoration: InputDecoration(
            hintText: "School name",
            hintStyle: nunitoRegular.copyWith(
                fontSize: 14, color: ColorManager.bgSideMenu),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          controller: schoolNameController,
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<SchoolController>(
          builder: (controller) {
            if (controller.isLoadingAddGrades) {
              return LoadingIndicators.getLoadingIndicator();
            }

            if (controller.options.isEmpty) {
              return const Text('No items available');
            }

            return SizedBox(
              width: 500,
              child: MultiSelectDropDownView(
                onOptionSelected: (selectedItem) {
                  controller.setSelectedItem(
                      selectedItem.isEmpty ? null : selectedItem.first);
                },
                options: controller.options,
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
              child: ElevatedBackButton(),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedAddButton(
                onPressed: () async {
                  schoolNameController.text.isEmpty ||
                          controller.selectedItem == null
                      ? MyFlashBar.showError('Please Fill All Fields', 'Error')
                          .show(context)
                      : await controller
                          .addNewSchool(
                              name: schoolNameController.text,
                              schoolTypeId: controller.selectedItem!.value)
                          .then(
                          (value) {
                            value
                                ? {
                                    context.mounted ? context.pop() : null,
                                    MyFlashBar.showSuccess(
                                            'The School Has Been Added Successfully',
                                            'Success')
                                        .show(context.mounted
                                            ? context
                                            : Get.key.currentContext!)
                                  }
                                : null;
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
