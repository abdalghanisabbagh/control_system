import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/students_controllers/add_new_student_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class AddSingleStudentWidget extends GetView<AddNewStudentController> {
  final TextEditingController blbIdController = TextEditingController();

  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController secondLanguageController =
      TextEditingController();
  final TextEditingController secondNameController = TextEditingController();

  final TextEditingController thirdNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddSingleStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: GetBuilder<AddNewStudentController>(
            builder: (_) {
              return controller.isLoading
                  ? Center(
                      child: LoadingIndicators.getLoadingIndicator(),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            tooltip: 'Close',
                            alignment: AlignmentDirectional.topEnd,
                            color: Colors.black,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        Text(
                          "Add New Student",
                          style: nunitoBold.copyWith(
                            color: ColorManager.primary,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // grades

                        Column(
                          children: [
                            FormField<List<ValueItem<dynamic>>>(
                              validator: Validations
                                  .multiSelectDropDownRequiredValidator,
                              builder: (formFieldState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 500,
                                      child: MultiSelectDropDownView(
                                        searchEnabled: true,
                                        hintText: "Select Grade",
                                        onOptionSelected: (selectedItem) {
                                          controller.selectedItemGrade =
                                              selectedItem.isNotEmpty
                                                  ? selectedItem.first
                                                  : null;
                                          formFieldState
                                              .didChange(selectedItem);
                                        },
                                        options: controller.optionsGrades,
                                      ),
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
                            const SizedBox(
                              height: 10,
                            ),
                            FormField<List<ValueItem<dynamic>>>(
                              validator: Validations
                                  .multiSelectDropDownRequiredValidator,
                              builder: (formFieldState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 500,
                                      child: MultiSelectDropDownView(
                                        hintText: "Select Cohort",
                                        searchEnabled: true,
                                        onOptionSelected: (selectedItem) {
                                          controller.selectedItemCohort =
                                              selectedItem.isNotEmpty
                                                  ? selectedItem.first
                                                  : null;
                                          formFieldState
                                              .didChange(selectedItem);
                                        },
                                        options: controller.optionsCohort,
                                      ),
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
                            const SizedBox(
                              height: 10,
                            ),
                            FormField<List<ValueItem<dynamic>>>(
                              validator: (value) {
                                if (controller.selectedItemClassRoom == null) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              builder: (formFieldState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 500,
                                      child: MultiSelectDropDownView(
                                        searchEnabled: true,
                                        hintText: "Select Class Room",
                                        onOptionSelected: (selectedItem) {
                                          controller.selectedItemClassRoom =
                                              selectedItem.isNotEmpty
                                                  ? selectedItem.first
                                                  : null;
                                          formFieldState
                                              .didChange(selectedItem);
                                        },
                                        options: controller.optionsClassRoom,
                                      ),
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
                          ],
                        ),

                        MyTextFormFiled(
                          controller: blbIdController,
                          title: "BLB ID",
                          isNumber: true,
                          myValidation: Validations.validatorBlbId,
                        ),

                        MyTextFormFiled(
                          controller: firstNameController,
                          title: "First Name",
                          myValidation: Validations.validateName,
                        ),

                        MyTextFormFiled(
                          controller: secondNameController,
                          title: "Second Name",
                          myValidation: Validations.validateName,
                        ),

                        MyTextFormFiled(
                          controller: thirdNameController,
                          title: "Third Name",
                          myValidation: Validations.validateNoSpecialCharacters,
                        ),

                        MyTextFormFiled(
                          controller: religionController,
                          title: "Religion",
                          myValidation:
                              Validations.requiredWithoutSpecialCharacters,
                        ),

                        MyTextFormFiled(
                          controller: citizenshipController,
                          title: "Citizenship",
                          // myValidation:
                          //     Validations.requiredWithoutSpecialCharacters,
                        ),

                        MyTextFormFiled(
                          controller: secondLanguageController,
                          title: "Second Language",
                          // myValidation:
                          //     Validations.requiredWithoutSpecialCharacters,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        controller.isLoadingAddStudent
                            ? LoadingIndicators.getLoadingIndicator()
                            : InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate() &&
                                      controller.selectedItemGrade != null &&
                                      controller.selectedItemCohort != null &&
                                      controller.selectedItemClassRoom !=
                                          null) {
                                    controller
                                        .addNewStudent(
                                      blbID: int.parse(blbIdController.text),
                                      cohortId:
                                          controller.selectedItemCohort!.value,
                                      gradesId:
                                          controller.selectedItemGrade!.value,
                                      schoolClassId: controller
                                          .selectedItemClassRoom!.value,
                                      firstName: firstNameController.text,
                                      secondName: secondNameController.text,
                                      thirdName: thirdNameController.text,
                                      secondLang: secondLanguageController.text,
                                      religion: religionController.text,
                                      citizenship: citizenshipController.text,
                                    )
                                        .then(
                                      (value) {
                                        value
                                            ? {
                                                context.mounted
                                                    ? context.pop()
                                                    : null,
                                                MyFlashBar.showSuccess(
                                                  "The Student has been added successfully",
                                                  "Success",
                                                ).show(context.mounted
                                                    ? context
                                                    : Get.key.currentContext!),
                                              }
                                            : null;
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorManager.bgSideMenu,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: nunitoRegular.copyWith(
                                        color: ColorManager.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ).paddingOnly(right: 20);
            },
          ),
        ),
      ),
    );
  }
}
