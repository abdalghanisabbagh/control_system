import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../domain/controllers/cohorts_settings_controller.dart';
import '../../../domain/controllers/subject_controller.dart';
import '../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';

class AddSubjectsToCohort extends GetView<CohortsSettingsController> {
  const AddSubjectsToCohort({super.key, required this.item});

  final CohortResModel item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 510,
      width: 300,
      child: GetBuilder<SubjectsController>(
        init: SubjectsController(),
        builder: (subjectController) {
          subjectController.subjects.removeWhere((e) => item
              .cohortsSubjects!.cohortHasSubjects!
              .map((e) => e.subjects!.iD)
              .contains(e.iD));
          return subjectController.getAllLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name!,
                    ),
                    const Divider(),
                    MultiSelectDropDownView(
                      hintText: "Select Subjects",
                      searchEnabled: true,
                      options: subjectController.subjects
                          .map((e) => ValueItem(label: e.name!, value: e.iD!))
                          .toList(),
                      onOptionSelected: controller.onOptionSelected,
                      multiSelect: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GetBuilder<CohortsSettingsController>(
                      builder: (_) {
                        return InkWell(
                          onTap: () async {
                            controller.selectedSubjectsIds.isNotEmpty
                                ? await controller
                                    .addNewsubjecstToCohort(item.iD!)
                                    .then(
                                      (value) => value
                                          ? {
                                              Get.back(),
                                              MyFlashBar.showSuccess(
                                                      "Subjects Added Successfully",
                                                      "Success")
                                                  .show(context)
                                            }
                                          : null,
                                    )
                                : MyAwesomeDialogue(
                                    title: "No Subjects Selected",
                                    desc: "Please Select Atleast One Subject",
                                    dialogType: DialogType.error,
                                  ).showDialogue(context);
                          },
                          child: controller.addLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorManager.bgSideMenu,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add Subjects",
                                      style: nunitoRegular.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 300,
                      width: 200,
                      child: ListView.builder(
                        itemCount:
                            item.cohortsSubjects!.cohortHasSubjects!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item
                                      .cohortsSubjects!
                                      .cohortHasSubjects![index]
                                      .subjects!
                                      .name!,
                                  style: nunitoRegular.copyWith(
                                      color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await controller
                                        .deleteSubjectFromCohort(
                                            cohortId: item.iD!,
                                            subjectId: item
                                                .cohortsSubjects!
                                                .cohortHasSubjects![index]
                                                .subjects!
                                                .iD!)
                                        .then(
                                          (value) => value
                                              ? {
                                                  Get.back(),
                                                  MyFlashBar.showSuccess(
                                                          "Subject Deleted Successfully",
                                                          "Success")
                                                      .show(context)
                                                }
                                              : null,
                                        );
                                  },
                                  icon: const Icon(Icons.delete),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.bgSideMenu,
                        ),
                        child: Center(
                          child: Text(
                            "Back",
                            style: nunitoRegular.copyWith(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
