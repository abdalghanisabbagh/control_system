import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_remove_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/font_manager.dart';
import '../../../resource_manager/styles_manager.dart';
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
              ? const Center(
                  child: CircularProgressIndicator(),
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
                      MytextFormFiled(
                        controller: controller.numberOfStudentsController,
                        myValidation: Validations.requiredValidator,
                        title: "Enter Number of Students",
                      ),
                      Expanded(
                        child: controller.isLoadingStudents
                            ? const Center(
                                child: CircularProgressIndicator(),
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
                                    child: ElevatedRemoveButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          controller.canRemoveStudents()
                                              ? {
                                                  controller
                                                      .removeStudentsFromExamRoom(),
                                                  Get.back(),
                                                }
                                              : MyAwesomeDialogue(
                                                  title: 'Error',
                                                  desc: '''
                                                      PLease Make Sure You Have Entered The Right Number Of Students.
                                                      \ncurrent number of students from the selected grade: ${controller.availableStudents.where((element) => element.gradesID == controller.selectedItemGradeId).length}
                                                      \ncurrent number of students from the selected number of students: ${controller.numberOfStudentsController.text}
                                                      ''',
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
