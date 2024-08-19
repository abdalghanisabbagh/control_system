import 'package:control_system/presentation/resource_manager/ReusableWidget/my_back_button.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_add_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';

class AddStudentsToControlMissionScreen
    extends GetView<AddNewStudentsToControlMissionController> {
  const AddStudentsToControlMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewStudentsToControlMissionController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: const MyBackButton(),
            title: Text(
              'Add Students',
              style: nunitoBold.copyWith(color: ColorManager.black),
            ),
          ),
          body: controller.isLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : RepaintBoundary(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MultiSelectDropDownView(
                          hintText: 'Select Grades',
                          optionSelected: [
                            ...controller.optionsGrades.where(
                              (element) =>
                                  controller.selectedGradesIds.contains(
                                element.value,
                              ),
                            ),
                          ],
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
                                          controller
                                              .excludeStudent(rendererContext);
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
                              controller.includedStudentsStateManager =
                                  event.stateManager;
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
                                          controller
                                              .includeStudent(rendererContext);
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
                              controller.excludedStudentsStateManager =
                                  event.stateManager;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedAddButton(
                          onPressed: () async {
                            await controller.addStudentsToControlMission().then(
                              (value) {
                                if (value) {
                                  context.mounted
                                      ? context.goNamed(
                                          AppRoutesNamesAndPaths
                                              .distributioncreateMissionScreenName,
                                        )
                                      : null;
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ).paddingSymmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
