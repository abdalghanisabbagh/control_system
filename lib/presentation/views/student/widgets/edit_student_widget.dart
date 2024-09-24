import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../Data/Models/student/student_res_model.dart';
import '../../../../domain/controllers/students_controllers/student_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';

class EditStudentWidget extends StatefulWidget {
  final StudentResModel studentResModel;

  const EditStudentWidget({
    super.key,
    required this.studentResModel,
  });

  @override
  EditStudentWidgetState createState() => EditStudentWidgetState();
}

class EditStudentWidgetState extends State<EditStudentWidget> {
  late TextEditingController blbIdController;
  late TextEditingController citizenshipController;
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController mnameController;
  late TextEditingController religionController;
  late TextEditingController sLangController;

  @override
  Widget build(BuildContext context) {
    final StudentController controller = Get.find<StudentController>();

    // Set initial values
    controller.selectedItemGrade = controller.optionsGrade.firstWhere(
      (element) => element.value == widget.studentResModel.gradesID,
    );

    controller.selectedItemCohort = controller.optionsCohort.firstWhere(
      (element) => element.value == widget.studentResModel.cohortID,
    );

    controller.selectedItemClassRoom = controller.optionsClassRoom.firstWhere(
      (element) => element.value == widget.studentResModel.schoolClassID,
    );

    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: GetBuilder<StudentController>(
          builder: (_) {
            return Form(
              key: controller.formKey,
              child: Column(
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
                  const SizedBox(height: 20),

                  // Grade Dropdown
                  SizedBox(
                    width: 500,
                    child: MultiSelectDropDownView(
                      hintText: "Select Grade",
                      onOptionSelected: (selectedItem) {
                        controller.setSelectedItemGrade(selectedItem);
                      },
                      optionSelected: [
                        controller.optionsGrade.firstWhereOrNull(
                              (element) =>
                                  element.value ==
                                  widget.studentResModel.gradesID,
                            ) ??
                            controller.optionsGrade.first,
                      ],
                      options: controller.optionsGrade,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Cohort Dropdown
                  SizedBox(
                    width: 500,
                    child: MultiSelectDropDownView(
                      onOptionSelected: (selectedItem) {
                        controller.setSelectedItemCohort(selectedItem);
                      },
                      optionSelected: [
                        controller.optionsCohort.firstWhereOrNull(
                              (element) =>
                                  element.value ==
                                  widget.studentResModel.cohortID,
                            ) ??
                            controller.optionsCohort.first,
                      ],
                      options: controller.optionsCohort,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ClassRoom Dropdown
                  SizedBox(
                    width: 500,
                    child: MultiSelectDropDownView(
                      onOptionSelected: (selectedItem) {
                        controller.setSelectedItemClassRoom(selectedItem);
                      },
                      optionSelected: [
                        controller.optionsClassRoom.firstWhereOrNull(
                              (element) =>
                                  element.value ==
                                  widget.studentResModel.schoolClassID,
                            ) ??
                            controller.optionsClassRoom.first,
                      ],
                      options: controller.optionsClassRoom,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Other Fields
                  MyTextFormFiled(
                    controller: fnameController,
                    title: "First Name",
                    myValidation: Validations.requiredValidator,
                    onChanged: (value) {
                      widget.studentResModel.firstName = value;
                      return null;
                    },
                  ),
                  MyTextFormFiled(
                    controller: mnameController,
                    title: "Middle Name",
                    myValidation: Validations.requiredValidator,
                    onChanged: (value) {
                      widget.studentResModel.secondName = value;
                      return null;
                    },
                  ),
                  MyTextFormFiled(
                    controller: lnameController,
                    title: "Last Name",
                    onChanged: (value) {
                      widget.studentResModel.thirdName = value;
                      return null;
                    },
                  ),
                  MyTextFormFiled(
                    controller: religionController,
                    title: "Religion",
                    myValidation: Validations.requiredValidator,
                    onChanged: (value) {
                      widget.studentResModel.religion = value;
                      return null;
                    },
                  ),
                  // MyTextFormFiled(
                  //   controller: citizenshipController,
                  //   title: "Citizenship",
                  //   onChanged: (value) {
                  //     widget.studentResModel.citizenship! = value;
                  //   },
                  // ),
                  MyTextFormFiled(
                    controller: sLangController,
                    title: "Second Language",
                    myValidation: Validations.requiredValidator,
                    onChanged: (value) {
                      widget.studentResModel.secondLang = value;
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Update Button
                  GetBuilder<StudentController>(
                    builder: (_) {
                      return controller.isLoadingEditStudent
                          ? LoadingIndicators.getLoadingIndicator()
                          : InkWell(
                              onTap: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller.selectedItemGrade == null ||
                                      controller.selectedItemCohort == null ||
                                      controller.selectedItemClassRoom ==
                                          null) {
                                    MyFlashBar.showError(
                                      "Please fill in all required fields.",
                                      "Error",
                                    ).show(context.mounted
                                        ? context
                                        : Get.key.currentContext!);
                                    return;
                                  }

                                  controller
                                      .patchEditStudent(
                                    studentid: widget.studentResModel.iD!,
                                    gradesId:
                                        controller.selectedItemGrade!.value,
                                    cohortId:
                                        controller.selectedItemCohort!.value,
                                    schoolClassId:
                                        controller.selectedItemClassRoom!.value,
                                    firstName:
                                        widget.studentResModel.firstName!,
                                    secondName:
                                        widget.studentResModel.secondName!,
                                    thirdName:
                                        widget.studentResModel.thirdName!,
                                    secondLang:
                                        widget.studentResModel.secondLang!,
                                    religion: widget.studentResModel.religion!,
                                  )
                                      .then((value) {
                                    value
                                        ? {
                                            context.mounted
                                                ? context.pop()
                                                : null,
                                            MyFlashBar.showSuccess(
                                              "The Student has been Edited successfully",
                                              "Success",
                                            ).show(context.mounted
                                                ? context
                                                : Get.key.currentContext!),
                                          }
                                        : null;
                                  });
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
              ).paddingOnly(right: 20),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    fnameController.dispose();
    mnameController.dispose();
    lnameController.dispose();
    religionController.dispose();
    sLangController.dispose();
    citizenshipController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from studentResModel
    fnameController = TextEditingController(
        text: widget.studentResModel.firstName.toString());
    mnameController = TextEditingController(
        text: widget.studentResModel.secondName.toString());
    lnameController = TextEditingController(
        text: widget.studentResModel.thirdName.toString());
    religionController =
        TextEditingController(text: widget.studentResModel.religion.toString());
    sLangController = TextEditingController(
        text: widget.studentResModel.secondLang.toString());
    citizenshipController =
        TextEditingController(); // If you want to initialize it with a value, add it here
  }
}
