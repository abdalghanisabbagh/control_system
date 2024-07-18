import 'package:control_system/app/extensions/convert_date_string_to_iso8601_string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../../domain/controllers/batch_documents.dart/edit_cover_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/validations.dart';

// ignore: must_be_immutable
class EditCoverWidget extends GetView<EditCoverSheetController> {
  ExamMissionResModel examMissionObject;
  ControlMissionResModel controlMissionObject;
  EditCoverWidget(
      {super.key,
      required this.examMissionObject,
      required this.controlMissionObject});

  DateTime? selectedDate;
  DateTime? selectedDateTime;

  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  late TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd')
          .format(DateTime.tryParse(examMissionObject.startTime!)!));

  Future<void> selectDate(BuildContext context) async {
    if (controlMissionObject.startDate == null ||
        controlMissionObject.endDate == null) {
      return;
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(controlMissionObject.startDate!
          .substring(0, controlMissionObject.startDate!.length - 1)),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.parse(controlMissionObject.startDate!
          .substring(0, controlMissionObject.startDate!.length - 1)),
      lastDate: DateTime.parse(controlMissionObject.endDate!
          .substring(0, controlMissionObject.endDate!.length - 1)),
    );

    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Theme(
              data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: ColorManager.primary,
                    ),
              ),
              child: child!,
            ),
          );
        },
      );

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        selectedDay = pickedDate.day.toString();
        selectedMonth = pickedDate.month.toString();
        selectedYear = pickedDate.year.toString();

        final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
        String formattedDateTime = formatter.format(selectedDateTime!);
        dateController.text = formattedDateTime;
        //  print('Formatted Date and Time: ${dateController.text}');
      }
    }
  }

  final TextEditingController examFinalDegreeController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Edit Cover Sheet",
                    style: nunitoBold.copyWith(
                      color: ColorManager.primary,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              IconButton(
                alignment: AlignmentDirectional.topEnd,
                color: Colors.black,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<EditCoverSheetController>(builder: (_) {
            if (controller.isLodingUploadPdf == true) {
              return SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  child: LoadingIndicators.getLoadingIndicator(),
                ),
              );
            }
            return InkWell(
              onTap: () {
                controller.uplodPdfInExamMission().then((value) {
                  if (value == true) {
                    MyFlashBar.showSuccess(
                      "Uploaded Successfully",
                      "Success",
                    ).show(Get.key.currentContext!);
                  }
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(11),
                  ),
                  color: ColorManager.glodenColor,
                ),
                child: Center(
                  child: Text(
                    "Upload Exam Version A",
                    style: nunitoRegular.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          }),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text('Exam Date:', style: nunitoRegularStyle()),
                const SizedBox(
                  height: 5,
                ),
                FormField<List<ValueItem<dynamic>>>(
                    validator: Validations.multiSelectDropDownRequiredValidator,
                    builder: (formFieldState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 500,
                            child: MultiSelectDropDownView(
                              optionSelected: [
                                ValueItem(
                                  value: examMissionObject.duration!,
                                  label:
                                      "${examMissionObject.duration.toString()} Mins",
                                )
                              ],
                              hintText: "Select Exam Date",
                              onOptionSelected: (selectedItem) {
                                controller.selectedIExamDuration =
                                    selectedItem.isNotEmpty
                                        ? selectedItem.first
                                        : null;
                              },
                              options: controller.optionsExamDurations,
                            ),
                          ),
                          if (formFieldState.hasError)
                            Text(
                              formFieldState.errorText!,
                              style: nunitoRegular.copyWith(
                                fontSize: FontSize.s14,
                                color: ColorManager.error,
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await selectDate(context);
                    if (selectedDateTime != null) {
                      dateController.text = DateFormat('yyyy-MM-dd HH:mm')
                          .format(selectedDateTime!);
                    }
                    // } else {
                    //   dateController.text = examMissionObject.startTime!;
                    // }
                  },
                  child: TextFormField(
                    validator: Validations.requiredValidator,
                    cursorColor: ColorManager.bgSideMenu,
                    enabled: false,
                    style: nunitoRegularStyle(),
                    controller: dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.bgSideMenu,
                          width: 20,
                          style: BorderStyle.solid,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      suffixIcon: const Icon(
                        Icons.date_range_outlined,
                        color: Colors.black,
                      ),
                      // hintText: '${examMissionObject.startTime}',
                      hintStyle: nunitoRegularStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Exams Period :", style: nunitoRegularStyle()),
              GetBuilder<EditCoverSheetController>(builder: (controller) {
                return Row(
                  children: [
                    Text(
                      'Session One Exams',
                      style: TextStyle(
                          color:
                              !controller.isNight ? Colors.black : Colors.grey),
                    ),
                    Switch.adaptive(
                        value: controller.isNight,
                        onChanged: (newValue) {
                          controller.isNight = newValue;
                          controller.update();
                        }),
                    Text(
                      'Session Two Exams',
                      style: TextStyle(
                          color:
                              controller.isNight ? Colors.black : Colors.grey),
                    ),
                  ],
                );
              }),
            ],
          ),
          GetBuilder<EditCoverSheetController>(builder: (_) {
            if (controller.isLodingUpdateExamMission ||
                controller.isLodingUploadPdf) {
              return SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  child: LoadingIndicators.getLoadingIndicator(),
                ),
              );
            }
            return InkWell(
              onTap: () {
                controller
                    .updateExamMission(
                        id: examMissionObject.iD!,
                        startTime: dateController.text
                            .convertDateStringToIso8601String(),
                        duration: controller.selectedIExamDuration?.value,
                        pdfUrl: controller.pdfUrl)
                    .then((value) {
                  if (value) {
                    Get.back();
                    MyFlashBar.showSuccess(
                      "Exam Cover Sheet Updated Successfully",
                      "Success",
                    ).show(Get.key.currentContext!);
                  }
                });
              },
              child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorManager.bgSideMenu,
                      borderRadius: BorderRadius.circular(11)),
                  child: Center(
                    child: Text("Update", style: nunitoSemiBoldStyle()),
                  )),
            );
          })
        ],
      ),
    );
  }
}
