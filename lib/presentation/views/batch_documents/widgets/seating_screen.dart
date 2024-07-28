import 'package:control_system/domain/controllers/batch_documents.dart/seat_number_controller.dart';
import 'package:control_system/presentation/views/batch_documents/widgets/seat_number_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/index.dart';

class SeatingScreen extends GetView<SeatNumberController> {
  const SeatingScreen({super.key});

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
                  "Seat Numbers ",
                  style: nunitoBoldStyle()
                      .copyWith(fontSize: 30, color: ColorManager.bgSideMenu),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<SeatNumberController>(
          builder: (_) {
            if (controller.isLoadingGetEducationYear) {
              return Center(
                child: SizedBox(
                  width: Get.width * 0.4,
                  height: 50,
                  child: FittedBox(
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                ),
              );
            }

            if (controller.optionsEducationYear.isEmpty) {
              return const Text('No items available');
            }

            return MultiSelectDropDownView(
              hintText: "Select Education Year",
              onOptionSelected: controller.setSelectedItemEducationYear,
              options: controller.optionsEducationYear,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<SeatNumberController>(
          builder: (_) {
            if (controller.isLoadingGetControlMission) {
              return Center(
                child: SizedBox(
                  width: Get.width * 0.4,
                  height: 50,
                  child: FittedBox(
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                ),
              );
            }
            if (controller.selectedItemEducationYear == null) {
              return const SizedBox.shrink();
            }
            if (controller.optionsControlMission.isEmpty) {
              return Text(
                'No items available',
                style: nunitoBoldStyle(),
              );
            }

            return MultiSelectDropDownView(
              hintText: "Select Control Mission",
              onOptionSelected: (selectedItem) {
                controller.setSelectedItemControlMission(selectedItem);
              },
              options: controller.optionsControlMission,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<SeatNumberController>(
          builder: (_) {
            if (controller.isLoadingGrades) {
              return Center(
                child: SizedBox(
                  width: Get.width * 0.4,
                  height: 50,
                  child: FittedBox(
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                ),
              );
            }
            if (controller.selectedItemEducationYear == null ||
                controller.selectedItemControlMission == null) {
              return const SizedBox.shrink();
            }
            if (controller.optionsGrades.isEmpty) {
              return Text(
                'No items available',
                style: nunitoBoldStyle(),
              );
            }

            return MultiSelectDropDownView(
              hintText: "Select Grade",
              onOptionSelected: (selectedItem) {
                controller.setSelectedItemGrade(selectedItem);
              },
              options: controller.optionsGrades,
            );
          },
        ),
        GetBuilder<SeatNumberController>(
          builder: (controller) {
            if (controller.isLodingGetExamMission) {
              return Expanded(
                child: Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                ),
              );
            }

            if (controller.filteredGradesList.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'No items available',
                    style: nunitoBoldStyle(),
                  ),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: controller.filteredGradesList.length,
                itemBuilder: (context, index) {
                  return GetBuilder<SeatNumberController>(
                      id: controller.filteredGradesList[index].iD,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CoverSeatNumberWidget(
                            controlMissionObject:
                                controller.controlMissionObject!,
                            gradeObject: controller.filteredGradesList[index],
                          ),
                        );
                      });
                },
              ),
            );
          },
        )
      ],
    );
  }
}
