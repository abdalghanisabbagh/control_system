import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/batch_documents.dart/cover_shetts_controller.dart';
import '../../../../domain/controllers/batch_documents.dart/create_covers_sheets_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/validations.dart';

// ignore: must_be_immutable
class AddNewCoverWidget extends GetView<CreateCoversSheetsController> {
  AddNewCoverWidget({super.key});

  DateTime? selectedDate;
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  Future<DateTime?> selectDate(BuildContext context) async {
    if (controller.controlMissionResModel == null ||
        controller.controlMissionResModel!.startDate == null ||
        controller.controlMissionResModel!.endDate == null) {
      return null;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(controller.controlMissionResModel!.startDate!
          .substring(
              0, controller.controlMissionResModel!.startDate!.length - 1)),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.parse(controller.controlMissionResModel!.startDate!
          .substring(
              0, controller.controlMissionResModel!.startDate!.length - 1)),
      lastDate: DateTime.parse(controller.controlMissionResModel!.endDate!
          .substring(
              0, controller.controlMissionResModel!.endDate!.length - 1)),
    );

    if (picked != null) {
      selectedDate = picked;
      selectedDay = picked.day.toString();
      selectedMonth = picked.month.toString();
      selectedYear = picked.year.toString();
    }

    return picked;
  }

  final TextEditingController dateController = TextEditingController();
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
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormField<List<ValueItem<dynamic>>>(
                    validator: Validations.multiSelectDropDownRequiredValidator,
                    builder: (formFieldState) {
                      return GetBuilder<CreateCoversSheetsController>(
                        builder: (_) {
                          if (controller.isLoadingGetEducationYear) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: FittedBox(
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              ),
                            );
                          }

                          if (controller.optionsEducationYear.isEmpty) {
                            return const Text('No items available');
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 500,
                                child: MultiSelectDropDownView(
                                  hintText: "Select Education Year",
                                  onOptionSelected: (selectedItem) {
                                    controller.selectedItemEducationYear =
                                        selectedItem.isNotEmpty
                                            ? selectedItem.first
                                            : null;
                                    controller.setSelectedItemEducationYear(
                                        selectedItem);
                                    formFieldState.didChange(selectedItem);
                                    controller.update();
                                  },
                                  options: controller.optionsEducationYear,
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
                            ],
                          );
                        },
                      );
                    }),
                FormField<List<ValueItem<dynamic>>>(
                    validator: Validations.multiSelectDropDownRequiredValidator,
                    builder: (formFieldState) {
                      return GetBuilder<CreateCoversSheetsController>(
                        builder: (_) {
                          if (controller.isLoadingGetControlMission) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: FittedBox(
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              ),
                            );
                          }

                          if (controller.optionsControlMission.isEmpty) {
                            return const Text('No items available');
                          }
                          if (controller.selectedItemEducationYear == null) {
                            return const SizedBox.shrink();
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 500,
                                child: MultiSelectDropDownView(
                                  hintText: "Select Control Mission",
                                  onOptionSelected: (selectedItem) {
                                    controller.selectedItemControlMission =
                                        selectedItem.isNotEmpty
                                            ? selectedItem.first
                                            : null;
                                    controller.setSelectedItemControlMission(
                                        selectedItem);
                                    formFieldState.didChange(selectedItem);
                                  },
                                  options: controller.optionsControlMission,
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
                            ],
                          );
                        },
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                FormField<List<ValueItem<dynamic>>>(
                    validator: Validations.multiSelectDropDownRequiredValidator,
                    builder: (formFieldState) {
                      return GetBuilder<CreateCoversSheetsController>(
                        builder: (_) {
                          if (controller.isLoadingGrades) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: FittedBox(
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              ),
                            );
                          }

                          if (controller.optionsGrades.isEmpty) {
                            return const Text('No items available');
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 500,
                                child: MultiSelectDropDownView(
                                  hintText: "Select Grade",
                                  onOptionSelected: (selectedItem) {
                                    controller
                                        .setSelectedItemGrade(selectedItem);
                                    formFieldState.didChange(selectedItem);
                                  },
                                  options: controller.optionsGrades,
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
                            ],
                          );
                        },
                      );
                    }),
                const SizedBox(height: 10),
                FormField<List<ValueItem<dynamic>>>(
                    validator: Validations.multiSelectDropDownRequiredValidator,
                    builder: (formFieldState) {
                      return GetBuilder<CreateCoversSheetsController>(
                        builder: (_) {
                          if (controller.isLodingGetSubject) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: FittedBox(
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              ),
                            );
                          }

                          if (controller.optionsSubjects.isEmpty) {
                            return const Text('No items available');
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 500,
                                child: MultiSelectDropDownView(
                                  hintText: "Select Subject",
                                  onOptionSelected: (selectedItem) {
                                    controller.selectedItemSubject =
                                        selectedItem.isNotEmpty
                                            ? selectedItem.first
                                            : null;
                                    formFieldState.didChange(selectedItem);
                                  },
                                  options: controller.optionsSubjects,
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
                            ],
                          );
                        },
                      );
                    }),
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
                              hintText: "Select Exam Date",
                              onOptionSelected: (selectedItem) {
                                controller.selectedIExamDuration =
                                    selectedItem.isNotEmpty
                                        ? selectedItem.first
                                        : null;
                                formFieldState.didChange(selectedItem);
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
                    if (controller.selectedItemControlMission == null) {
                      MyAwesomeDialogue(
                        title: 'Error',
                        desc: "Please select Control Mission",
                        dialogType: DialogType.error,
                      ).showDialogue(Get.key.currentContext!);
                      return;
                    }

                    DateTime? selectedDate = await selectDate(context);
                    if (selectedDate != null) {
                      dateController.text =
                          DateFormat('dd MMMM yyyy').format(selectedDate);
                    } else {
                      dateController.text = 'dd MMMM yyyy';
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
                      hintText: 'Example: DD/MM/YYYY',
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
          TextFormField(
            controller: examFinalDegreeController..text = "100",
            style: nunitoRegularStyle(),
            enabled: false,
            decoration: InputDecoration(
              label: Text("Exam Final Grade", style: nunitoRegularStyle()),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Exams Versions :", style: nunitoRegularStyle()),
              GetBuilder<CreateCoversSheetsController>(builder: (controller) {
                return Row(
                  children: [
                    Text(
                      '1 Version',
                      style: TextStyle(
                          color: !controller.is2Version
                              ? Colors.black
                              : Colors.grey),
                    ),
                    Switch.adaptive(
                        value: controller.is2Version,
                        onChanged: (newValue) {
                          controller.is2Version = newValue;
                          controller.update();
                        }),
                    Text(
                      '2 Versions',
                      style: TextStyle(
                          color: controller.is2Version
                              ? Colors.black
                              : Colors.grey),
                    ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Exams Period :", style: nunitoRegularStyle()),
              GetBuilder<CreateCoversSheetsController>(builder: (controller) {
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
          GetBuilder<CoversSheetsController>(builder: (controllerCovers) {
            if (controller.isLodingAddExamMission) {
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
                if (_formKey.currentState!.validate()) {
                  controllerCovers
                      .addNewExamMission(
                          duration: controller.selectedIExamDuration!.value,
                          subjectId: controller.selectedItemSubject!.value,
                          controlMissionId:
                              controller.selectedItemControlMission!.value,
                          gradeId: controller.selectedItemGrade!.value,
                          educationyearId:
                              controller.selectedItemEducationYear!.value,
                          year: selectedYear!,
                          month: '${selectedMonth!}/${selectedDay!}',
                          finalDegree: 100.toString())
                      .then((value) {
                    if (value) {
                      Get.back();
                      MyFlashBar.showSuccess(
                        "Exam Cover Sheet Added Successfully",
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
                    child: Text("Add", style: nunitoSemiBoldStyle()),
                  )),
            );
          })
        ],
      ),
    );
  }
}
