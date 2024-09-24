import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../Data/Models/subject/subject_res_model.dart';
import '../../../../domain/controllers/subject/edit_subject_controller.dart';
import '../../../../domain/controllers/subject/operation_controller.dart';
import '../../../../domain/controllers/subject/subject_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';

class EditOperationWidget extends GetView<EditSubjectsController> {
  final SubjectResModel subjectResModel;

  const EditOperationWidget({super.key, required this.subjectResModel});

  @override
  Widget build(BuildContext context) {
    controller.initialSelectedSchoolTypeIds.assignAll(subjectResModel
        .schoolTypeHasSubjectsResModel!.schooltypeHasSubjects!
        .map((e) => e.schoolType!.iD!)
        .toList());
    final TextEditingController subjectNameController = TextEditingController()
      ..text = subjectResModel.name ?? '';
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GetBuilder<EditSubjectsController>(builder: (_) {
      if (controller.getSchoolTypeLoading) {
        return SizedBox(
          width: 530,
          height: 510,
          child: Center(
            child: LoadingIndicators.getLoadingIndicator(),
          ),
        );
      }
      return SizedBox(
        height: 530,
        width: 500,
        child: GetBuilder<EditSubjectsController>(
          builder: (_) {
            controller.schoolsType.removeWhere((e) => subjectResModel
                .schoolTypeHasSubjectsResModel!.schooltypeHasSubjects!
                .map((e) => e.schoolType!.name)
                .contains(e.name!));
            return controller.getAllLoading
                ? Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  )
                : Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Edit Subject",
                            style: nunitoSemiBoldStyle().copyWith(
                              color: ColorManager.bgSideMenu,
                              fontSize: 25,
                            ),
                          ),
                          const Divider(),
                          TextFormField(
                            controller: subjectNameController,
                            cursorColor: ColorManager.bgSideMenu,
                            style: nunitoRegular.copyWith(
                                fontSize: 14, color: ColorManager.bgSideMenu),
                            decoration: InputDecoration(
                              hintText: "Subject name",
                              hintStyle: nunitoRegular.copyWith(
                                  fontSize: 14, color: ColorManager.bgSideMenu),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Subject name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          controller.schoolsType.isEmpty
                              ? Text(
                                  'All School Types Selected',
                                  style: nunitoSemiBoldStyle().copyWith(
                                    color: ColorManager.bgSideMenu,
                                  ),
                                )
                              : MultiSelectDropDownView(
                                  hintText: "Select Schools Type",
                                  options: controller.schoolsType
                                      .map((e) => ValueItem(
                                          label: e.name!, value: e.iD!))
                                      .toList(),
                                  onOptionSelected: controller.onOptionSelected,
                                  multiSelect: true,
                                  showChipSelect: true,
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          GetBuilder<EditSubjectsController>(
                            builder: (_) {
                              return InkWell(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    await controller
                                        .editSubject(
                                            id: subjectResModel.iD!,
                                            name: subjectNameController.text,
                                            schholTypeIds: controller
                                                .selectedSchoolTypeIds,
                                            inexam: subjectResModel.inExam!,
                                            active: subjectResModel.active!)
                                        .then(
                                          (value) => value
                                              ? {
                                                  Get.back(),
                                                  MyFlashBar.showSuccess(
                                                          "Subjects Updated",
                                                          "Success")
                                                      .show(context.mounted
                                                          ? context
                                                          : Get.key
                                                              .currentContext!),
                                                  Get.delete<
                                                      EditSubjectsController>(),
                                                  Get.find<SubjectsController>()
                                                      .getAllSubjects(),
                                                  Get.find<
                                                          OperationController>()
                                                      .getAllSubjects(),
                                                  controller.onDelete()
                                                }
                                              : null,
                                        );
                                  }
                                },
                                child: controller.editLoading
                                    ? SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Center(
                                          child: LoadingIndicators
                                              .getLoadingIndicator(),
                                        ),
                                      )
                                    : Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: ColorManager.glodenColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Edit Subjects",
                                            style: nunitoRegular.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: ListView.builder(
                              itemCount: subjectResModel
                                  .schoolTypeHasSubjectsResModel!
                                  .schooltypeHasSubjects!
                                  .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        subjectResModel
                                            .schoolTypeHasSubjectsResModel!
                                            .schooltypeHasSubjects![index]
                                            .schoolType!
                                            .name!,
                                        style: nunitoRegular.copyWith(
                                            color: Colors.black),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          controller
                                              .deleteSchoolTypeInSubject(
                                                idSubject: subjectResModel.iD!,
                                                idSchoolType: subjectResModel
                                                    .schoolTypeHasSubjectsResModel!
                                                    .schooltypeHasSubjects![
                                                        index]
                                                    .schoolType!
                                                    .iD!,
                                              )
                                              .then(
                                                (value) => value
                                                    ? {
                                                        Get.back(),
                                                        MyFlashBar.showSuccess(
                                                                "School Type Deleted In Subject",
                                                                "Success")
                                                            .show(context
                                                                    .mounted
                                                                ? context
                                                                : Get.key
                                                                    .currentContext!),
                                                        Get.delete<
                                                            EditSubjectsController>(),
                                                        Get.find<
                                                                SubjectsController>()
                                                            .getAllSubjects(),
                                                        Get.find<
                                                                OperationController>()
                                                            .getAllSubjects(),
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
                          Row(
                            children: [
                              Text(
                                "InExam  ",
                                style: nunitoBoldStyle().copyWith(
                                    color: ColorManager.bgSideMenu,
                                    fontSize: 25),
                              ),
                              GetBuilder<EditSubjectsController>(builder: (_) {
                                return Checkbox(
                                  value: subjectResModel.inExam == 1
                                      ? true
                                      : false,
                                  onChanged: (newVal) {
                                    subjectResModel.inExam = newVal! ? 1 : 0;
                                    controller.update();
                                  },
                                );
                              }),
                              SizedBox(
                                width: Get.width * 0.05,
                              ),
                              Text(
                                "Active",
                                style: nunitoBoldStyle().copyWith(
                                    color: ColorManager.bgSideMenu,
                                    fontSize: 25),
                              ),
                              GetBuilder<EditSubjectsController>(builder: (_) {
                                return Checkbox(
                                  value: subjectResModel.active == 1
                                      ? true
                                      : false,
                                  onChanged: (newVal) {
                                    subjectResModel.active = newVal! ? 1 : 0;
                                    controller.update();
                                  },
                                );
                              })
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Get.delete<EditSubjectsController>();
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
                      ),
                    ),
                  );
          },
        ),
      );
    });
  }
}
