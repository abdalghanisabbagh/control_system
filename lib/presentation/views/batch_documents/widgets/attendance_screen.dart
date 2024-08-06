import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/batch_documents.dart/attendance_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

class AttendanceScreen extends GetView<AttendanceController> {
  const AttendanceScreen({super.key});

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
                  "Attendance",
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
        // const HeaderCoverWidget(text: "Attendance"),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<AttendanceController>(
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
        GetBuilder<AttendanceController>(
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
        GetBuilder<AttendanceController>(
          builder: (_) {
            if (controller.isLoadingGetExamRoom) {
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
            if (controller.optionsExamRoom.isEmpty) {
              return Text(
                'No items available',
                style: nunitoBoldStyle(),
              );
            }

            return MultiSelectDropDownView(
              hintText: "Select Exam Room",
              onOptionSelected: (selectedItem) {
                controller.setSelectedItemExamRoom(selectedItem);
              },
              options: controller.optionsExamRoom,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<AttendanceController>(
          builder: (_) {
            if (controller.selectedItemExamRoom == null) {
              return const SizedBox.shrink();
            }
            if (controller.isLoadingGeneratePdf) {
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: FittedBox(
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                ),
              );
            }

            return InkWell(
              onTap: () {
                controller.generatePdfAttendance(
                    roomId: controller.selectedItemExamRoom!.value);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: ColorManager.bgSideMenu,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Generate Attendance"),
                    const SizedBox(width: 20),
                    Icon(Icons.print, color: ColorManager.white),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
