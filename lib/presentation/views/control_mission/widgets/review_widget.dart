import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../domain/controllers/control_mission/review_control_mission_controller.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';

// ignore: must_be_immutable
class ReviewWidget extends GetView<DetailsAndReviewMissionController> {
  FocusNode searchFocus = FocusNode();

  ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.bgColor,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GetBuilder<DetailsAndReviewMissionController>(
              builder: (completeMissionsController) =>
                  completeMissionsController.isLoadingGetStudentsGrades
                      ? Center(
                          child: LoadingIndicators.getLoadingIndicator(),
                        )
                      : PlutoGrid(
                          key: const ValueKey('review_widget'),
                          noRowsWidget: Center(
                            child: Text(
                              "No data found",
                              style: nunitoBold,
                            ),
                          ),
                          configuration: PlutoGridConfiguration(
                            enterKeyAction:
                                PlutoGridEnterKeyAction.toggleEditing,
                            style: PlutoGridStyleConfig(
                              gridBorderRadius: BorderRadius.circular(10),
                            ),
                            columnSize: const PlutoGridColumnSizeConfig(
                              autoSizeMode: PlutoAutoSizeMode.equal,
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
                          columns:
                              completeMissionsController.studentsGradesColumns,
                          rows: completeMissionsController.studentsGradesRows,
                          onChanged: (PlutoGridOnChangedEvent event) {
                            // completeMissionsController
                            //     .studentsGradesPlutoGridStateManager!
                            //     .notifyListeners();
                          },
                          createFooter: (stateManager) {
                            stateManager.setPageSize(50, notify: false);
                            return PlutoPagination(
                              stateManager,
                              pageSizeToMove: 1,
                            );
                          },
                          createHeader: (stateManager) =>
                              _Header(stateManager: stateManager),
                          onLoaded: (PlutoGridOnLoadedEvent event) {
                            completeMissionsController.applyDefaultSorting();
                            event.stateManager
                              ..setSelectingMode(PlutoGridSelectingMode.cell)
                              ..setShowColumnFilter(true);
                            completeMissionsController
                                    .studentsGradesPlutoGridStateManager =
                                event.stateManager;
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatefulWidget {
  final PlutoGridStateManager stateManager;

  const _Header({
    required this.stateManager,
  });

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Visibility(
        visible: Get.find<ProfileController>().canAccessWidget(
          widgetId: '2302',
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Get.find<DetailsAndReviewMissionController>()
                    .exportStudentDegreesToExcel(context),
                child: Container(
                  height: 55,
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
    );
  }
}
