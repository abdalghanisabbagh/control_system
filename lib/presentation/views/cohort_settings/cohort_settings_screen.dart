import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/controllers/cohorts_settings_controller.dart';
import '../../../domain/controllers/profile_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../base_screen.dart';
import "widgets/add_cohort_widget.dart";
import 'widgets/cohorts_widget.dart';

class CohortSettingsScreen extends GetView<CohortsSettingsController> {
  const CohortSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: GetBuilder<CohortsSettingsController>(
        builder: (_) {
          return Container(
            color: ColorManager.bgColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cohorts",
                      style: nunitoBlack.copyWith(
                        color: ColorManager.bgSideMenu,
                        fontSize: 30,
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: Get.find<ProfileController>().canAccessWidget(
                        widgetId: '7400',
                      ),
                      child: Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            context.goNamed(
                              AppRoutesNamesAndPaths.operationCohortScreenName,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.bgSideMenu,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Operation",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.01),
                    Visibility(
                      visible: Get.find<ProfileController>().canAccessWidget(
                        widgetId: '8100',
                      ),
                      child: InkWell(
                        onTap: () {
                          MyDialogs.showDialog(
                            context,
                            const AddCohortWidget(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.glodenColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Add Cohorts",
                                style: nunitoBold.copyWith(
                                  color: ColorManager.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Expanded(
                  child: CohortsWidget(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
