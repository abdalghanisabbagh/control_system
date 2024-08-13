import 'dart:developer';

import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/cohorts_settings_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

class AddCohortWidget extends StatelessWidget {
  const AddCohortWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    return GetBuilder<CohortsSettingsController>(
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
                  fontSize: 14, color: ColorManager.bgSideMenu),
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
              onChanged: (value) {
                int found = controller.cohorts.indexWhere(
                  (p0) => p0.name == value,
                );
                if (found > -1) {
                  log('founded');
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
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
                                log('founded');
                              } else {
                                controller
                                    .addnewCohort(editingController.text)
                                    .then(
                                  (value) {
                                    value
                                        ? {
                                            context.mounted
                                                ? context.pop()
                                                : null,
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
                                  "enter cohort name", "Error");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
