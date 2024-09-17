import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../../domain/controllers/cohorts_settings_controller.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../add_subjects_to_cohort.dart';

class CohortsWidget extends GetView<CohortsSettingsController> {
  const CohortsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CohortsSettingsController>(
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: controller.getAllLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : controller.cohorts.isEmpty
                  ? Center(
                      child: Text(
                        "Please Add Cohorts",
                        style: nunitoBold.copyWith(
                          color: ColorManager.bgSideMenu,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : SearchableList<CohortResModel>(
                      inputDecoration: const InputDecoration(
                        label: Text(
                          'Search by name',
                        ),
                      ),
                      initialList: controller.cohorts,
                      emptyWidget: Center(
                        child: Text(
                          "No data found",
                          style: nunitoBold.copyWith(
                            color: ColorManager.bgSideMenu,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      filter: (value) => controller.cohorts
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList(),
                      itemBuilder: (CohortResModel item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                  height: 180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(2, 8),
                                      ),
                                    ],
                                    color: ColorManager.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name ?? "no name",
                                          style: nunitoBold.copyWith(
                                            color: ColorManager.bgSideMenu,
                                            fontSize: 28,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: item.cohortsSubjects!
                                                .cohortHasSubjects!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Text(
                                                  item
                                                      .cohortsSubjects!
                                                      .cohortHasSubjects![index]
                                                      .subjects!
                                                      .name!,
                                                  style: nunitoRegular.copyWith(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                      fontSize: 14),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Visibility(
                                              visible:
                                                  Get.find<ProfileController>()
                                                      .canAccessWidget(
                                                          widgetId: '8300'),
                                              child: InkWell(
                                                onTap: () {
                                                  MyDialogs.showDialog(
                                                    context,
                                                    AddSubjectsToCohort(
                                                      item: item,
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .glodenColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        "Add subjects",
                                                        style:
                                                            nunitoBold.copyWith(
                                                          color: ColorManager
                                                              .white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Visibility(
                                              visible:
                                                  Get.find<ProfileController>()
                                                      .canAccessWidget(
                                                          widgetId: '8200'),
                                              child: InkWell(
                                                onTap: () {
                                                  MyAwesomeDialogue(
                                                    title:
                                                        'You are bout to delete this cohort',
                                                    desc: 'Are you sure ?',
                                                    dialogType:
                                                        DialogType.warning,
                                                    btnOkOnPressed: () {
                                                      controller
                                                          .deleteCohort(
                                                              item.iD!)
                                                          .then((value) {
                                                        value
                                                            ? MyFlashBar.showSuccess(
                                                                    'Cohort deleted successfully',
                                                                    'Success')
                                                                .show(context
                                                                        .mounted
                                                                    ? context
                                                                    : Get.key
                                                                        .currentContext!)
                                                            : null;
                                                      });
                                                    },
                                                    btnCancelOnPressed: () {
                                                      Get.back();
                                                    },
                                                  ).showDialogue(context);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        "Delete Cohort",
                                                        style:
                                                            nunitoBold.copyWith(
                                                          color: ColorManager
                                                              .white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: Get.width * 0.05,
                                bottom: 60,
                                child: Image.asset(
                                  AssetsManager.assetsIconsArabic,
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
