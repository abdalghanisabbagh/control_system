import 'package:control_system/Data/Models/student/student_res_model.dart';
import 'package:control_system/domain/controllers/studentsController/student_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/resource_manager/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EditStudentWidget extends GetView<StudentController> {
  EditStudentWidget({
    super.key,
    required this.studentResModel,
  });

  final StudentResModel studentResModel;

  final TextEditingController blbIdController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController sLangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      return const CircularProgressIndicator();
                    }

                    if (controller.optionsCohort.isEmpty) {
                      return const Text('No items available');
                    }

                    return Column(
                      children: [
                        SizedBox(
                          width: 500,
                          child: MultiSelectDropDownView(
                            onOptionSelected: (selectedItem) {
                              controller.setSelectedItemGrade(selectedItem);
                            },
                            options: controller.optionsGrade,
                            optionSelected: [
                              controller.optionsGrade.firstWhere((element) =>
                                  element.value == studentResModel.gradesID),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 500,
                          child: MultiSelectDropDownView(
                            onOptionSelected: (selectedItem) {
                              controller.setSelectedItemCohort(selectedItem);
                            },
                            options: controller.optionsCohort,
                            optionSelected: [
                              controller.optionsCohort.firstWhere((element) =>
                                  element.value == studentResModel.cohortID),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 500,
                          child: MultiSelectDropDownView(
                            onOptionSelected: (selectedItem) {
                              controller.setSelectedItemClassRoom(selectedItem);
                            },
                            options: controller.optionsClassRoom,
                            optionSelected: [
                              controller.optionsClassRoom.firstWhere(
                                  (element) =>
                                      element.value ==
                                      studentResModel.schoolClassID),
                            ],
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
                    controller: religionController,
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
                controller.loading
                    ? const Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () async {
                          await controller
                              .patchEditStudent(
                            studentid: studentResModel.iD!,
                            gradesId: controller.selectedItemGrade!.value,
                            cohortId: controller.selectedItemCohort!.value,
                            schoolClassId:
                                controller.selectedItemClassRoom!.value,
                            firstName: fnameController.text,
                            secondName: mnameController.text,
                            thirdName: lnameController.text,
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
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
