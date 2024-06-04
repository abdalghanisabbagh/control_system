import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../domain/controllers/index.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/assets_manager.dart';
import '../../resource_manager/index.dart';
import '../base_screen.dart';
import "add_subjects_to_cohort.dart";
import "widgets/add_cohort_widget.dart";

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
                    InkWell(
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
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: controller.getAllLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 50,
                                          ),
                                          child: Container(
                                            height: 250,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 20,
                                                  offset: const Offset(
                                                    2,
                                                    15,
                                                  ), // changes position of shadow
                                                ),
                                              ],
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                11,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name ?? "no name",
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                      fontSize: 35,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Text(
                                                  //     controller
                                                  //         .selectedSchool
                                                  //         .name,
                                                  //     style:                                                       .nunitoReguler
                                                  //         .copyWith(
                                                  //             color: ColorManager
                                                  //                 .bgSideMenu,
                                                  //             fontSize:
                                                  //                 20)),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .6,
                                                    height: 50,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: item
                                                          .cohortsSubjects!
                                                          .cohortHasSubjects!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            item
                                                                .cohortsSubjects!
                                                                .cohortHasSubjects![
                                                                    index]
                                                                .subjects!
                                                                .name!,
                                                            style: nunitoRegular
                                                                .copyWith(
                                                                    color: ColorManager
                                                                        .bgSideMenu,
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          MyDialogs.showDialog(
                                                            context,
                                                            AddSubjectsToCohort(
                                                              item: item,
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorManager
                                                                .glodenColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                "Add subjects",
                                                                style: nunitoBold
                                                                    .copyWith(
                                                                  color:
                                                                      ColorManager
                                                                          .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          MyAwesomeDialogue(
                                                            title:
                                                                'You are bout to delete this cohort',
                                                            desc:
                                                                'Are you sure ?',
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            btnOkOnPressed: () {
                                                              controller
                                                                  .deleteCohort(
                                                                      item.iD!)
                                                                  .then(
                                                                (value) {
                                                                  value
                                                                      ? MyFlashBar.showSuccess(
                                                                              'Cohort deleted successfully',
                                                                              'Success')
                                                                          .show(
                                                                              context)
                                                                      : null;
                                                                },
                                                              );
                                                            },
                                                            btnCancelOnPressed:
                                                                () {
                                                              Get.back();
                                                            },
                                                          ).showDialogue(
                                                              context);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                "Delete Cohort",
                                                                style: nunitoBold
                                                                    .copyWith(
                                                                  color:
                                                                      ColorManager
                                                                          .white,
                                                                  fontSize: 16,
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
                                          right: 100,
                                          bottom: 150,
                                          child: Image.asset(
                                            AssetsManager.assetsIconsArabic,
                                            fit: BoxFit.fill,
                                            height: 200,
                                            width: 200,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
