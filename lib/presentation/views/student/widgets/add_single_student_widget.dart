import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/students_controllers/add_new_student_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class AddSingleStudentWidget extends GetView<AddNewStudentController> {
  final TextEditingController blbIdController = TextEditingController();

  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController sLangController = TextEditingController();
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

                        MytextFormFiled(
                          controller: blbIdController,
                          title: "BLB ID",
                          myValidation: Validations.requiredValidator,
                        ),

                        MytextFormFiled(
                          controller: fnameController,
                          title: "First Name",
                          myValidation: Validations.requiredValidator,
                        ),

                        MytextFormFiled(
                          controller: mnameController,
                          title: "Middle Name",
                          myValidation: Validations.requiredValidator,
                        ),

                        MytextFormFiled(
                          controller: lnameController,
                          title: "Last Name",
                        ),

                        MytextFormFiled(
                          controller: religionController,
                          title: "Religion",
                          myValidation: Validations.requiredValidator,
                        ),

                        MytextFormFiled(
                          controller: citizenshipController,
                          title: "Citizenship",
                          myValidation: Validations.requiredValidator,
                        ),

                        MytextFormFiled(
                          controller: sLangController,
                          title: "Second Language",
                          myValidation: Validations.requiredValidator,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        controller.isLodingAddStudent
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
                                      blubID: int.parse(blbIdController.text),
                                      cohortId:
                                          controller.selectedItemCohort!.value,
                                      gradesId:
                                          controller.selectedItemGrade!.value,
                                      schoolClassId: controller
                                          .selectedItemClassRoom!.value,
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
