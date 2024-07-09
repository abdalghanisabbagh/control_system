import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/controllers.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_add_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_back_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/font_manager.dart';
import '../../../resource_manager/styles_manager.dart';
import '../../../resource_manager/validations.dart';

class AddNewStudentsToExamRoomWidget
    extends GetView<DistributeStudentsController> {
  AddNewStudentsToExamRoomWidget({super.key});

  final _formKey = GlobalKey<FormState>();

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
                                  controller.selectedItemGradeId =
                                      selectedItem.first.value;
                                  formFieldState.didChange(selectedItem);
                                },
                                options: controller.optionsGrades,
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
                      MytextFormFiled(
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
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedAddButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          controller.canAddStudents()
                                              ? {
                                                  controller
                                                      .getAvailableStudents(),
                                                  Get.back(),
                                                }
                                              : MyAwesomeDialogue(
                                                      title: 'Error',
                                                      desc:
                                                          '''PLease Make Sure You Have Entered The Right Number Of Students.
                                                          \n currently available space in the room is ${controller.availableStudentsCount} students.
                                                          \n currently available students from the selected grade is ${controller.countByGrade[controller.selectedItemGradeId.toString()]} students.
                                                          \n currntly selected number of students is ${controller.numberOfStudentsController.text}.''',
                                                      dialogType:
                                                          DialogType.error)
                                                  .showDialogue(context);
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
