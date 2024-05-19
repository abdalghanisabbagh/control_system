import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';

class MissionDetailsWidget extends StatelessWidget {
  const MissionDetailsWidget({super.key});
  // List<PlutoColumn> columns = [
  //   /// Text Column definition
  //   PlutoColumn(
  //     readOnly: true,
  //     enableEditingMode: false,
  //     title: 'Id',
  //     field: 'blb_id',
  //     type: PlutoColumnType.text(),
  //   ),

  //   /// Text Column definition
  //   PlutoColumn(
  //     readOnly: true,
  //     enableEditingMode: false,
  //     title: 'Student Name',
  //     field: 'name_field',
  //     type: PlutoColumnType.text(),
  //   ),

  //   /// Number Column definition
  //   PlutoColumn(
  //     enableEditingMode: false,
  //     title: 'seat number',
  //     field: 'seat_number',
  //     type: PlutoColumnType.text(),
  //   ),

  //   /// Select Column definition
  //   PlutoColumn(
  //     enableEditingMode: false,
  //     title: 'Grade',
  //     field: 'grade_field',
  //     type: PlutoColumnType.text(),
  //   ),

  //   /// Datetime Column definition
  //   PlutoColumn(
  //     enableEditingMode: false,
  //     title: 'Class',
  //     field: 'Class',
  //     type: PlutoColumnType.text(),
  //   ),

  //   /// Text Column definition
  //   PlutoColumn(
  //     readOnly: true,
  //     // enableRowChecked: true,
  //     enableEditingMode: false,
  //     title: 'Cohort',
  //     field: 'cohort_field',
  //     type: PlutoColumnType.text(),
  //   ),

  //   /// Datetime Column definition
  //   PlutoColumn(
  //     enableEditingMode: false,
  //     title: 'Actions',
  //     field: 'actions_field',
  //     type: PlutoColumnType.date(),
  //     renderer: (rendererContext) {
  //       return Row(
  //         children: [
  //           IconButton(
  //               onPressed: () {
  //                 log(rendererContext.rowIdx.toString());
  //               },
  //               icon: const Icon(Icons.density_small)),
  //           IconButton(
  //               onPressed: () {
  //                 log(rendererContext.rowIdx.toString());
  //               },
  //               icon: const Icon(Icons.edit)),
  //           IconButton(
  //               onPressed: () {
  //                 log(rendererContext.rowIdx.toString());
  //               },
  //               icon: const Icon(Icons.delete)),
  //         ],
  //       );
  //     },
  //   ),
  // ];
  // late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // child: GetBuilder<ReviewMissionControllers>(
      //   builder: (reviewMissionControllers) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           "Batch Name : ${reviewMissionControllers.selectMission!.name!}",
      //           style: nunitoBold.copyWith(color: Colors.black, fontSize: 30),
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     "Subjects",
      //                     style: nunitoBold.copyWith(
      //                         color: Colors.black, fontSize: 30),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   Container(
      //                     margin: const EdgeInsets.all(5),
      //                     padding: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 20,
      //                             offset: const Offset(
      //                                 2, 15), // changes position of shadow
      //                           ),
      //                         ],
      //                         color: ColorManager.ligthBlue,
      //                         borderRadius: BorderRadius.circular(10)),
      //                     height: 200,
      //                     // child: GetBuilder<CompleteMissionsController>(
      //                     //   builder: (completeMissionsController) =>
      //                     //       completeMissionsController.missionDetials ==
      //                     //               null
      //                     //           ? const Center(
      //                     //               child: CircularProgressIndicator(),
      //                     //             )
      //                     //           // : ListView.builder(
      //                     //           //     itemCount: completeMissionsController
      //                     //           //         .missionDetials!
      //                     //           //         .exammission!
      //                     //           //         .length,
      //                     //           //     itemBuilder: (context, index) {
      //                     //           //       return const Padding(
      //                     //           //         padding: EdgeInsets.all(8.0),
      //                     //           //         child: Row(
      //                     //           //           mainAxisAlignment:
      //                     //           //               MainAxisAlignment
      //                     //           //                   .spaceBetween,
      //                     //           //           crossAxisAlignment:
      //                     //           //               CrossAxisAlignment.center,
      //                     //           //           children: [
      //                     //           //             // Text(reviewMissionControllers.selectMission.studentseatnumbers.forEach((element) {element.students.subjects.forEach((element) {element.name})})),
      //                     //           //             Column(
      //                     //           //               crossAxisAlignment:
      //                     //           //                   CrossAxisAlignment.start,
      //                     //           //               children: [
      //                     //           //                 // Text(
      //                     //           //                 //     "Subject : ${completeMissionsController.missionDetials!.exammission![index].subjects!.name}"),
      //                     //           //                 // Text(
      //                     //           //                 //   completeMissionsController
      //                     //           //                 //       .missionDetials!
      //                     //           //                 //       .exammission![index]
      //                     //           //                 //       .grades!
      //                     //           //                 //       .name,
      //                     //           //                 // )
      //                     //           //               ],
      //                     //           //             ),
      //                     //           //             // Row(
      //                     //           //             //   children: [
      //                     //           //             //     IconButton(
      //                     //           //             //         onPressed: () {},
      //                     //           //             //         icon: const Icon(
      //                     //           //             //           Icons.edit,
      //                     //           //             //           size: 30,
      //                     //           //             //           color: Colors.green,
      //                     //           //             //         )),
      //                     //           //             //     IconButton(
      //                     //           //             //         onPressed: () {},
      //                     //           //             //         icon: const Icon(
      //                     //           //             //           Icons.delete,
      //                     //           //             //           size: 30,
      //                     //           //             //           color: Colors.red,
      //                     //           //             //         ))
      //                     //           //             //   ],
      //                     //           //             // )
      //                     //           //           ],
      //                     //           //         ),
      //                     //           //       );
      //                     //           //     },
      //                     //           //   ),
      //                     // ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             const SizedBox(
      //               width: 20,
      //             ),
      //             Expanded(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     "Classrooms",
      //                     style: nunitoBold.copyWith(
      //                         color: Colors.black, fontSize: 30),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   Container(
      //                     margin: const EdgeInsets.all(5),
      //                     padding: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.grey.withOpacity(0.5),
      //                             spreadRadius: 5,
      //                             blurRadius: 20,
      //                             offset: const Offset(
      //                                 2, 15), // changes position of shadow
      //                           ),
      //                         ],
      //                         color: ColorManager.ligthBlue,
      //                         borderRadius: BorderRadius.circular(10)),
      //                     height: 200,
      //                     // child: GetBuilder<CompleteMissionsController>(
      //                     //   builder: (completeMissionsController) =>
      //                     //       completeMissionsController.missionDetials ==
      //                     //               null
      //                     //           ? const Center(
      //                     //               child: CircularProgressIndicator(),
      //                     //             )
      //                     //           : ListView.builder(
      //                     //               itemCount: completeMissionsController
      //                     //                   .missionDetials!.examrooms!.length,
      //                     //               itemBuilder: (context, index) {
      //                     //                 return Padding(
      //                     //                   padding: const EdgeInsets.all(8.0),
      //                     //                   child: Row(
      //                     //                     mainAxisAlignment:
      //                     //                         MainAxisAlignment
      //                     //                             .spaceBetween,
      //                     //                     crossAxisAlignment:
      //                     //                         CrossAxisAlignment.center,
      //                     //                     children: [
      //                     //                       Column(
      //                     //                         crossAxisAlignment:
      //                     //                             CrossAxisAlignment.start,
      //                     //                         children: [
      //                     //                           Text(
      //                     //                               completeMissionsController
      //                     //                                   .missionDetials!
      //                     //                                   .examrooms![index]
      //                     //                                   .name!),
      //                     //                           Text(
      //                     //                               completeMissionsController
      //                     //                                   .missionDetials!
      //                     //                                   .examrooms![index]
      //                     //                                   .capacity!
      //                     //                                   .toString())
      //                     //                         ],
      //                     //                       ),
      //                     //                       // Row(
      //                     //                       //   children: [
      //                     //                       //     IconButton(
      //                     //                       //         onPressed: () {},
      //                     //                       //         icon: const Icon(
      //                     //                       //           Icons.edit,
      //                     //                       //           size: 30,
      //                     //                       //           color: Colors.green,
      //                     //                       //         )),
      //                     //                       //     IconButton(
      //                     //                       //         onPressed: () {},
      //                     //                       //         icon: const Icon(
      //                     //                       //           Icons.delete,
      //                     //                       //           size: 30,
      //                     //                       //           color: Colors.red,
      //                     //                       //         ))
      //                     //                       //   ],
      //                     //                       // )
      //                     //                     ],
      //                     //                   ),
      //                     //                 );
      //                     //               },
      //                     //             ),
      //                     // ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Joined Students",
      //                 style: nunitoBold.copyWith(
      //                     color: Colors.black, fontSize: 30),
      //               ),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //               // Expanded(
      //               //     // child: GetBuilder<CompleteMissionsController>(
      //               //     //   builder: (completeMissionsController) =>
      //               //     //       completeMissionsController.missionDetials == null
      //               //     //           ? const Center(
      //               //     //               child: CircularProgressIndicator(),
      //               //     //             )
      //               //     //           : PlutoGrid(
      //               //     //               configuration: PlutoGridConfiguration(
      //               //     //                 style: PlutoGridStyleConfig(
      //               //     //                     gridBorderRadius:
      //               //     //                         BorderRadius.circular(10)),
      //               //     //                 columnSize:
      //               //     //                     const PlutoGridColumnSizeConfig(
      //               //     //                         autoSizeMode:
      //               //     //                             PlutoAutoSizeMode.equal),
      //               //     //                 columnFilter:
      //               //     //                     const PlutoGridColumnFilterConfig(
      //               //     //                   filters: FilterHelper.defaultFilters,
      //               //     //                 ),
      //               //     //                 scrollbar: const PlutoGridScrollbarConfig(
      //               //     //                   isAlwaysShown: false,
      //               //     //                   scrollbarThickness: 8,
      //               //     //                   scrollbarThicknessWhileDragging: 10,
      //               //     //                 ),
      //               //     //               ),
      //               //     //               columns: columns,
      //               //     //               rows: [
      //               //     //                 for (var grade
      //               //     //                     in completeMissionsController
      //               //     //                         .missionDetials!.grades!)
      //               //     //                   ...List.generate(
      //               //     //                     grade.studentseatnumbers!.length,
      //               //     //                     (i) {
      //               //     //                       final obj =
      //               //     //                           grade.studentseatnumbers![i];

      //               //     //                       CohortResponse? cohortresponse;
      //               //     //                       try {
      //               //     //                         cohortresponse =
      //               //     //                             StudentServices.getCohort(
      //               //     //                                 id: obj
      //               //     //                                     .students?.cohertId);
      //               //     //                       } catch (e) {
      //               //     //                         print(e);
      //               //     //                       }

      //               //     //                       String cohortName =
      //               //     //                           cohortresponse != null
      //               //     //                               ? cohortresponse.name
      //               //     //                               : "no cohort";
      //               //     //                       return PlutoRow(
      //               //     //                         cells: {
      //               //     //                           'blb_id': PlutoCell(
      //               //     //                               value: obj.students?.blbId
      //               //     //                                   .toString()),
      //               //     //                           'name_field': PlutoCell(
      //               //     //                               value:
      //               //     //                                   '${obj.students?.firstName} ${obj.students?.middleName}'),
      //               //     //                           'seat_number': PlutoCell(
      //               //     //                               value: obj.seatNumbers
      //               //     //                                   .toString()),
      //               //     //                           'grade_field': PlutoCell(
      //               //     //                               value: StudentServices
      //               //     //                                       .getGrade(
      //               //     //                                           id: obj
      //               //     //                                               .gradesId)
      //               //     //                                   .name),
      //               //     //                           'Class': PlutoCell(
      //               //     //                               value: StudentServices
      //               //     //                                       .getClass(
      //               //     //                                           id: obj.students
      //               //     //                                               ?.classId)
      //               //     //                                   ?.name),
      //               //     //                           'cohort_field': PlutoCell(
      //               //     //                               value: cohortName),
      //               //     //                           'actions_field': PlutoCell(
      //               //     //                               value: '2020-08-08'),
      //               //     //                         },
      //               //     //                       );
      //               //     //                     },
      //               //     //                   )
      //               //     //               ],
      //               //     //               createHeader: (stateManager) =>
      //               //     //                   _Header(stateManager: stateManager),
      //               //     //               onChanged: (PlutoGridOnChangedEvent event) {
      //               //     //                 if (kDebugMode) {
      //               //     //                   print(event);
      //               //     //                 }
      //               //     //               },
      //               //     //               onLoaded: (PlutoGridOnLoadedEvent event) {
      //               //     //                 if (kDebugMode) {
      //               //     //                   print(event);
      //               //     //                 }
      //               //     //                 event.stateManager.setSelectingMode(
      //               //     //                     PlutoGridSelectingMode.cell);

      //               //     //                 stateManager = event.stateManager;
      //               //     //                 event.stateManager.setSelectingMode(
      //               //     //                     PlutoGridSelectingMode.cell);
      //               //     //               },
      //               //     //             ),
      //               //     // ),
      //               //     ),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header();

  // final PlutoGridStateManager stateManager;

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
  //     title: "All Student patch",
  //     creator: "Student Degree",
  //     format: pluto_grid_export.PdfPageFormat.a4.landscape,
  //     themeData: themeData,
  //   );

  //   await pluto_grid_export.Printing.sharePdf(
  //       bytes: await plutoGridPdfExport.export(widget.stateManager),
  //       filename: plutoGridPdfExport.getFilename());
  // }

  // void defaultExportGridAsCSV() async {
  //   String title = "All Student patch";
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Export to PDF",
                      style: nunitoRegular.copyWith(
                        color: ColorManager.white,
                      ),
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
              // onTap: defaultExportGridAsCSV,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Export to Excel",
                      style: nunitoRegular.copyWith(
                        color: ColorManager.white,
                      ),
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
