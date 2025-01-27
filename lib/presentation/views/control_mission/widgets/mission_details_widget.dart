import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../domain/controllers/control_mission/review_control_mission_controller.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';

// ignore: must_be_immutable
class MissionDetailsWidget extends GetView<DetailsAndReviewMissionController> {
  late PlutoGridStateManager stateManager;

  MissionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: GetBuilder<DetailsAndReviewMissionController>(
        builder: (_) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Batch Name : ${controller.controlMissionName}",
                    style: nunitoBoldStyle().copyWith(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: (constraints.maxHeight + controller.height) * 0.3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Subjects",
                                    style: nunitoBoldStyle()
                                        .copyWith(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 20,
                                          offset: const Offset(2, 15),
                                        ),
                                      ],
                                      color: ColorManager.ligthBlue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: constraints.maxHeight - 56,
                                    child: GetBuilder<
                                        DetailsAndReviewMissionController>(
                                      builder: (_) {
                                        if (controller.isLoadingGetExamRooms) {
                                          return Center(
                                            child: RepaintBoundary(
                                              child: LoadingIndicators
                                                  .getLoadingIndicator(),
                                            ),
                                          );
                                        } else if (controller
                                            .listExamRoom.isEmpty) {
                                          return Center(
                                            child: Text(
                                              "No items available",
                                              style: nunitoRegular.copyWith(
                                                fontSize: 20,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return ListView.builder(
                                            itemCount:
                                                controller.listSubject.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Subject : ${controller.listSubject[index].name}",
                                                          style: nunitoRegular
                                                              .copyWith(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Classrooms",
                                    style: nunitoBoldStyle()
                                        .copyWith(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 20,
                                            offset: const Offset(2, 15),
                                          ),
                                        ],
                                        color: ColorManager.ligthBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: constraints.maxHeight - 56,
                                    child: GetBuilder<
                                        DetailsAndReviewMissionController>(
                                      builder: (_) => controller
                                              .isLoadingGetExamRooms
                                          ? Center(
                                              child: RepaintBoundary(
                                                child: LoadingIndicators
                                                    .getLoadingIndicator(),
                                              ),
                                            )
                                          : controller.listExamRoom.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "No items available",
                                                    style:
                                                        nunitoRegular.copyWith(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller
                                                      .listExamRoom.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Class Room : ${controller.listExamRoom[index].name!}",
                                                                style:
                                                                    nunitoBlackStyle()
                                                                        .copyWith(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    child: GestureDetector(
                      onVerticalDragUpdate: (DragUpdateDetails details) =>
                          controller.onDragUpdate(details),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 5,
                            width: double.infinity,
                            margin: const EdgeInsets.all(10),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 10,
                            width: 20,
                            decoration: const BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                ':::',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Joined Students",
                          style: nunitoBoldStyle().copyWith(fontSize: 25),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Visibility(
                          visible:
                              Get.find<ProfileController>().canAccessWidget(
                            widgetId: '2301',
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.studentsSeatNumbers.isEmpty
                                        ? MyAwesomeDialogue(
                                            title: 'Error',
                                            desc: "No students found",
                                            dialogType: DialogType.error,
                                          ).showDialogue(
                                            Get.key.currentContext!)
                                        : controller.exportToPdf(context,
                                            controller.studentsSeatNumbersRows);
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorManager.red),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Export to PDF",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.studentsSeatNumbers.isEmpty
                                        ? MyAwesomeDialogue(
                                            title: 'Error',
                                            desc: "No students found",
                                            dialogType: DialogType.error,
                                          ).showDialogue(
                                            Get.key.currentContext!)
                                        : controller.exportToCsv(context,
                                            controller.studentsSeatNumbersRows);
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Export to Excel",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: GetBuilder<DetailsAndReviewMissionController>(
                            builder: (_) => controller
                                    .isLoadingGetStudentsSeatNumbers
                                ? Center(
                                    child: RepaintBoundary(
                                      child: LoadingIndicators
                                          .getLoadingIndicator(),
                                    ),
                                  )
                                : controller.studentsSeatNumbers.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Student Found",
                                          style: nunitoBlack.copyWith(
                                            color: ColorManager.bgSideMenu,
                                            fontSize: 30,
                                          ),
                                        ),
                                      )
                                    : PlutoGrid(
                                        key: UniqueKey(),
                                        noRowsWidget: Center(
                                          child: Text(
                                            "No data found",
                                            style: nunitoBold,
                                          ),
                                        ),
                                        createFooter: (stateManager) {
                                          stateManager
                                            ..setPageSize(50, notify: false)
                                            ..setShowColumnFilter(true);
                                          return PlutoPagination(
                                            stateManager,
                                            pageSizeToMove: 1,
                                          );
                                        },
                                        configuration: PlutoGridConfiguration(
                                          style: PlutoGridStyleConfig(
                                            enableGridBorderShadow: true,
                                            iconColor: ColorManager.bgSideMenu,
                                            gridBackgroundColor:
                                                ColorManager.bgColor,
                                            menuBackgroundColor:
                                                ColorManager.bgColor,
                                            rowColor: ColorManager.bgColor,
                                            checkedColor: Colors.white,
                                            gridBorderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          columnSize:
                                              const PlutoGridColumnSizeConfig(
                                            autoSizeMode:
                                                PlutoAutoSizeMode.scale,
                                          ),
                                          columnFilter:
                                              const PlutoGridColumnFilterConfig(
                                            filters:
                                                FilterHelper.defaultFilters,
                                          ),
                                          scrollbar:
                                              const PlutoGridScrollbarConfig(
                                            isAlwaysShown: false,
                                            scrollbarThickness: 8,
                                            scrollbarThicknessWhileDragging: 10,
                                          ),
                                        ),
                                        columns: [
                                          PlutoColumn(
                                            readOnly: true,
                                            enableEditingMode: false,
                                            title: 'Blb Id',
                                            field: 'BlbIdField',
                                            type: PlutoColumnType.text(),
                                          ),
                                          PlutoColumn(
                                            enableEditingMode: false,
                                            title: 'Name',
                                            field: 'StudentNameField',
                                            type: PlutoColumnType.text(),
                                          ),
                                          PlutoColumn(
                                            readOnly: true,
                                            enableEditingMode: false,
                                            title: 'Seat Number',
                                            field: 'SeatNumberField',
                                            type: PlutoColumnType.text(),
                                          ),
                                          PlutoColumn(
                                            readOnly: true,
                                            enableEditingMode: false,
                                            title: 'Grade',
                                            field: 'GradeField',
                                            type: PlutoColumnType.text(),
                                          ),
                                          PlutoColumn(
                                            readOnly: true,
                                            enableEditingMode: false,
                                            title: 'Class Room',
                                            field: 'ClassRoomField',
                                            cellPadding: EdgeInsets.zero,
                                            type: PlutoColumnType.text(),
                                          ),
                                          PlutoColumn(
                                            readOnly: true,
                                            enableEditingMode: false,
                                            title: 'Cohort',
                                            field: 'CohortField',
                                            type: PlutoColumnType.text(),
                                            cellPadding: EdgeInsets.zero,
                                          ),
                                          PlutoColumn(
                                            enableEditingMode: false,
                                            title: 'Actions',
                                            field: 'ActionsField',
                                            type: PlutoColumnType.text(),
                                            renderer: (rendererContext) {
                                              final isActive = rendererContext
                                                      .row
                                                      .cells['ActionsField']!
                                                      .value ==
                                                  '1';

                                              return Row(
                                                children: [
                                                  Visibility(
                                                    visible: Get.find<
                                                            ProfileController>()
                                                        .canAccessWidget(
                                                      widgetId: '2303',
                                                    ),
                                                    child: IconButton(
                                                      tooltip: isActive
                                                          ? 'Deactivate Student'
                                                          : 'Activate Student',
                                                      onPressed: () {
                                                        if (isActive) {
                                                          MyAwesomeDialogue(
                                                            title:
                                                                'Deactivate Student',
                                                            desc:
                                                                'Are you sure you want to deactivate this student?',
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            btnOkOnPressed: () {
                                                              controller
                                                                  .deActiveStudentInControlMission(
                                                                      idSeat: rendererContext
                                                                          .row
                                                                          .cells[
                                                                              'IdField']!
                                                                          .value)
                                                                  .then(
                                                                (value) {
                                                                  if (value) {
                                                                    MyFlashBar
                                                                        .showSuccess(
                                                                      "Student deactivated successfully",
                                                                      "Success",
                                                                    ).show(Get
                                                                        .key
                                                                        .currentContext!);
                                                                  }
                                                                },
                                                              );
                                                            },
                                                            btnCancelOnPressed:
                                                                () {},
                                                          ).showDialogue(
                                                              context);
                                                        } else {
                                                          MyAwesomeDialogue(
                                                            title:
                                                                'Activate Student',
                                                            desc:
                                                                'Are you sure you want to activate this student?',
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            btnOkOnPressed: () {
                                                              controller
                                                                  .activeStudentInControlMission(
                                                                      idSeat: rendererContext
                                                                          .row
                                                                          .cells[
                                                                              'IdField']!
                                                                          .value)
                                                                  .then(
                                                                (value) {
                                                                  if (value) {
                                                                    MyFlashBar
                                                                        .showSuccess(
                                                                      "Student activated successfully",
                                                                      "Success",
                                                                    ).show(Get
                                                                        .key
                                                                        .currentContext!);
                                                                  }
                                                                },
                                                              );
                                                            },
                                                            btnCancelOnPressed:
                                                                () {},
                                                          ).showDialogue(
                                                              context);
                                                        }
                                                      },
                                                      icon: Icon(
                                                        isActive
                                                            ? Icons.check_circle
                                                            : Icons.cancel,
                                                        color: isActive
                                                            ? ColorManager.green
                                                            : ColorManager.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                        rows:
                                            controller.studentsSeatNumbersRows,
                                        onChanged:
                                            (PlutoGridOnChangedEvent event) {},
                                        onLoaded:
                                            (PlutoGridOnLoadedEvent event) {},
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
