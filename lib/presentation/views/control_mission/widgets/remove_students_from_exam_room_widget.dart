import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_remove_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../../resource_manager/validations.dart';

class RemoveStudentsFromExamRoomWidget
    extends GetView<DistributeStudentsController> {
  final _formKey = GlobalKey<FormState>();

  RemoveStudentsFromExamRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: GetBuilder<DistributeStudentsController>(
        builder: (_) {
          return controller.isLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      FormField(
                        validator:
                            Validations.multiSelectDropDownRequiredValidator,
                        builder: (formFieldState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MultiSelectDropDownView(
                                hintText: 'Select Grade',
                                onOptionSelected: (selectedItem) {
                                  selectedItem.length == 1
                                      ? {
                                          controller.numberOfStudentsInClasses =
                                              {},
                                          controller.availableStudents
                                              .forEach((element) {
                                            controller
                                                    .numberOfStudentsInClasses[
                                                element
                                                    .student!
                                                    .classRoomResModel!
                                                    .name!] = (controller
                                                            .numberOfStudentsInClasses[
                                                        element
                                                            .student!
                                                            .classRoomResModel!
                                                            .name!] ??
                                                    0) +
                                                1;
                                          }),
                                          controller.selectedItemGradeId =
                                              selectedItem.first.value,
                                          formFieldState
                                              .didChange(selectedItem),
                                          controller.optionsClasses = controller
                                              .availableStudents
                                              .where((element) =>
                                                  element.gradesID ==
                                                  selectedItem.first.value)
                                              .map((element) => ValueItem(
                                                  label:
                                                      '${element.student!.classRoomResModel!.name!} (${controller.numberOfStudentsInClasses[element.student!.classRoomResModel!.name!]})',
                                                  value: element.student!
                                                      .classRoomResModel!.iD))
                                              .toSet()
                                              .toList(),
                                        }
                                      : {
                                          controller.optionsClasses.clear(),
                                        };
                                  controller.update(['class']);
                                },
                                options: controller.optionsGradesInExamRoom,
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
                                ).paddingOnly(
                                  left: 10,
                                ),
                            ],
                          );
                        },
                      ),
                      GetBuilder<DistributeStudentsController>(
                        id: 'class',
                        builder: (_) {
                          return controller.optionsClasses.isEmpty
                              ? const SizedBox()
                              : MultiSelectDropDownView(
                                  key: UniqueKey(),
                                  hintText: 'Select class optional',
                                  onOptionSelected: (selectedItem) {
                                    selectedItem.length == 1
                                        ? controller.selectedItemClassId =
                                            selectedItem.first.value
                                        : {
                                            controller.selectedItemClassId = -1,
                                          };
                                  },
                                  options: controller.optionsClasses,
                                );
                        },
                      ),
                      MyTextFormFiled(
                        isNumber: true,
                        controller: controller.numberOfStudentsController,
                        myValidation: Validations.requiredValidator,
                        title: "Enter Number of Students",
                      ),
                      Expanded(
                        child: controller.isLoadingStudents
                            ? Center(
                                child: LoadingIndicators.getLoadingIndicator(),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: ElevatedBackButton(
                                      onPressed: () {
                                        controller.numberOfStudentsController
                                            .clear();
                                        controller.selectedItemClassId = -1;
                                        controller.selectedItemGradeId = -1;
                                        controller.optionsClasses.clear();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedRemoveButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          controller.canRemoveStudents()
                                              ? {
                                                  controller
                                                      .removeStudentsFromExamRoom(),
                                                  controller
                                                      .selectedItemClassId = -1,
                                                  controller
                                                      .selectedItemGradeId = -1,
                                                  controller.optionsClasses
                                                      .clear(),
                                                  Get.back(),
                                                }
                                              : MyAwesomeDialogue(
                                                  title: 'Error',
                                                  desc: controller
                                                              .selectedItemClassId ==
                                                          -1
                                                      ? '''PLease Make Sure You Have Entered The Right Number Of Students.
                                                      \n current number of students from the selected grade: ${controller.availableStudents.where((element) => element.gradesID == controller.selectedItemGradeId).length}
                                                      \n current number of students from the selected number of students: ${controller.numberOfStudentsController.text}'''
                                                      : '''PLease Make Sure You Have Entered The Right Number Of Students.
                                                      \n current number of students from the selected grade: ${controller.availableStudents.where((element) => element.gradesID == controller.selectedItemGradeId).length}
                                                      \n currently available students from the selected class is ${controller.availableStudents.where((element) => element.student!.classRoomResModel!.iD == controller.selectedItemClassId).length.toString()} students.
                                                      \n current number of students from the selected number of students: ${controller.numberOfStudentsController.text}''',
                                                  dialogType: DialogType.error,
                                                ).showDialogue(context);
                                        }
                                      },
                                    ),
                                  ),
                                ],
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
