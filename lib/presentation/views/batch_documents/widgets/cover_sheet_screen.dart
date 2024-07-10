import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/profile_controller.dart';
import '../../../../domain/controllers/seating_numbers_controllers/create_covers_sheets_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/index.dart';
import 'add_new_cover_widget.dart';

class CoverSheetsScreen extends GetView<CreateCoversSheetsController> {
  const CoverSheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Cover Sheet",
                  style: nunitoBoldStyle().copyWith(fontSize: 30),
                ),
              ),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '3100',
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    MyDialogs.showDialog(context, AddNewCoverWidget());
                  },
                  tooltip: "Add New Cover",
                  icon: const Icon(
                    Icons.add,
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GetBuilder<CreateCoversSheetsController>(
              builder: (controller) {
                if (controller.isLoadingGetEducationYear) {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: FittedBox(
                      child: LoadingIndicators.getLoadingIndicator(),
                    ),
                  );
                }

                if (controller.optionsEducationYear.isEmpty) {
                  return const Text('No items available');
                }

                return SizedBox(
                  width: Get.width * 0.4,
                  child: MultiSelectDropDownView(
                    hintText: "Select Education Year",
                    onOptionSelected: controller.setSelectedItemEducationYear,
                    options: controller.optionsEducationYear,
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            GetBuilder<CreateCoversSheetsController>(
              builder: (controller) {
                if (controller.isLoadingGetControlMission) {
                  return Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  );
                }

                if (controller.optionsControlMission.isEmpty) {
                  return const Text('No items available');
                }
                if (controller.selectedItemEducationYear == null) {
                  return const SizedBox.shrink();
                }

                return SizedBox(
                  width: Get.width * 0.4,
                  child: MultiSelectDropDownView(
                    hintText: "Select Control Mission",
                    onOptionSelected: (selectedItem) {
                      controller.setSelectedItemControlMission(selectedItem);
                    },
                    options: controller.optionsControlMission,
                  ),
                );
              },
            ),
          ],
        ),
        
      ],
    );
  }
}
