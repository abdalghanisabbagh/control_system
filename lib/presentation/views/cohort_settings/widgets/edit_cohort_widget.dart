import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';

class EditCohortWidget extends GetView<OperationCohortController> {
  final CohortResModel cohort;

  const EditCohortWidget({
    super.key,
    required this.cohort,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController =
        TextEditingController(text: cohort.name);
    return SizedBox(
      width: 450,
      child: GetBuilder<CohortsSettingsController>(
        builder: (cohortSettingsController) {
          cohortSettingsController.slectedSchoolTypeId = controller
              .schoolsType!.data!
              .where((element) => element.iD == cohort.schoolTypeID)
              .map((element) => element.iD!)
              .toList();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Cohort",
                style: nunitoRegular.copyWith(
                  color: ColorManager.bgSideMenu,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: ColorManager.bgSideMenu,
                style: nunitoRegular.copyWith(
                  fontSize: 14,
                  color: ColorManager.bgSideMenu,
                ),
                decoration: InputDecoration(
                  hintText: "Cohort name",
                  hintStyle: nunitoRegular.copyWith(
                    fontSize: 14,
                    color: ColorManager.bgSideMenu,
                  ),
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
                controller: editingController,
              ),
              const SizedBox(
                height: 20,
              ),
              MultiSelectDropDownView(
                multiSelect: false,
                optionSelected: controller.schoolsType!.data!
                    .where((element) => element.iD == cohort.schoolTypeID)
                    .map((element) =>
                        ValueItem(label: element.name!, value: element.iD))
                    .toList(),
                onOptionSelected: (value) {
                  cohortSettingsController.slectedSchoolTypeId =
                      value.map((e) => e.value! as int).toList();
                },
                options: controller.schoolsType!.data!
                    .map(
                      (e) => ValueItem(label: e.name!, value: e.iD),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              cohortSettingsController.addLoading
                  ? LoadingIndicators.getLoadingIndicator()
                  : Row(
                      children: [
                        const Expanded(
                          child: ElevatedBackButton(),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedEditButton(
                            onPressed: () async {
                              if (editingController.text != "") {
                                if (cohortSettingsController
                                    .slectedSchoolTypeId.isEmpty) {
                                  MyFlashBar.showError(
                                          "Please select School Type", "Error")
                                      .show(
                                    Get.key.currentContext!,
                                  );
                                  return;
                                }
                                cohortSettingsController
                                    .editCohort(
                                  cohort.iD!,
                                  editingController.text,
                                  cohortSettingsController
                                      .slectedSchoolTypeId.firstOrNull,
                                )
                                    .then(
                                  (value) {
                                    value
                                        ? {
                                            Get.key.currentContext!.pop(),
                                            MyFlashBar.showSuccess(
                                              "The Cohort has been added successfully",
                                              "Success",
                                            ).show(context.mounted
                                                ? context
                                                : Get.key.currentContext!),
                                          }
                                        : null;
                                  },
                                );
                              } else {
                                MyFlashBar.showError(
                                        "Enter cohort name", "Error")
                                    .show(
                                  Get.key.currentContext!,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
