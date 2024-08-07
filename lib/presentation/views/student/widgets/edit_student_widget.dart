import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../Data/Models/student/student_res_model.dart';
import '../../../../domain/controllers/students_controllers/student_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class EditStudentWidget extends GetView<StudentController> {
  final TextEditingController blbIdController = TextEditingController();

  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController sLangController = TextEditingController();
  final StudentResModel studentResModel;
  EditStudentWidget({
    super.key,
    required this.studentResModel,
  });

  @override
  Widget build(BuildContext context) {
    controller.selectedItemGrade = controller.optionsGrade
        .firstWhere((element) => element.value == studentResModel.gradesID);
    controller.selectedItemCohort = controller.optionsCohort
        .firstWhere((element) => element.value == studentResModel.cohortID);
    controller.selectedItemClassRoom = controller.optionsClassRoom.firstWhere(
        (element) => element.value == studentResModel.schoolClassID);
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: GetBuilder<StudentController>(
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: IconButton(
                    alignment: AlignmentDirectional.topEnd,
                    color: Colors.black,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Text(
                  "Edit student",
                  style: nunitoBold.copyWith(
                    color: ColorManager.primary,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<StudentController>(
                  builder: (controller) {
                    if (controller.loading) {
                      return LoadingIndicators.getLoadingIndicator();
                    }

                    if (controller.optionsCohort.isEmpty) {
                      return const Text('No items available');
                    }

                    return Column(
                      children: [
                        SizedBox(
                          width: 500,
                          child: FormField(
                            validator: Validations
                                .multiSelectDropDownRequiredValidator,
                            builder: (formFieldState) {
                              return Column(
                                children: [
                                  MultiSelectDropDownView(
                                    onOptionSelected: (selectedItem) {
                                      controller
                                          .setSelectedItemGrade(selectedItem);
                                      formFieldState.didChange(selectedItem);
                                    },
                                    options: controller.optionsGrade,
                                    optionSelected: [
                                      controller.optionsGrade.firstWhereOrNull(
                                            (element) =>
                                                element.value ==
                                                studentResModel.gradesID,
                                          ) ??
                                          controller.optionsGrade.first
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (formFieldState.hasError)
                                    Text(
                                      formFieldState.errorText!,
                                      style: nunitoRegular.copyWith(
                                        fontSize: FontSize.s10,
                                        color: ColorManager.error,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 500,
                          child: FormField(
                            validator: Validations
                                .multiSelectDropDownRequiredValidator,
                            builder: (formFieldState) {
                              return Column(
                                children: [
                                  MultiSelectDropDownView(
                                    onOptionSelected: (selectedItem) {
                                      controller
                                          .setSelectedItemCohort(selectedItem);
                                      formFieldState.didChange(selectedItem);
                                    },
                                    options: controller.optionsCohort,
                                    optionSelected: [
                                      controller.optionsCohort.firstWhereOrNull(
                                            (element) =>
                                                element.value ==
                                                studentResModel.cohortID,
                                          ) ??
                                          controller.optionsCohort.first,
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (formFieldState.hasError)
                                    Text(
                                      formFieldState.errorText!,
                                      style: nunitoRegular.copyWith(
                                        fontSize: FontSize.s10,
                                        color: ColorManager.error,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 500,
                          child: FormField(
                            validator: Validations
                                .multiSelectDropDownRequiredValidator,
                            builder: (formFieldState) {
                              return Column(
                                children: [
                                  MultiSelectDropDownView(
                                    onOptionSelected: (selectedItem) {
                                      controller.setSelectedItemClassRoom(
                                          selectedItem);
                                      formFieldState.didChange(selectedItem);
                                    },
                                    options: controller.optionsClassRoom,
                                    optionSelected: [
                                      controller.optionsClassRoom
                                              .firstWhereOrNull(
                                            (element) =>
                                                element.value ==
                                                studentResModel.schoolClassID,
                                          ) ??
                                          controller.optionsClassRoom.first,
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (formFieldState.hasError)
                                    Text(
                                      formFieldState.errorText!,
                                      style: nunitoRegular.copyWith(
                                        fontSize: FontSize.s10,
                                        color: ColorManager.error,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MytextFormFiled(
                    controller: fnameController
                      ..text = studentResModel.firstName.toString(),
                    title: "First Name",
                    myValidation: Validations.requiredValidator),
                MytextFormFiled(
                    controller: mnameController
                      ..text = studentResModel.secondName.toString(),
                    title: "Middle Name",
                    myValidation: Validations.requiredValidator),
                MytextFormFiled(
                    controller: lnameController
                      ..text = studentResModel.thirdName.toString(),
                    title: "Last Name",
                    myValidation: Validations.requiredValidator),
                MytextFormFiled(
                    controller: religionController
                      ..text = studentResModel.religion.toString(),
                    title: "Religion",
                    myValidation: Validations.requiredValidator),
                MytextFormFiled(
                    controller: citizenshipController,
                    title: "Citizenship",
                    myValidation: Validations.requiredValidator),
                MytextFormFiled(
                    controller: sLangController
                      ..text = studentResModel.secondLang.toString(),
                    title: "Second Language",
                    myValidation: Validations.requiredValidator),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<StudentController>(
                  builder: (_) {
                    return controller.islodingEditStudent
                        ? LoadingIndicators.getLoadingIndicator()
                        : InkWell(
                            onTap: () {
                              controller
                                  .patchEditStudent(
                                studentid: studentResModel.iD!,
                                gradesId: controller.selectedItemGrade!.value,
                                cohortId: controller.selectedItemCohort!.value,
                                schoolClassId:
                                    controller.selectedItemClassRoom!.value,
                                firstName: fnameController.text,
                                secondName: mnameController.text,
                                thirdName: lnameController.text,
                                secondLang: sLangController.text,
                                religion: religionController.text,
                              )
                                  .then(
                                (value) {
                                  value
                                      ? {
                                          context.pop(),
                                          MyFlashBar.showSuccess(
                                            "The Student has been Edited successfully",
                                            "Success",
                                          ).show(context),
                                        }
                                      : null;
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: ColorManager.bgSideMenu,
                                  borderRadius: BorderRadius.circular(11)),
                              child: Center(
                                child: Text(
                                  "Update",
                                  style: nunitoRegular.copyWith(
                                    color: ColorManager.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
