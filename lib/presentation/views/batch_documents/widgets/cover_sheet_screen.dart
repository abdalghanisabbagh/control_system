import 'package:control_system/presentation/views/batch_documents/widgets/cover_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/batch_documents.dart/cover_sheets_controller.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/index.dart';
import 'add_new_cover_widget.dart';

class CoverSheetsScreen extends GetView<CoversSheetsController> {
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
            GetBuilder<CoversSheetsController>(
              builder: (controller) {
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
            GetBuilder<CoversSheetsController>(
              builder: (controller) {
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
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            GetBuilder<CoversSheetsController>(
              builder: (controller) {
                if (controller.isLoading) {
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

                return SizedBox(
                  width: Get.width * 0.4,
                  child: MultiSelectDropDownView(
                    hintText: "Select Grade",
                    onOptionSelected: controller.setSelectedItemGrade,
                    options: controller.optionsGrades,
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            GetBuilder<CoversSheetsController>(
              builder: (controller) {
                if (controller.isLoading) {
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
                if (controller.optionsSubjects.isEmpty) {
                  return Text(
                    'No items available',
                    style: nunitoBoldStyle(),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 43.0),
                  child: SizedBox(
                    width: Get.width * 0.4,
                    child: MultiSelectDropDownView(
                      hintText: "Select Subject",
                      onOptionSelected: controller.setSelectedItemSubject,
                      options: controller.optionsSubjects,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        GetBuilder<CoversSheetsController>(
          builder: (controller) {
            if (controller.isLodingGetExamMission) {
              return Expanded(
                child: Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                ),
              );
            }

            if (controller.filteredExamMissionsList.isEmpty) {
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
                  itemCount: controller.filteredExamMissionsList.length,
                  itemBuilder: (context, index) {
                    return CoverWidget(
                      controlMissionObject: controller.controlMissionObject!,
                      examMissionObject:
                          controller.filteredExamMissionsList[index],
                    );
                  }),
            );
          },
        ),
      ],
    );
  }
}
