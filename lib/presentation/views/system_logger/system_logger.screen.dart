import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../domain/controllers/system_logger_controller.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../base_screen.dart';

class SystemLoggerScreen extends GetView<SystemLoggerController> {
  const SystemLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: GetBuilder<SystemLoggerController>(
        builder: (_) {
          if (controller.isLoadingGetSystemLogs) {
            return Center(
              child: LoadingIndicators.getLoadingIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 600;

                return Column(
                  children: [
                    if (isWideScreen) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "System Logs",
                            style: nunitoBoldStyle(),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.exportText();
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Export To Text File"),
                                    Icon(Icons.download),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  controller.exportExcel();
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Export To Excel File"),
                                    Icon(Icons.upload_file_rounded),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  controller.resetAndExportToText();
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Reset Logs And Export To Text File"),
                                    Icon(Icons.fact_check_outlined),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ] else ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "System Logs",
                            style: nunitoBoldStyle(),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              controller.exportText();
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Export To Text File"),
                                Icon(Icons.download),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              controller.exportExcel();
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Export To Excel File"),
                                Icon(Icons.upload_file_rounded),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 10),
                    Expanded(
                      child: RepaintBoundary(
                        child: PlutoGrid(
                          key: const ValueKey('systemLogsTable'),
                          onLoaded: (PlutoGridOnLoadedEvent event) {
                            controller.stateManager = event.stateManager
                              ..setPageSize(30)
                              ..setShowColumnFilter(true);
                          },
                          createFooter: (stateManager) {
                            return PlutoInfinityScrollRows(
                              fetch: controller
                                  .getSystemLogsRowsWithPaginationFromServer,
                              initialFetch: true,
                              stateManager: stateManager,
                              fetchWithFiltering: false,
                              fetchWithSorting: false,
                            );
                          },
                          configuration: PlutoGridConfiguration(
                            style: PlutoGridStyleConfig(
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
                              filters: [],
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
                              title: "IP Address",
                              field: "Ip Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "User Agent",
                              field: "UserAgent Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "Body",
                              field: "Body Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "Platform",
                              field: "Platform Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "Url",
                              field: "Url Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "Method",
                              field: "Method Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "User Id",
                              field: "UserId Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "Full Name",
                              field: "FullName Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "User Type",
                              field: "User Type Field",
                              type: PlutoColumnType.text(),
                            ),
                            PlutoColumn(
                              readOnly: true,
                              enableEditingMode: false,
                              title: "Created At",
                              field: "CreatedAt Field",
                              type: PlutoColumnType.text(),
                            ),
                            // PlutoColumn(
                            //   readOnly: true,
                            //   enableEditingMode: false,
                            //   title: "Actions",
                            //   field: "ActionsField",
                            //   type: PlutoColumnType.text(),
                            //   renderer: (rendererContext) {
                            //     return Center(
                            //       child: IconButton(
                            //         tooltip: "User Info",
                            //         icon: const Icon(
                            //           Icons.person_search_rounded,
                            //           color: ColorManager.newStatus,
                            //         ),
                            //         onPressed: () {
                            //           MyDialogs.showDialog(
                            //             context,
                            //             const UserInfoWidget(),
                            //           );
                            //           controller.getUserInfo(rendererContext
                            //               .row.cells['UserId Field']?.value);
                            //         },
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                          rows: controller.systemLogsRows,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
