import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:universal_html/html.dart';

import '../../../../domain/controllers/control_mission/create_control_mission.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/validations.dart';

class CreateMissionScreen extends GetView<CreateControlMissionController> {
  final TextEditingController missionNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CreateMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: RepaintBoundary(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: constraints.maxWidth > 600 ? 40 : 20,
              ),
              child: GetBuilder<CreateControlMissionController>(
                builder: (controller) => controller.isLoading
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: RepaintBoundary(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyBackButton(
                                  onPressed: () {
                                    controller.batchName = null;
                                    controller.selectedEducationYear = null;
                                    controller.currentStep = 0;
                                    controller.selectedStartDate = null;
                                    controller.selectedEndDate = null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                EnhanceStepper(
                                  type: StepperType.vertical,
                                  currentStep: controller.currentStep,
                                  onStepContinue: () => controller
                                              .currentStep ==
                                          0
                                      ? {
                                          controller.addControlMission().then(
                                            (value) async {
                                              if (value) {
                                                controller.currentStep = 1;
                                                MyFlashBar.showSuccess(
                                                  'Control mission created successfully',
                                                  'Success',
                                                ).show(context.mounted
                                                    ? context
                                                    : Get.key.currentContext!);
                                                await Future.delayed(
                                                  const Duration(seconds: 2),
                                                );
                                              } else {
                                                MyFlashBar.showError(
                                                  'Failed to create mission',
                                                  'Error',
                                                );
                                              }
                                            },
                                          ),
                                        }
                                      : controller.currentStep == 1
                                          ? {
                                              controller
                                                  .createStudentSeatNumbers()
                                                  .then(
                                                (value) async {
                                                  if (value) {
                                                    controller.currentStep = 0;
                                                    controller.batchName = null;
                                                    controller
                                                            .selectedEducationYear =
                                                        null;
                                                    controller
                                                            .selectedStartDate =
                                                        null;
                                                    controller.selectedEndDate =
                                                        null;
                                                    MyFlashBar.showSuccess(
                                                      'Mission created successfully',
                                                      'Success',
                                                    ).show(context.mounted
                                                        ? context
                                                        : Get.key
                                                            .currentContext!);
                                                    await Future.delayed(
                                                      const Duration(
                                                          seconds: 2),
                                                    );
                                                    window.history.back();
                                                  } else {
                                                    MyFlashBar.showError(
                                                      'Failed to create mission',
                                                      'Error',
                                                    );
                                                  }
                                                },
                                              ),
                                            }
                                          : controller.canMoveToNextStep()
                                              ? controller.continueToNextStep()
                                              : null,
                                  onStepCancel: () =>
                                      controller.backToPreviousStep(),
                                  steps: [
                                    _firstStep(context),
                                    _secondStep(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ).paddingSymmetric(
                            horizontal: constraints.maxWidth > 600 ? 40 : 20),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  EnhanceStep _firstStep(BuildContext context) {
    return EnhanceStep(
      isActive: controller.currentStep == 0,
      title: const Text('Mission Name'),
      content: RepaintBoundary(
        child: IntrinsicHeight(
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
                        optionSelected: controller.selectedEducationYear ?? [],
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
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? FontSize.s12
                                : FontSize.s10,
                          ),
                        ).paddingOnly(left: 10),
                      ]
                    ],
                  );
                },
              ),
              MytextFormFiled(
                myValidation: Validations.requiredValidator,
                controller: missionNameController
                  ..text = controller.batchName ?? "",
                title: "Mission Name",
                onChanged: (value) => controller.batchName = value,
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: controller.selectedEducationYear != null &&
                    controller.selectedEducationYear!.isNotEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Start Date: ${controller.selectedStartDate == null ? "Please Select Start Date" : controller.selectedStartDate.toString()}",
                        style: nunitoBold.copyWith(
                          color: ColorManager.primary,
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? FontSize.s18
                              : FontSize.s16,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "End Date: ${controller.selectedEndDate == null ? "Please Select End Date" : controller.selectedEndDate.toString()}",
                        style: nunitoBold.copyWith(
                          color: ColorManager.primary,
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? FontSize.s18
                              : FontSize.s16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: controller.selectedEducationYear != null &&
                    controller.selectedEducationYear!.isNotEmpty,
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
                        if (DateTime(
                                int.parse(controller
                                    .selectedEducationYear!.first.label
                                    .toString()
                                    .split('/')[1]
                                    .toString()),
                                6,
                                30)
                            .isBefore(DateTime.now())) {
                          MyAwesomeDialogue(
                            title: "Error",
                            desc: "Please Select Valid Education Year",
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
                            30,
                          ),
                        );
                        if (picked != null) {
                          if (controller.selectedEndDate != null &&
                              picked.isAfter(DateTime.parse(
                                  controller.selectedEndDate!))) {
                            MyAwesomeDialogue(
                              title: "Error",
                              desc: "Please Select Valid Start Date",
                              dialogType: DialogType.error,
                            ).showDialogue(Get.key.currentContext!);
                            return;
                          } else if (controller.selectedEndDate != null &&
                              picked
                                      .difference(DateTime.parse(
                                          controller.selectedEndDate!))
                                      .inDays
                                      .abs() <
                                  7) {
                            MyAwesomeDialogue(
                              title: "Warning",
                              desc:
                                  "End Date should be at least 7 days after Start Date",
                              dialogType: DialogType.warning,
                              btnOkOnPressed: () {
                                controller.selectedEndDate =
                                    DateFormat('yyyy-MM-dd').format(picked);
                                controller.update();
                              },
                              btnCancelOnPressed: () {},
                            ).showDialogue(Get.key.currentContext!);
                            return;
                          }
                          controller.selectedStartDate =
                              DateFormat('yyyy-MM-dd').format(picked);
                          controller.update();
                        }
                      },
                      child: Text(
                        "Select Start Date",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? FontSize.s16
                              : FontSize.s14,
                        ),
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
                            9,
                            1,
                          ),
                        ).then(
                          (picked) {
                            if (picked != null) {
                              if (picked
                                      .difference(DateTime.tryParse(
                                          controller.selectedStartDate!)!)
                                      .inDays
                                      .abs() <
                                  7) {
                                MyAwesomeDialogue(
                                  title: "Warning",
                                  desc:
                                      "End Date should be at least 7 days after Start Date",
                                  dialogType: DialogType.warning,
                                  btnOkOnPressed: () {
                                    controller.selectedEndDate =
                                        DateFormat('yyyy-MM-dd').format(picked);
                                  },
                                  btnCancelOnPressed: () {},
                                ).showDialogue(Get.key.currentContext!);
                              } else {
                                controller.selectedEndDate =
                                    DateFormat('yyyy-MM-dd').format(picked);
                              }
                              controller.update();
                            }
                          },
                        );
                      },
                      child: Text(
                        "Select End Date",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? FontSize.s16
                              : FontSize.s14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  EnhanceStep _secondStep(BuildContext context) {
    return EnhanceStep(
      isActive: controller.currentStep == 1,
      title: const Text('Batch Students'),
      content: RepaintBoundary(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MultiSelectDropDownView(
              hintText: 'Select Grades',
              options: controller.optionsGrades,
              multiSelect: true,
              showChipSelect: true,
              onOptionSelected: (value) {
                controller.updateSelectedGrades(value);
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Included Students List',
              style: nunitoBold.copyWith(
                color: ColorManager.black,
                fontSize: AppSize.s16,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: PlutoGrid(
                createFooter: (stateManager) {
                  stateManager.setPageSize(50, notify: false);
                  return PlutoPagination(
                    stateManager,
                    pageSizeToMove: 1,
                  );
                },
                configuration: PlutoGridConfiguration(
                  style: PlutoGridStyleConfig(
                    //  defaultCellPadding: EdgeInsets.zero,
                    enableGridBorderShadow: true,
                    iconColor: ColorManager.bgSideMenu,
                    gridBackgroundColor: ColorManager.bgColor,
                    menuBackgroundColor: ColorManager.bgColor,
                    rowColor: ColorManager.bgColor,
                    checkedColor: Colors.white,
                    gridBorderRadius: BorderRadius.circular(10),
                  ),
                  columnSize: const PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.scale,
                  ),
                  columnFilter: const PlutoGridColumnFilterConfig(
                    filters: FilterHelper.defaultFilters,
                  ),
                  scrollbar: const PlutoGridScrollbarConfig(
                    isAlwaysShown: false,
                    scrollbarThickness: 8,
                    scrollbarThicknessWhileDragging: 10,
                  ),
                ),
                columns: [
                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Id',
                    field: 'BlbIdField',
                    type: PlutoColumnType.text(),
                  ),
                  PlutoColumn(
                    enableEditingMode: false,
                    title: 'First Name',
                    field: 'FirstNameField',
                    type: PlutoColumnType.text(),
                  ),

                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Second Name',
                    field: 'SecondNameField',
                    type: PlutoColumnType.text(),
                  ),

                  /// Text Column definition
                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Third Name',
                    field: 'ThirdNameField',
                    type: PlutoColumnType.text(),
                  ),
                  PlutoColumn(
                    readOnly: true,
                    title: 'Cohort',
                    field: 'CohortField',
                    cellPadding: EdgeInsets.zero,
                    // titlePadding: EdgeInsets.zero,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    readOnly: true,
                    title: 'Grade',
                    field: 'GradeField',
                    type: PlutoColumnType.text(),
                    cellPadding: EdgeInsets.zero,
                    enableEditingMode: false,
                  ),

                  PlutoColumn(
                    readOnly: true,
                    title: 'Class Room',
                    field: 'ClassRoomField',
                    type: PlutoColumnType.text(),
                    cellPadding: EdgeInsets.zero,
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Second Language',
                    field: 'LanguageField',
                    type: PlutoColumnType.text(),
                    footerRenderer: (footerRenderer) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: footerRenderer,
                        type: PlutoAggregateColumnType.count,
                        filter: (cell) => true,
                        format: 'count : #,###',
                        alignment: Alignment.center,
                      );
                    },
                  ),
                  PlutoColumn(
                    enableEditingMode: false,
                    title: 'Actions',
                    field: 'ActionsField',
                    type: PlutoColumnType.text(),
                    renderer: (rendererContext) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.excludeStudent(rendererContext);
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
                rows: controller.includedStudentsRows,
                onChanged: (PlutoGridOnChangedEvent event) {},
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  controller.includedStudentsStateManager = event.stateManager;
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Excluded Students List',
              style: nunitoBold.copyWith(
                color: ColorManager.black,
                fontSize: AppSize.s16,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: PlutoGrid(
                createFooter: (stateManager) {
                  stateManager.setPageSize(50, notify: false);
                  return PlutoPagination(
                    stateManager,
                    pageSizeToMove: 1,
                  );
                },
                configuration: PlutoGridConfiguration(
                  style: PlutoGridStyleConfig(
                    //  defaultCellPadding: EdgeInsets.zero,
                    enableGridBorderShadow: true,
                    iconColor: ColorManager.bgSideMenu,
                    gridBackgroundColor: ColorManager.bgColor,
                    menuBackgroundColor: ColorManager.bgColor,
                    rowColor: ColorManager.bgColor,
                    checkedColor: Colors.white,
                    gridBorderRadius: BorderRadius.circular(10),
                  ),
                  columnSize: const PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.scale,
                  ),
                  columnFilter: const PlutoGridColumnFilterConfig(
                    filters: FilterHelper.defaultFilters,
                  ),
                  scrollbar: const PlutoGridScrollbarConfig(
                    isAlwaysShown: false,
                    scrollbarThickness: 8,
                    scrollbarThicknessWhileDragging: 10,
                  ),
                ),
                columns: [
                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Id',
                    field: 'BlbIdField',
                    type: PlutoColumnType.text(),
                  ),
                  PlutoColumn(
                    enableEditingMode: false,
                    title: 'First Name',
                    field: 'FirstNameField',
                    type: PlutoColumnType.text(),
                  ),

                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Second Name',
                    field: 'SecondNameField',
                    type: PlutoColumnType.text(),
                  ),

                  /// Text Column definition
                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Third Name',
                    field: 'ThirdNameField',
                    type: PlutoColumnType.text(),
                  ),
                  PlutoColumn(
                    readOnly: true,
                    title: 'Cohort',
                    field: 'CohortField',
                    cellPadding: EdgeInsets.zero,
                    // titlePadding: EdgeInsets.zero,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    readOnly: true,
                    title: 'Grade',
                    field: 'GradeField',
                    type: PlutoColumnType.text(),
                    cellPadding: EdgeInsets.zero,
                    enableEditingMode: false,
                  ),

                  PlutoColumn(
                    readOnly: true,
                    title: 'Class Room',
                    field: 'ClassRoomField',
                    type: PlutoColumnType.text(),
                    cellPadding: EdgeInsets.zero,
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    readOnly: true,
                    enableEditingMode: false,
                    title: 'Second Language',
                    field: 'LanguageField',
                    type: PlutoColumnType.text(),
                    footerRenderer: (footerRenderer) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: footerRenderer,
                        type: PlutoAggregateColumnType.count,
                        filter: (cell) => true,
                        format: 'count : #,###',
                        alignment: Alignment.center,
                      );
                    },
                  ),
                  PlutoColumn(
                    enableEditingMode: false,
                    title: 'Actions',
                    field: 'ActionsField',
                    type: PlutoColumnType.text(),
                    renderer: (rendererContext) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.includeStudent(rendererContext);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
                rows: controller.excludedStudentsRows,
                onChanged: (PlutoGridOnChangedEvent event) {},
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  controller.excludedStudentsStateManager = event.stateManager;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
