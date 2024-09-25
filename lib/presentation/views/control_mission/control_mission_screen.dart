import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/control_mission/control_mission_controller.dart';
import '../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../base_screen.dart';
import 'widgets/control_mission_review_widget.dart';
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
                if (controller.isLoadingGetEducationYears) {
                  return Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  );
                }
                if (controller.optionsEducationYear.isEmpty) {
                  return Text('No Education Year Available',
                      style: nunitoRegular.copyWith(
                        fontSize: 30,
                        color: ColorManager.primary,
                      ));
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
            GetBuilder<ControlMissionController>(
              builder: (_) {
                if (controller.selectedItemEducationYear != null &&
                    controller.controlMissionList.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MyTextFormFiled(
                      title: 'Search by Name',
                      onChanged: (query) {
                        controller.updateSearchQuery(query ?? '');
                        return query;
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
            GetBuilder<ControlMissionController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return Expanded(
                    child: Center(
                      child: LoadingIndicators.getLoadingIndicator(),
                    ),
                  );
                }
                if (controller.filteredControlMissionList.isEmpty &&
                    controller.selectedItemEducationYear != null) {
                  return Text(
                    'No items available',
                    style: nunitoRegular.copyWith(
                      color: ColorManager.bgSideMenu,
                      fontSize: 23,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredControlMissionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ControlMissionReviewWidget(
                        controlMission:
                            controller.filteredControlMissionList[index],
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
