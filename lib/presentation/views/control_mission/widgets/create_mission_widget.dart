import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_back_button.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/control_mission_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/validations.dart';

final _formKey = GlobalKey<FormState>();

class CreateMissionScreen extends GetView<ControlMissionController> {
  CreateMissionScreen({super.key});

  final TextEditingController missionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GetBuilder<ControlMissionController>(
          builder: (controller) => controller.educationYearList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyBackButton(),
                      const SizedBox(height: 20),
                      EnhanceStepper(
                        type: StepperType.vertical,
                        currentStep: controller.currentStep,
                        onStepContinue: () => controller.canMoveToNextStep()
                            ? controller.continueToNextStep()
                            : null,
                        onStepCancel: () => controller.backToPreviousStep(),
                        steps: [
                          _firstStep(context),
                          EnhanceStep(
                            isActive: controller.currentStep == 1,
                            title: const Text('Batch Students'),
                            content: const IntrinsicHeight(
                              child: Column(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
        ),
      ),
    );
  }

  EnhanceStep _firstStep(BuildContext context) {
    return EnhanceStep(
      isActive: controller.currentStep == 0,
      title: const Text('Mission Name'),
      content: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormField<List<ValueItem<dynamic>>>(
              validator: Validations.multiSelectDropDownRequiredValidator,
              builder: (formFieldState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MultiSelectDropDownView(
                      options: controller.optionsEducationYear,
                      onOptionSelected: (value) {
                        formFieldState.didChange(value);
                        controller.selectedEducationYear = value;
                        controller.selectedStartDate = null;
                        controller.selectedEndDate = null;
                        controller.update();
                      },
                      hintText: "Select Education Year",
                    ),
                    if (formFieldState.hasError) ...[
                      const SizedBox(height: 10),
                      Text(
                        formFieldState.errorText!,
                        style: nunitoRegular.copyWith(
                          color: ColorManager.red,
                          fontSize: FontSize.s10,
                        ),
                      ).paddingOnly(left: 10),
                    ]
                  ],
                );
              },
            ),
            MytextFormFiled(
              myValidation: Validations.requiredValidator,
              controller: missionNameController,
              title: "Mission Name",
              onChange: (value) => controller.batchName = value,
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: controller.selectedEducationYear != null ||
                      controller.selectedEducationYear != null
                  ? controller.selectedEducationYear!.isNotEmpty
                  : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start Date: ${controller.selectedStartDate == null ? "Please Select Start Date" : controller.selectedStartDate.toString()}",
                    style: nunitoBold.copyWith(
                      color: ColorManager.primary,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  Text(
                    "End Date: ${controller.selectedEndDate == null ? "Please Select End Date" : controller.selectedEndDate.toString()}",
                    style: nunitoBold.copyWith(
                      color: ColorManager.primary,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: controller.selectedEducationYear != null ||
                      controller.selectedEducationYear != null
                  ? controller.selectedEducationYear!.isNotEmpty
                  : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.selectedEducationYear == null) {
                        MyAwesomeDialogue(
                          title: "Error",
                          desc: "Please Select Education Year First",
                          dialogType: DialogType.error,
                        ).showDialogue(context);
                        return;
                      }
                      DateTime? picked = await showDatePicker(
                        context: context,
                        fieldHintText: 'Start Date',
                        initialDatePickerMode: DatePickerMode.day,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(
                          int.parse(
                            controller.selectedEducationYear!.first.label
                                .toString()
                                .split('/')
                                .last
                                .toString(),
                          ),
                          6,
                          23,
                        ),
                      );
                      if (picked != null) {
                        controller.selectedStartDate =
                            DateFormat('yyyy-MM-dd').format(picked);
                        controller.update();
                      }
                    },
                    child: const Text(
                      "Select Start Date",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.selectedStartDate == null) {
                        MyAwesomeDialogue(
                          title: "Error",
                          desc: "Please Select Start Date First",
                          dialogType: DialogType.error,
                        ).showDialogue(context);
                        return;
                      }
                      await showDatePicker(
                        context: context,
                        fieldHintText: 'End Date',
                        initialDatePickerMode: DatePickerMode.day,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        firstDate:
                            DateTime.tryParse(controller.selectedStartDate!)!,
                        lastDate: DateTime(
                          int.parse(
                            controller.selectedEducationYear!.first.label
                                .toString()
                                .split('/')
                                .last
                                .toString(),
                          ),
                          6,
                          30,
                        ),
                      ).then(
                        (picked) {
                          if (picked != null) {
                            if (picked.day <
                                DateTime.tryParse(
                                        controller.selectedStartDate!)!
                                    .add(
                                      const Duration(
                                        days: 7,
                                      ),
                                    )
                                    .day) {
                              MyAwesomeDialogue(
                                title: "Warning",
                                desc:
                                    "End Date should be greater than 7 days from Start Date.\n Are you sure you want to proceed?",
                                dialogType: DialogType.warning,
                                btnOkOnPressed: () {
                                  controller.selectedEndDate =
                                      DateFormat('yyyy-MM-dd').format(picked);
                                  controller.update();
                                },
                                btnCancelOnPressed: () {},
                              ).showDialogue(context);
                              return;
                            }
                            controller.selectedEndDate =
                                DateFormat('yyyy-MM-dd').format(picked);
                            controller.update();
                          }
                          return null;
                        },
                      );
                    },
                    child: const Text(
                      "Select End Date",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
