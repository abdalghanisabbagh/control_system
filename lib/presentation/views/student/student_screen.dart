import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/header_student_widget.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: const Column(
          children: [
            /// Header Part
            HeaderStudentWidget(),
            SizedBox(
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
            //     // child: Obx(
            //     //   () {
            //     //     return DropdownButton<EducationResponse>(
            //     //       value: studentController.educationTypeController,
            //     //       borderRadius: BorderRadius.circular(10),
            //     //       isExpanded: true,
            //     //       underline: Container(),
            //     //       hint: Padding(
            //     //         padding: const EdgeInsets.symmetric(horizontal: 20),
            //     //         child: Text(
            //     //           'Select education system',
            //     //           style: nunitoBold.copyWith(
            //     //             color: ColorManager.bgSideMenu,
            //     //             fontSize: 14,
            //     //           ),
            //     //         ),
            //     //       ),
            //     //       icon: Container(
            //     //         height: 55,
            //     //         decoration: BoxDecoration(
            //     //           border: Border(
            //     //             left: BorderSide(
            //     //                 color: ColorManager.bgSideMenu, width: 2),
            //     //           ),
            //     //         ),
            //     //         child: Icon(
            //     //           Icons.keyboard_arrow_down_rounded,
            //     //           color: ColorManager.bgSideMenu,
            //     //         ),
            //     //       ),
            //     //       // items: educationController.educationsByschool
            //     //       //     .map<DropdownMenuItem<EducationResponse>>(
            //     //       //   (EducationResponse value) {
            //     //       //     return DropdownMenuItem<EducationResponse>(
            //     //       //       value: value,
            //     //       //       child: Padding(
            //     //       //         padding:
            //     //       //             const EdgeInsets.symmetric(horizontal: 20),
            //     //       //         child: Text(
            //     //       //           value.name,
            //     //       //           maxLines: 1,
            //     //       //           overflow: TextOverflow.ellipsis,
            //     //       //           softWrap: true,
            //     //       //           style: nunitoSemiBold.copyWith(
            //     //       //             fontSize: 12,
            //     //       //             color: ColorManager.red,
            //     //       //           ),
            //     //       //         ),
            //     //       //       ),
            //     //       //     );
            //     //       //   },
            //     //       // ).toList(),
            //     //       onChanged: (newOne) async {
            //     //         // controller.onselectEducation(newOne!);
            //     //         // controller.gradeController = null;
            //     //         // try {
            //     //         //   await gradesController
            //     //         //       .getGradesFromServerByEducationId(
            //     //         //     newOne.id,
            //     //         //   );
            //     //         // } catch (e) {
            //     //         //   log(e.toString());
            //     //         // }
            //     //       },
            //     //     );
            //     //   },
            //     // ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),

            // Expanded(
            //   child: Obx(
            //     () => controller.isLoading.value
            //         ? const Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : controller.rows.isEmpty
            //             ? const Center(
            //                 child: Text("No Student Found"),
            //               )
            //             : PlutoGrid(
            //                 createFooter: (stateManager) {
            //                   stateManager.setPageSize(50,
            //                       notify: false); // default 40
            //                   return PlutoPagination(stateManager);
            //                 },
            //                 configuration: PlutoGridConfiguration(
            //                   style: PlutoGridStyleConfig(
            //                     enableGridBorderShadow: true,
            //                     iconColor: ColorManager.bgSideMenu,
            //                     gridBackgroundColor: ColorManager.bgColor,
            //                     menuBackgroundColor: ColorManager.bgColor,
            //                     rowColor: ColorManager.bgColor,
            //                     checkedColor: Colors.white,
            //                     gridBorderRadius: BorderRadius.circular(10),
            //                   ),
            //                   columnSize: const PlutoGridColumnSizeConfig(
            //                     autoSizeMode: PlutoAutoSizeMode.scale,
            //                   ),
            //                   columnFilter: const PlutoGridColumnFilterConfig(
            //                     filters: FilterHelper.defaultFilters,
            //                   ),
            //                   scrollbar: const PlutoGridScrollbarConfig(
            //                     isAlwaysShown: false,
            //                     scrollbarThickness: 8,
            //                     scrollbarThicknessWhileDragging: 10,
            //                   ),
            //                 ),
            //                 columns: [
            //                   /// Text Column definition
            //                   PlutoColumn(
            //                     readOnly: true,
            //                     enableRowChecked: true,
            //                     enableEditingMode: false,
            //                     title: 'Id',
            //                     field: 'BlbId',
            //                     type: PlutoColumnType.text(),
            //                   ),

            //                   PlutoColumn(
            //                     enableEditingMode: false,
            //                     title: 'First Name',
            //                     field: 'FirstName',
            //                     type: PlutoColumnType.text(),
            //                   ),

            //                   /// Text Column definition
            //                   PlutoColumn(
            //                     readOnly: true,
            //                     enableEditingMode: false,
            //                     title: 'Middle Name',
            //                     field: 'MiddleName',
            //                     type: PlutoColumnType.text(),
            //                   ),

            //                   /// Text Column definition
            //                   PlutoColumn(
            //                     readOnly: true,
            //                     enableEditingMode: false,
            //                     title: 'Last Name',
            //                     field: 'LastName',
            //                     type: PlutoColumnType.text(),
            //                   ),
            //                   PlutoColumn(
            //                     readOnly: true,
            //                     enableEditingMode: false,
            //                     title: 'Cohort',
            //                     field: 'cohort',
            //                     type: PlutoColumnType.text(),
            //                   ),
            //                   PlutoColumn(
            //                     readOnly: true,
            //                     enableEditingMode: false,
            //                     title: 'Religion',
            //                     field: 'Religion_field',
            //                     type: PlutoColumnType.text(),
            //                   ),

            //                   /// Number Column definition
            //                   PlutoColumn(
            //                     enableEditingMode: false,
            //                     title: 'Citizenship',
            //                     field: 'Citizenship_field',
            //                     type: PlutoColumnType.text(),
            //                   ),
            //                   PlutoColumn(
            //                     readOnly: true,
            //                     enableEditingMode: false,
            //                     title: 'Grade',
            //                     field: 'Grade_field',
            //                     type: PlutoColumnType.text(),
            //                   ),

            //                   /// Select Column definition
            //                   PlutoColumn(
            //                       enableEditingMode: false,
            //                       title: 'Class Room',
            //                       field: 'ClassRoom_field',
            //                       type: PlutoColumnType.text()),

            //                   PlutoColumn(
            //                     readOnly: true,
            //                     enableEditingMode: false,
            //                     title: 'Second Language',
            //                     field: 'Language_field',
            //                     type: PlutoColumnType.text(),
            //                   ),

            //                   /// Actions Column definition
            //                   PlutoColumn(
            //                     enableEditingMode: false,
            //                     title: 'Actions',
            //                     field: 'actions_field',
            //                     type: PlutoColumnType.date(),
            //                     renderer: (rendererContext) {
            //                       return Row(
            //                         children: [
            //                           // IconButton(
            //                           //     onPressed: () {
            //                           //       // log(rendererContext.rowIdx.toString());
            //                           //       Get.generalDialog(
            //                           //         pageBuilder: (context,
            //                           //                 animation,
            //                           //                 secondaryAnimation) =>
            //                           //             AlertDialog(
            //                           //           content: Column(
            //                           //             children: [
            //                           //               Text(
            //                           //                   "Student Detials ${controller.students[rendererContext.rowIdx].blbId}"),
            //                           //               Row(
            //                           //                 children: [
            //                           //                   const Text(
            //                           //                       "Name"),
            //                           //                   Text(controller
            //                           //                       .students[
            //                           //                           rendererContext
            //                           //                               .rowIdx]
            //                           //                       .firstName),
            //                           //                 ],
            //                           //               ),
            //                           //               Row(
            //                           //                 children: [
            //                           //                   const Text(
            //                           //                       "Name"),
            //                           //                   Text(controller
            //                           //                       .students[
            //                           //                           rendererContext
            //                           //                               .rowIdx]
            //                           //                       .firstName),
            //                           //                 ],
            //                           //               ),
            //                           //               Row(
            //                           //                 children: [
            //                           //                   const Text(
            //                           //                       "Name"),
            //                           //                   Text(controller
            //                           //                       .students[
            //                           //                           rendererContext
            //                           //                               .rowIdx]
            //                           //                       .firstName),
            //                           //                 ],
            //                           //               ),
            //                           //               Row(
            //                           //                 children: [
            //                           //                   const Text(
            //                           //                       "Name"),
            //                           //                   Text(controller
            //                           //                       .students[
            //                           //                           rendererContext
            //                           //                               .rowIdx]
            //                           //                       .),
            //                           //                 ],
            //                           //               ),
            //                           //               Row(
            //                           //                 children: [
            //                           //                   const Text(
            //                           //                       "Name"),
            //                           //                   Text(controller
            //                           //                       .students[
            //                           //                           rendererContext
            //                           //                               .rowIdx]
            //                           //                       .firstName),
            //                           //                 ],
            //                           //               ),
            //                           //               Row(
            //                           //                 children: [
            //                           //                   const Text(
            //                           //                       "Name"),
            //                           //                   Text(controller
            //                           //                       .students[
            //                           //                           rendererContext
            //                           //                               .rowIdx]
            //                           //                       .firstName),
            //                           //                 ],
            //                           //               ),
            //                           //               Row(
            //                           //                 children: [
            //                           //                   const Text(
            //                           //                       "Name"),
            //                           //                   Text(controller
            //                           //                       .students[
            //                           //                           rendererContext
            //                           //                               .rowIdx]
            //                           //                       .firstName),
            //                           //                 ],
            //                           //               ),
            //                           //             ],
            //                           //           ),
            //                           //         ),
            //                           //       );
            //                           //       if (kDebugMode) {
            //                           //         print("details");
            //                           //       }
            //                           //     },
            //                           //     icon: const Icon(
            //                           //       Icons.menu,
            //                           //       color: Colors.black,
            //                           //     )),

            //                           IconButton(
            //                             onPressed: () {
            //                               MyDialogs.showAddDialog(
            //                                 context,
            //                                 EditStudentWidget(
            //                                     // studentIndex:
            //                                     //     rendererContext
            //                                     //         .rowIdx,
            //                                     ),
            //                               );

            //                               // if (kDebugMode) {
            //                               //   print("edit");
            //                               // }
            //                             },
            //                             icon: const Icon(
            //                               Icons.edit,
            //                               color: Colors.green,
            //                             ),
            //                           ),
            //                           // IconButton(
            //                           //     onPressed: () {
            //                           //       // log(rendererContext.rowIdx.toString());
            //                           //       if (kDebugMode) {
            //                           //         print("delete");
            //                           //       }
            //                           //     },
            //                           //     icon: const Icon(
            //                           //       Icons.delete,
            //                           //       color: Colors.red,
            //                           //     )),
            //                         ],
            //                       );
            //                     },
            //                     footerRenderer: (footerRenderer) {
            //                       return PlutoAggregateColumnFooter(
            //                         rendererContext: footerRenderer,
            //                         type: PlutoAggregateColumnType.count,
            //                         filter: (cell) => true,
            //                         format: 'count : #,###',
            //                         alignment: Alignment.center,
            //                       );
            //                     },
            //                   ),
            //                 ],
            //                 rows: controller.rows,
            //                 onChanged: (PlutoGridOnChangedEvent event) {
            //                   if (kDebugMode) {
            //                     print(event);
            //                   }
            //                 },
            //                 onLoaded: (PlutoGridOnLoadedEvent event) {
            //                   if (kDebugMode) {
            //                     print(event);
            //                   }
            //                   event.stateManager.setSelectingMode(
            //                     PlutoGridSelectingMode.cell,
            //                   );
            //                 },
            //               ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
