import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../domain/controllers/studentsController/student_controller.dart';
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

            // GetBuilder<StudentController>(
            //   builder: (studentController) => Container(
            //     height: 55,
            //     decoration: BoxDecoration(
            //       color: ColorManager.bgColor,
            //       borderRadius: const BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //       border: Border.all(
            //         color: ColorManager.bgSideMenu,
            //         width: 2,
            //       ),
            //     ),
            // child: Obx(
            //   () {
            //     return DropdownButton<EducationResponse>(
            //       value: studentController.educationTypeController,
            //       borderRadius: BorderRadius.circular(10),
            //       isExpanded: true,
            //       underline: Container(),
            //       hint: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20),
            //         child: Text(
            //           'Select education system',
            //           style: nunitoBold.copyWith(
            //             color: ColorManager.bgSideMenu,
            //             fontSize: 14,
            //           ),
            //         ),
            //       ),
            //       icon: Container(
            //         height: 55,
            //         decoration: BoxDecoration(
            //           border: Border(
            //             left: BorderSide(
            //                 color: ColorManager.bgSideMenu, width: 2),
            //           ),
            //         ),
            //         child: Icon(
            //           Icons.keyboard_arrow_down_rounded,
            //           color: ColorManager.bgSideMenu,
            //         ),
            //       ),
            // items: educationController.educationsByschool
            //     .map<DropdownMenuItem<EducationResponse>>(
            //   (EducationResponse value) {
            //     return DropdownMenuItem<EducationResponse>(
            //       value: value,
            //       child: Padding(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 20),
            //         child: Text(
            //           value.name,
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           softWrap: true,
            //           style: nunitoSemiBold.copyWith(
            //             fontSize: 12,
            //             color: ColorManager.red,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ).toList(),
            // onChanged: (newOne) async {
            // controller.onselectEducation(newOne!);
            // controller.gradeController = null;
            // try {
            //   await gradesController
            //       .getGradesFromServerByEducationId(
            //     newOne.id,
            //   );
            // } catch (e) {
            //   log(e.toString());
            // }
            //       },
            //     );
            //   },
            // ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),

            Expanded(
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
                        : PlutoGrid(
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
                              /// Text Column definition
                              PlutoColumn(
                                readOnly: true,
                                // enableRowChecked: true,
                                enableEditingMode: false,
                                title: 'Id',
                                field: 'IdField',
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                enableEditingMode: false,
                                title: 'First Name',
                                field: 'FirstNameField',
                                type: PlutoColumnType.text(),
                              ),

                              /// Text Column definition
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
                                enableEditingMode: false,
                                title: 'Cohort',
                                field: 'CohortField',
                                type: PlutoColumnType.text(),
                              ),
                              // PlutoColumn(
                              //   readOnly: true,
                              //   enableEditingMode: false,
                              //   title: 'Religion',
                              //   field: 'ReligionField',
                              //   type: PlutoColumnType.text(),
                              // ),

                              /// Number Column definition
                              // PlutoColumn(
                              //   enableEditingMode: false,
                              //   title: 'Citizenship',
                              //   field: 'CitizenshipField',
                              //   type: PlutoColumnType.text(),
                              // ),
                              PlutoColumn(
                                readOnly: true,
                                enableEditingMode: false,
                                title: 'Grade',
                                field: 'GradeField',
                                type: PlutoColumnType.text(),
                              ),

                              /// Select Column definition
                              PlutoColumn(
                                enableEditingMode: false,
                                title: 'Class Room',
                                field: 'ClassRoomField',
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                readOnly: true,
                                enableEditingMode: false,
                                title: 'Second Language',
                                field: 'LanguageField',
                                type: PlutoColumnType.text(),
                              ),

                              /// Actions Column definition
                              PlutoColumn(
                                enableEditingMode: false,
                                title: 'Actions',
                                field: 'ActionsField',
                                type: PlutoColumnType.text(),
                                renderer: (rendererContext) {
                                  return Row(
                                    children: [
                                      // IconButton(
                                      //   onPressed: () {
                                      // log(rendererContext.rowIdx
                                      //     .toString());
                                      // Get.generalDialog(
                                      //   pageBuilder: (context, animation,
                                      //           secondaryAnimation) =>
                                      //       AlertDialog(
                                      //     content: Column(
                                      //       children: [
                                      //         Text(
                                      //             "Student Detials ${controller.students[rendererContext.rowIdx].blbId}"),
                                      //         Row(
                                      //           children: [
                                      //             const Text("Name"),
                                      //             Text(
                                      //               controller
                                      //                   .students[
                                      //                       rendererContext
                                      //                           .rowIdx]
                                      //                   .firstName
                                      //                   .toString(),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Text("Name"),
                                      //             Text(
                                      //               controller
                                      //                   .students[
                                      //                       rendererContext
                                      //                           .rowIdx]
                                      //                   .firstName
                                      //                   .toString(),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Text("Name"),
                                      //             Text(
                                      //               controller
                                      //                   .students[
                                      //                       rendererContext
                                      //                           .rowIdx]
                                      //                   .firstName
                                      //                   .toString(),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Text("Name"),
                                      //             Text(
                                      //               controller.students[
                                      //                       rendererContext
                                      //                           .rowIdx]
                                      //                   .toString(),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Text("Name"),
                                      //             Text(
                                      //               controller
                                      //                   .students[
                                      //                       rendererContext
                                      //                           .rowIdx]
                                      //                   .firstName
                                      //                   .toString(),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Text("Name"),
                                      //             Text(
                                      //               controller
                                      //                   .students[
                                      //                       rendererContext
                                      //                           .rowIdx]
                                      //                   .firstName
                                      //                   .toString(),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             const Text("Name"),
                                      //             Text(
                                      //               controller
                                      //                   .students[
                                      //                       rendererContext
                                      //                           .rowIdx]
                                      //                   .firstName
                                      //                   .toString(),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // );
                                      // if (kDebugMode) {
                                      // }
                                      // },
                                      // icon: const Icon(
                                      //   Icons.menu,
                                      //   color: Colors.black,
                                      // ),
                                      // ),
                                      IconButton(
                                        onPressed: () {
                                          MyDialogs.showDialog(
                                            context,
                                            EditStudentWidget(
                                              studentResModel: controller
                                                  .students
                                                  .firstWhere((element) =>
                                                      int.tryParse(
                                                          rendererContext
                                                              .row
                                                              .cells['IdField']!
                                                              .value
                                                              .toString()) ==
                                                      element.iD),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      // IconButton(
                                      //   onPressed: () {
                                      //     // log(rendererContext.rowIdx.toString());
                                      //     if (kDebugMode) {
                                      //     }
                                      //   },
                                      //   icon: const Icon(
                                      //     Icons.delete,
                                      //     color: Colors.red,
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
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
                            ],
                            rows: controller.studentsRows,
                            onChanged: (PlutoGridOnChangedEvent event) {},
                            onLoaded: (PlutoGridOnLoadedEvent event) {
                              // event.stateManager.setSelectingMode(
                              //   PlutoGridSelectingMode.cell,
                              // );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
