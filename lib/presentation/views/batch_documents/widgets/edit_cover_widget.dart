import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../../app/extensions/convert_date_string_to_iso8601_string_extension.dart';
import '../../../../domain/controllers/batch_documents.dart/edit_cover_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/validations.dart';

// ignore: must_be_immutable
class EditCoverWidget extends GetView<EditCoverSheetController> {
  ControlMissionResModel controlMissionObject;

  late TextEditingController endTimeController = TextEditingController(
      text: examMissionObject.endTime == null
          ? null
          : DateFormat('yyyy-MM-dd HH:mm')
              .format(DateTime.parse(examMissionObject.endTime!).toLocal()));
  final TextEditingController examFinalDegreeController =
      TextEditingController();

  ExamMissionResModel examMissionObject;

  late TextEditingController startTimeController = TextEditingController(
      text: examMissionObject.startTime == null
          ? "${examMissionObject.month} ${examMissionObject.year}"
          : DateFormat('yyyy-MM-dd HH:mm')
              .format(DateTime.parse(examMissionObject.startTime!).toLocal()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditCoverWidget(
      {super.key,
      required this.examMissionObject,
      required this.controlMissionObject});

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
          GetBuilder<EditCoverSheetController>(
              init: EditCoverSheetController(),
              dispose: (_) {
                Get.delete<EditCoverSheetController>();
              },
              builder: (_) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
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
                      if (examMissionObject.pdf != null)
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Text("Old Exam :'${examMissionObject.pdf}' ",
                              style: nunitoRegularStyle()),
                        ),
                      if (controller.isImportedFile == true)
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Text("New Exam :'${controller.pdfName}' ",
                              style: nunitoRegularStyle()),
                        )
                    ],
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
                Text('Exam Duration:', style: nunitoRegularStyle()),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 500,
                  child: MultiSelectDropDownView(
                    optionSelected: [
                      ValueItem(
                        value: examMissionObject.duration!,
                        label: "${examMissionObject.duration.toString()} Mins",
                      )
                    ],
                    hintText: "Select Exam Duration",
                    onOptionSelected: (selectedItem) {
                      controller.selectedIExamDuration =
                          selectedItem.isNotEmpty ? selectedItem.first : null;
                    },
                    options: controller.optionsExamDurations,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Start Time:", style: nunitoRegularStyle()),
                InkWell(
                  onTap: () async {
                    await selectDate(context, isStart: true);
                    if (controller.selectedStartTime != null) {
                      startTimeController.text = DateFormat('yyyy-MM-dd HH:mm')
                          .format(controller.selectedStartTime!);
                      controller.update();
                    }
                  },
                  child: TextFormField(
                    validator: Validations.requiredValidator,
                    cursorColor: ColorManager.bgSideMenu,
                    enabled: false,
                    style: nunitoRegularStyle(),
                    controller: startTimeController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.bgSideMenu,
                          width: 20,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      suffixIcon: const Icon(
                        Icons.date_range_outlined,
                        color: Colors.black,
                      ),
                      hintStyle: nunitoRegularStyle(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<EditCoverSheetController>(builder: (_) {
                  if (controller.selectedStartTime == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("End Time:", style: nunitoRegularStyle()),
                      InkWell(
                        onTap: () async {
                          await selectDate(context, isStart: false);
                          if (controller.selectedEndTime != null) {
                            endTimeController.text =
                                DateFormat('yyyy-MM-dd HH:mm')
                                    .format(controller.selectedEndTime!);
                            controller.update();
                          }
                        },
                        child: TextFormField(
                          validator: Validations.requiredValidator,
                          cursorColor: ColorManager.bgSideMenu,
                          enabled: false,
                          style: nunitoRegularStyle(),
                          controller: endTimeController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.bgSideMenu,
                                width: 20,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            suffixIcon: const Icon(
                              Icons.date_range_outlined,
                              color: Colors.black,
                            ),
                            hintStyle: nunitoRegularStyle(),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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
                          color: examMissionObject.period!
                              ? Colors.black
                              : Colors.grey),
                    ),
                    Switch.adaptive(
                        value: examMissionObject.period!,
                        onChanged: (newValue) {
                          examMissionObject.period = newValue;
                          controller.update();
                        }),
                    Text(
                      'Session Two Exams',
                      style: TextStyle(
                          color: examMissionObject.period!
                              ? Colors.black
                              : Colors.grey),
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
                if (controller.selectedEndTime != null &&
                    controller.selectedStartTime != null) {
                  if (controller.selectedEndTime!
                      .isBefore(controller.selectedStartTime!)) {
                    MyFlashBar.showError(
                      "End Time cannot be before Start Time",
                      "Error",
                    ).show(Get.key.currentContext!);
                    return;
                  }
                }

                if (_formKey.currentState!.validate()) {
                  controller
                      .updateExamMission(
                    endTime: controller.selectedEndTime == null
                        ? null
                        : endTimeController.text
                            .convertDateStringToIso8601String(),
                    period: examMissionObject.period,
                    id: examMissionObject.iD!,
                    startTime: controller.selectedStartTime == null
                        ? null
                        : startTimeController.text
                            .convertDateStringToIso8601String(),
                    duration: controller.selectedIExamDuration?.value,
                    pdfUrl: controller.pdfUrl,
                  )
                      .then((value) {
                    if (value) {
                      Get.back();
                      controller.onClose();
                      MyFlashBar.showSuccess(
                        "Exam Cover Sheet Updated Successfully",
                        "Success",
                      ).show(Get.key.currentContext!);
                    }
                  });
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorManager.bgSideMenu,
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                  child: Text("Update", style: nunitoSemiBoldStyle()),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context, {required bool isStart}) async {
    if (controlMissionObject.startDate == null ||
        controlMissionObject.endDate == null) {
      return;
    }

    final DateTime startDate = DateTime.parse(controlMissionObject.startDate!
            .substring(0, controlMissionObject.startDate!.length - 1))
        .toLocal();
    final DateTime endDate = DateTime.parse(controlMissionObject.endDate!
            .substring(0, controlMissionObject.endDate!.length - 1))
        .toLocal();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: startDate,
      lastDate: endDate,
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
        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
        String formattedDateTime = formatter.format(selectedDateTime);

        if (isStart) {
          controller.selectedStartTime = selectedDateTime;
          startTimeController.text = formattedDateTime;
        } else {
          controller.selectedEndTime = selectedDateTime;
          endTimeController.text = formattedDateTime;
        }
      }
    }
  }
}
