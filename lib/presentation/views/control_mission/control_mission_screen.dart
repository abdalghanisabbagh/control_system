import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/control_mission_controller.dart';
import '../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../base_screen.dart';
import 'widgets/header_mission_widget.dart';

class ControlMissionScreen extends GetView<ControlMissionController> {
  const ControlMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const HeaderMissionWidget(),
            const Divider(),
            const SizedBox(height: 20),
            GetBuilder<ControlMissionController>(
              builder: (_) {
                if (controller.isLodingGetEducationYears) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.optionsEducationYear.isEmpty) {
                  return const Text('No items available');
                }

                return MultiSelectDropDownView(
                  hintText: "Select Education Year",
                  onOptionSelected: (selectedItem) {
                    controller.setSelectedItemEducationYear(selectedItem);
                  },
                  showChipSelect: false,
                  options: controller.optionsEducationYear,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
