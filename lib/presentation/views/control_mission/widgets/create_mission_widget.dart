import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/control_mission_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/validations.dart';

final _formKey = GlobalKey<FormState>();

class CreateMissionWidget extends GetView<ControlMissionController> {
  CreateMissionWidget({super.key});

  final TextEditingController missionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      height: Get.height * 0.5,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GetBuilder<ControlMissionController>(
        builder: (creatMissionController) => controller
                .educationYearList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormField<List<ValueItem<dynamic>>>(
                      validator:
                          Validations.multiSelectDropDownRequiredValidator,
                      builder: (formFieldState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MultiSelectDropDownView(
                              options: creatMissionController.educationYearList
                                  .map(
                                    (e) =>
                                        ValueItem(label: e.name!, value: e.id!),
                                  )
                                  .toList(),
                              onOptionSelected: (value) {
                                formFieldState.didChange(value);
                                creatMissionController.selectedEducationYearId =
                                    value;
                                creatMissionController.update();
                              },
                              hintText: "Select Education Year",
                            ),
                            if (formFieldState.hasError) ...{
                              const SizedBox(height: 10),
                              Text(
                                formFieldState.errorText!,
                                style: nunitoRegular.copyWith(
                                  color: ColorManager.red,
                                  fontSize: FontSize.s10,
                                ),
                              ).paddingOnly(left: 10),
                            }
                          ],
                        );
                      },
                    ),
                    MytextFormFiled(
                      myValidation: Validations.requiredValidator,
                      controller: missionNameController,
                      title: "Mission Name",
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<ControlMissionController>(
                      builder: (_) {
                        return Row(
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
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              fieldHintText: 'Start Date',
                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 150),
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
                            DateTime? picked = await showDatePicker(
                              context: context,
                              fieldHintText: 'End Date',
                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              firstDate: DateTime.tryParse(
                                  controller.selectedStartDate!)!,
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null) {
                              controller.selectedEndDate =
                                  DateFormat('yyyy-MM-dd').format(picked);
                              controller.update();
                            }
                          },
                          child: const Text(
                            "Select End Date",
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 20),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 200,
                          child: ElevatedBackButton(),
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedAddButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // controller.createMission();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // const Spacer(),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
      ),
    );
  }
}
