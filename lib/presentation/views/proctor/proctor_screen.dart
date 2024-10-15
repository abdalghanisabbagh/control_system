import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/controllers/controllers.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../base_screen.dart';
import 'widgets/add_new_proctor.dart';
import 'widgets/exam_rooms_widget.dart';
import 'widgets/proctors_widget.dart';

class ProctorScreen extends GetView<ProctorController> {
  const ProctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: GetBuilder<ProctorController>(
        id: 'proctorEntryScreen',
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible:
                                Get.find<ProfileController>().canAccessWidget(
                              widgetId: '10100',
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                MyDialogs.showDialog(
                                  context,
                                  const CreateNewProctor(),
                                );
                              },
                              child: const Text("Create new proctor"),
                            ),
                          )
                        ],
                      ),
                    ),
                    MultiSelectDropDownView(
                      key: ValueKey(controller.optionsEducationYear),
                      hintText: "Select Education Year",
                      multiSelect: false,
                      showChipSelect: true,
                      optionSelected: controller.selectedEducationYearId != null
                          ? [
                              controller.optionsEducationYear.firstWhere(
                                (element) =>
                                    element.value ==
                                    controller.selectedEducationYearId,
                              ),
                            ]
                          : [],
                      onOptionSelected: controller.onEducationYearChange,
                      options: controller.optionsEducationYear,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<ProctorController>(
                        builder: (_) => controller.controlMissionsAreLoading
                            ? SizedBox(
                                width: 50,
                                height: 50,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              )
                            : controller.selectedEducationYearId == null
                                ? Center(
                                    child: Text(
                                      "Please Select Education Year To View Control Missions",
                                      style: nunitoRegular,
                                    ),
                                  )
                                : controller.controlMissions.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Missions Created For Selected Education Year",
                                          style: nunitoRegular,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: MultiSelectDropDownView(
                                              showChipSelect: true,
                                              searchEnabled: true,
                                              multiSelect: false,
                                              options: controller
                                                  .optionsControlMissions,
                                              onOptionSelected: controller
                                                  .onControlMissionsChange,
                                              hintText:
                                                  "Select Control Missions",
                                            ),
                                          ),
                                          IgnorePointer(
                                            ignoring: controller
                                                    .selectedControlMissionsId ==
                                                null,
                                            child: InkWell(
                                              onTap: () {
                                                _selectDate(context);
                                              },
                                              child: Container(
                                                width: 200,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        ColorManager.bgSideMenu,
                                                    width: 0.5,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: TextFormField(
                                                  cursorColor:
                                                      ColorManager.bgSideMenu,
                                                  enabled: false,
                                                  style: nunitoRegular.copyWith(
                                                    fontSize: 14,
                                                  ),
                                                  controller:
                                                      controller.dateController,
                                                  decoration: InputDecoration(
                                                    suffixIcon: const Icon(
                                                      Icons.date_range_outlined,
                                                      color: Colors.black,
                                                    ),
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText:
                                                        'Example: DD/MM/YYYY',
                                                    hintStyle:
                                                        nunitoRegular.copyWith(
                                                      color: ColorManager.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: controller.proctors.isEmpty
                            ? Center(
                                child: Text(
                                  "No Proctors",
                                  style: nunitoRegular.copyWith(
                                    fontSize: 30,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,
                                        border: Border.all(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    "Proctors (${controller.proctors.length})",
                                                    style: nunitoBold.copyWith(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: ProctorsWidget(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Expanded(
                                    flex: 3,
                                    child: ExamRoomsWidget(),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 10,
                );
        },
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.tryParse(controller.controlMissions
              .firstWhereOrNull((element) =>
                  element.iD == controller.selectedControlMissionsId)!
              .startDate!) ??
          DateTime.now(),
      lastDate: DateTime.tryParse(controller.controlMissions
              .firstWhereOrNull((element) =>
                  element.iD == controller.selectedControlMissionsId)!
              .endDate!) ??
          DateTime.now(),
    );
    if (picked != null) {
      controller.selectedDate = picked;
      controller.onDateSelected();
      controller.dateController.text =
          DateFormat('dd MMMM yyyy').format(picked);
    }
  }
}
