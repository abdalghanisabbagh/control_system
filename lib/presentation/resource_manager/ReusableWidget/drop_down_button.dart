import 'package:control_system/domain/controllers/dropdown_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownWidget extends GetView<DropDownButtonController> {
  const DropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton(
          onChanged: (newValue) {
            controller.setSelected(newValue);
          },
          value: controller.selectedOption.value,
          items: controller.items
              .map((selectedType) => DropdownMenuItem(
                    value: selectedType,
                    child: Text(selectedType),
                  ))
              .toList(),
        ));
  }
}
