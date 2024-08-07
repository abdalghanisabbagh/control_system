import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../domain/controllers/control_mission/review_control_mission_controller.dart';

// ignore: must_be_immutable
class ReviewWidget extends GetView<DetailsAndReviewMissionController> {
  FocusNode searchFoucs = FocusNode();

  ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.bgColor,
      margin: const EdgeInsets.all(10),
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // Row(
          //   children: [
          //     // select grade
          //     Expanded(
          //       child: GetBuilder<CompleteMissionsController>(
          //         builder: (completeMissionsController) => Container(
          //           height: 55,
          //           decoration: BoxDecoration(
          //             color: AppColor.bgColor,
          //             borderRadius: const BorderRadius.all(Radius.circular(15)),
          //             border: Border.all(color: AppColor.bgSideMenu, width: 2),
          //           ),
          //           child: DropdownButton<GradeResponse>(
          //             value: completeMissionsController.gradeSelect[0],
          //             borderRadius: BorderRadius.circular(10),
          //             isExpanded: true,
          //             underline: Container(),
          //             hint: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 20),
          //               child: Text('Select grade',
          //                   style: AppTextStyle.nunitoBold.copyWith(
          //                     color: AppColor.bgSideMenu,
          //                     fontSize: 14,
          //                   )),
          //             ),
          //             icon: Container(
          //               height: 55,
          //               decoration: BoxDecoration(
          //                 border: Border(
          //                   left: BorderSide(
          //                       color: AppColor.bgSideMenu, width: 2),
          //                 ),
          //               ),
          //               child: Icon(Icons.keyboard_arrow_down_rounded,
          //                   color: AppColor.bgSideMenu),
          //             ),
          //             items: completeMissionsController.missionDetials!.grades!
          //                 .map<DropdownMenuItem<GradeResponse>>(
          //                     (GradeResponse value) {
          //               return DropdownMenuItem<GradeResponse>(
          //                 value: value,
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 20),
          //                   child: Text(
          //                     value.name,
          //                     maxLines: 1,
          //                     overflow: TextOverflow.ellipsis,
          //                     softWrap: true,
          //                     style: AppTextStyle.nunitoSemiBold
          //                         .copyWith(fontSize: 12, color: AppColor.red),
          //                   ),
          //                 ),
          //               );
          //             }).toList(),
          //             onChanged: (newOne) {
          //               completeMissionsController.onSelectGrade(newOne!);
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 20,
          //     ),
          //     // select supject

          //     Expanded(
          //       child: GetBuilder<CompleteMissionsController>(
          //         builder: (completeMissionsController) => Container(
          //           height: 55,
          //           decoration: BoxDecoration(
          //             color: AppColor.bgColor,
          //             borderRadius: const BorderRadius.all(Radius.circular(15)),
          //             border: Border.all(color: AppColor.bgSideMenu, width: 2),
          //           ),
          //           child: DropdownButton<SubjectResponse>(
          //             value: completeMissionsController.subjectSelect,
          //             borderRadius: BorderRadius.circular(10),
          //             isExpanded: true,
          //             underline: Container(),
          //             hint: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 20),
          //               child: Text('Select Subject',
          //                   style: AppTextStyle.nunitoBold.copyWith(
          //                     color: AppColor.bgSideMenu,
          //                     fontSize: 14,
          //                   )),
          //             ),
          //             icon: Container(
          //               height: 55,
          //               decoration: BoxDecoration(
          //                 border: Border(
          //                   left: BorderSide(
          //                       color: AppColor.bgSideMenu, width: 2),
          //                 ),
          //               ),
          //               child: Icon(Icons.keyboard_arrow_down_rounded,
          //                   color: AppColor.bgSideMenu),
          //             ),
          //             items: completeMissionsController.selectedSubjectExams
          //                 .map<DropdownMenuItem<SubjectResponse>>(
          //                     (SubjectResponse value) {
          //               return DropdownMenuItem<SubjectResponse>(
          //                 value: value,
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 20),
          //                   child: Text(
          //                     value.name,
          //                     maxLines: 1,
          //                     overflow: TextOverflow.ellipsis,
          //                     softWrap: true,
          //                     style: AppTextStyle.nunitoSemiBold
          //                         .copyWith(fontSize: 12, color: AppColor.red),
          //                   ),
          //                 ),
          //               );
          //             }).toList(),
          //             onChanged: (newOne) async {
          //               completeMissionsController.onSelectSupject(newOne!);
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
          // Expanded(
          //   child: GetBuilder<DetailsAndReviewMissionController>(
          //     builder: (completeMissionsController) =>
          //         completeMissionsController.rows.isEmpty
          //             ? Center(
          //                 child: LoadingIndicators.getLoadingIndicator(),
          //               )
          //             : PlutoGrid(
          //                 configuration: PlutoGridConfiguration(
          //                   enterKeyAction:
          //                       PlutoGridEnterKeyAction.toggleEditing,
          //                   style: PlutoGridStyleConfig(
          //                       gridBorderRadius: BorderRadius.circular(10)),
          //                   columnSize: const PlutoGridColumnSizeConfig(
          //                       autoSizeMode: PlutoAutoSizeMode.equal),
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
          //                   PlutoColumn(
          //                     readOnly: true,
          //                     enableEditingMode: false,
          //                     title: 'Name',
          //                     field: 'name_field',
          //                     type: PlutoColumnType.text(),
          //                   ),
          //                   PlutoColumn(
          //                     readOnly: true,
          //                     enableEditingMode: false,
          //                     title: 'Grade',
          //                     field: 'grade_field',
          //                     type: PlutoColumnType.text(),
          //                   ),
          //                   PlutoColumn(
          //                     readOnly: true,
          //                     enableEditingMode: false,
          //                     title: 'Class',
          //                     field: 'Class',
          //                     type: PlutoColumnType.text(),
          //                   ),
          //                   ...List.generate(
          //                       completeMissionsController
          //                           .selectedSubjectExams.length, (index) {
          //                     final subject = completeMissionsController
          //                         .selectedSubjectExams[index];
          //                     return PlutoColumn(
          //                       readOnly: true,
          //                       enableEditingMode: false,
          //                       title: subject.name,
          //                       field: "${subject.name}_${subject.id}",
          //                       type: PlutoColumnType.text(),
          //                     );
          //                   })
          //                 ],
          //                 rows: completeMissionsController.rows,
          //                 onChanged: (PlutoGridOnChangedEvent event) {
          //                   if (kDebugMode) {
          //                     print(event);
          //                   }

          //                   completeMissionsController.stateManager!
          //                       .notifyListeners();
          //                 },
          //                 createHeader: (stateManager) =>
          //                     _Header(stateManager: stateManager),
          //                 onLoaded: (PlutoGridOnLoadedEvent event) {
          //                   completeMissionsController.getRows();
          //                   if (kDebugMode) {
          //                     print(event);
          //                   }
          //                   event.stateManager
          //                       .setSelectingMode(PlutoGridSelectingMode.cell);

          //                   completeMissionsController.stateManager =
          //                       event.stateManager;
          //                   event.stateManager
          //                       .setSelectingMode(PlutoGridSelectingMode.cell);
          //                 }),
          //   ),
          // ),
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
  // void printToPdfAndShareOrSave() async {
  //   final themeData = pluto_grid_export.ThemeData.withFont(
  //     base: pluto_grid_export.Font.ttf(
  //       await rootBundle.load('assets/fonts/open-sans.ttf'),
  //     ),
  //     bold: pluto_grid_export.Font.ttf(
  //       await rootBundle.load('assets/fonts/open-sans.ttf'),
  //     ),
  //   );

  //   var plutoGridPdfExport = pluto_grid_export.PlutoGridDefaultPdfExport(
  //     title: "All Student Degree",
  //     creator: "Student Degree",
  //     format: pluto_grid_export.PdfPageFormat.a4.landscape,
  //     themeData: themeData,
  //   );

  //   await pluto_grid_export.Printing.sharePdf(
  //       bytes: await plutoGridPdfExport.export(widget.stateManager),
  //       filename: plutoGridPdfExport.getFilename());
  // }

  // void defaultExportGridAsCSV() async {
  //   String title = "All Student Degree";
  //   var exported = const Utf8Encoder().convert(
  //       pluto_grid_export.PlutoGridExport.exportCSV(widget.stateManager));
  //   await GenerateExamCoverSheetPDF.saveAndLaunchFile(exported, "$title.csv");
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              // onTap: printToPdfAndShareOrSave,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.red),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Export to PDF",
                      // style: AppTextStyle.nunitoRegular.copyWith(
                      //   color: ColorManager.white,
                      // ),
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
              //  onTap: defaultExportGridAsCSV,
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
                      // style: AppTextStyle.nunitoRegular.copyWith(
                      //   color: AppColor.white,
                      // ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
