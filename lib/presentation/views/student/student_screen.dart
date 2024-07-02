import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../domain/controllers/students_controllers/student_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/index.dart';
import '../base_screen.dart';
import 'widgets/edit_student_widget.dart';
import 'widgets/header_student_widget.dart';

class StudentScreen extends GetView<StudentController> {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Header Part
            const HeaderStudentWidget(),
            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: RepaintBoundary(
                child: GetBuilder<StudentController>(
                  builder: (_) => controller.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.studentsRows.isEmpty
                          ? Center(
                              child: Text(
                                "No Student Found",
                                style: nunitoBlack.copyWith(
                                  color: ColorManager.bgSideMenu,
                                  fontSize: 30,
                                ),
                              ),
                            )
                          : RepaintBoundary(
                              child: PlutoGrid(
                                key: UniqueKey(),
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
                                  columnFilter:
                                      const PlutoGridColumnFilterConfig(
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
                                    title: 'Blb Id',
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

                                  PlutoColumn(
                                    readOnly: true,
                                    enableEditingMode: false,
                                    title: 'Third Name',
                                    field: 'ThirdNameField',
                                    type: PlutoColumnType.text(),
                                  ),
                                  PlutoColumn(
                                    readOnly: true,
                                    enableEditingMode: false,
                                    title: 'Cohort',
                                    field: 'CohortField',
                                    cellPadding: EdgeInsets.zero,
                                    // titlePadding: EdgeInsets.zero,
                                    type: PlutoColumnType.text(),
                                    renderer: (context) {
                                      final String? cohortValue =
                                          context.cell.value;
                                      final bool isDefaultcohort =
                                          cohortValue != null &&
                                              cohortValue.startsWith('[ERROR]');
                                      final String? displayValue =
                                          isDefaultcohort
                                              ? cohortValue.substring(7)
                                              : cohortValue;

                                      return Container(
                                        color: isDefaultcohort
                                            ? Colors.red
                                            : Colors.transparent,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            displayValue!,
                                            style: TextStyle(
                                                color: isDefaultcohort
                                                    ? Colors.black
                                                    : Colors.black),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  PlutoColumn(
                                    readOnly: true,
                                    enableEditingMode: false,
                                    title: 'Grade',
                                    field: 'GradeField',
                                    type: PlutoColumnType.text(),
                                    cellPadding: EdgeInsets.zero,
                                    renderer: (context) {
                                      final String? gradeValue =
                                          context.cell.value;
                                      final bool isDefaultGrade =
                                          gradeValue != null &&
                                              gradeValue.startsWith('[ERROR]');
                                      final String? displayValue =
                                          isDefaultGrade
                                              ? gradeValue.substring(7)
                                              : gradeValue;

                                      return Container(
                                        color: isDefaultGrade
                                            ? Colors.red
                                            : Colors.transparent,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            displayValue!,
                                            style: TextStyle(
                                                color: isDefaultGrade
                                                    ? Colors.black
                                                    : Colors.black),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  PlutoColumn(
                                    readOnly: true,
                                    enableEditingMode: false,
                                    title: 'Class Room',
                                    field: 'ClassRoomField',
                                    type: PlutoColumnType.text(),
                                    cellPadding: EdgeInsets.zero,
                                    renderer: (context) {
                                      final String? classRoomValue =
                                          context.cell.value;
                                      final bool isDefaultClassRoom =
                                          classRoomValue != null &&
                                              classRoomValue
                                                  .startsWith('[ERROR]');
                                      final String? displayValue =
                                          isDefaultClassRoom
                                              ? classRoomValue.substring(7)
                                              : classRoomValue;

                                      return Container(
                                        color: isDefaultClassRoom
                                            ? Colors.red
                                            : Colors.transparent,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            displayValue!,
                                            style: TextStyle(
                                                color: isDefaultClassRoom
                                                    ? Colors.black
                                                    : Colors.black),
                                          ),
                                        ),
                                      );
                                    },
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

                                  /// Actions Column definition

                                  if (!controller.isImported)
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
                                                MyDialogs.showDialog(
                                                  context,
                                                  EditStudentWidget(
                                                    studentResModel: controller
                                                        .students
                                                        .firstWhere((element) {
                                                      return int.tryParse(
                                                              rendererContext
                                                                  .row
                                                                  .cells[
                                                                      'BlbIdField']!
                                                                  .value
                                                                  .toString()) ==
                                                          element.blbId;
                                                    }),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                ],
                                rows: controller.studentsRows,
                                onChanged: (PlutoGridOnChangedEvent event) {},
                                onLoaded: (PlutoGridOnLoadedEvent event) {},
                              ),
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
