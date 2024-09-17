import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../Data/Models/school/school_type/schools_type_res_model.dart';
import '../../../../domain/controllers/cohorts_settings_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

class AddCohortWidget extends StatelessWidget {
  final bool isOperation;

  final SchoolsTypeResModel? schoolTypes;
  const AddCohortWidget(
      {super.key, this.isOperation = false, this.schoolTypes});

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    return SizedBox(
      width: 450,
      child: GetBuilder<CohortsSettingsController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add new Cohort",
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
              if (isOperation) ...[
                MultiSelectDropDownView(
                  multiSelect: false,
                  onOptionSelected: (value) {
                    controller.slectedSchoolTypeId =
                        value.map((e) => e.value! as int).toList();
                  },
                  options: schoolTypes!.data!
                      .map(
                        (e) => ValueItem(label: e.name!, value: e.iD),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              controller.addLoading
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
                          child: ElevatedAddButton(
                            onPressed: () async {
                              if (editingController.text != "") {
                                int found = controller.cohorts.indexWhere(
                                  (p0) => p0.name == editingController.text,
                                );
                                if (found > -1) {
                                } else {
                                  if (isOperation &&
                                      controller.slectedSchoolTypeId.isEmpty) {
                                    MyFlashBar.showError(
                                            "Please select School Type",
                                            "Error")
                                        .show(
                                      Get.key.currentContext!,
                                    );
                                    return;
                                  }
                                  controller
                                      .addnewCohort(editingController.text)
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
                                }
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
