import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../Data/Models/cohort/cohort_res_model.dart';
import '../../../domain/controllers/cohorts_settings_controller.dart';
import '../../../domain/controllers/operation_cohort_controller.dart';
import '../../../domain/controllers/subject/subject_controller.dart';
import '../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../resource_manager/ReusableWidget/show_dialogue.dart';

class AddSubjectsToCohort extends GetView<CohortsSettingsController> {
  final CohortResModel item;

  const AddSubjectsToCohort({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 510,
      width: 500,
      child: GetBuilder<SubjectsController>(
        init: SubjectsController(),
        builder: (subjectController) {
          subjectController.subjects.removeWhere((e) => item
              .cohortsSubjects!.cohortHasSubjects!
              .map((e) => e.subjects!.iD)
              .contains(e.iD));
          return subjectController.getAllLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${item.name}',
                      style: nunitoBold.copyWith(
                          color: ColorManager.primary, fontSize: 20),
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
                      showChipSelect: true,
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
                                    .addNewSubjectsToCohort(item.iD!)
                                    .then(
                                      (value) => value
                                          ? {
                                              Get.back(),
                                              MyFlashBar.showSuccess(
                                                      "Subjects Added Successfully",
                                                      "Success")
                                                  .show(context.mounted
                                                      ? context
                                                      : Get
                                                          .key.currentContext!),
                                              Get.find<
                                                      OperationCohortController>()
                                                  .onInit(),
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
                              ? SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child:
                                        LoadingIndicators.getLoadingIndicator(),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorManager.glodenColor,
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
                      width: 400,
                      child: ListView.builder(
                        itemCount:
                            item.cohortsSubjects!.cohortHasSubjects!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.cohortsSubjects!.cohortHasSubjects![index]
                                    .subjects!.name!,
                                style:
                                    nunitoRegular.copyWith(color: Colors.black),
                              ),
                              GetBuilder<CohortsSettingsController>(
                                id: "delete_${item.iD}_${item.cohortsSubjects!.cohortHasSubjects![index].subjects!.iD}",
                                builder: (_) {
                                  return controller.deleteSubjectLoading
                                      ? FittedBox(
                                          fit: BoxFit.fill,
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Center(
                                              child: LoadingIndicators
                                                  .getLoadingIndicator(),
                                            ),
                                          ),
                                        )
                                      : IconButton(
                                          tooltip: "Delete",
                                          onPressed: () async {
                                            await controller
                                                .deleteSubjectFromCohort(
                                                    cohortId: item.iD!,
                                                    subjectId: item
                                                        .cohortsSubjects!
                                                        .cohortHasSubjects![
                                                            index]
                                                        .subjects!
                                                        .iD!)
                                                .then(
                                                  (value) => value
                                                      ? {
                                                          Get.back(),
                                                          MyFlashBar.showSuccess(
                                                                  "Subject Deleted Successfully",
                                                                  "Success")
                                                              .show(context
                                                                      .mounted
                                                                  ? context
                                                                  : Get.key
                                                                      .currentContext!),
                                                          Get.find<
                                                                  OperationCohortController>()
                                                              .onInit()
                                                        }
                                                      : null,
                                                );
                                          },
                                          icon: const Icon(Icons.delete),
                                        );
                                },
                              ),
                            ],
                          ).paddingOnly(right: 20);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: double.infinity,
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
                    ),
                  ],
                );
        },
      ),
    );
  }
}
