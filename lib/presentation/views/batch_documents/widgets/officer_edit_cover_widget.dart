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
class OfficerEditCoverWidget extends GetView<EditCoverSheetController> {
  ExamMissionResModel examMissionObject;
  ControlMissionResModel controlMissionObject;
  OfficerEditCoverWidget(
      {super.key,
      required this.examMissionObject,
      required this.controlMissionObject});

  late TextEditingController dateController = TextEditingController(
      text: "${examMissionObject.month} ${examMissionObject.year}");
  DateTime? selectedDate;
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  Future<DateTime?> selectDate(BuildContext context) async {
    if (controlMissionObject.startDate == null ||
        controlMissionObject.endDate == null) {
      return null;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(controlMissionObject.startDate!
          .substring(0, controlMissionObject.startDate!.length - 1)),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.parse(controlMissionObject.startDate!
          .substring(0, controlMissionObject.startDate!.length - 1)),
      lastDate: DateTime.parse(controlMissionObject.endDate!
          .substring(0, controlMissionObject.endDate!.length - 1)),
    );

    if (picked != null) {
      selectedDate = picked;
      selectedDay = picked.day.toString();
      selectedMonth = DateFormat.MMMM().format(picked);
      selectedYear = picked.year.toString();
    }

    return picked;
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
                GetBuilder<EditCoverSheetController>(builder: (_) {
                  return InkWell(
                    onTap: () async {
                      await selectDate(
                        context,
                      );
                      if (selectedDate != null) {
                        dateController.text =
                            DateFormat('dd MMMM yyyy').format(selectedDate!);
                        controller.update();
                      }
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
                        hintStyle: nunitoRegularStyle(),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 10,
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
                controller
                    .updateExamMissionByOffice(
                  year: selectedYear == null
                      ? examMissionObject.year!
                      : selectedYear!,
                  month: selectedMonth == null
                      ? examMissionObject.month!
                      : '${selectedDay!} ${selectedMonth!}',
                  period: examMissionObject.period,
                  id: examMissionObject.iD!,
                  duration: controller.selectedIExamDuration?.value,
                )
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
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
