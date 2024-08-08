import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';

import '../control_mission/widgets/review_mission_header_widget.dart';

class ExamRoomScreen extends StatelessWidget {
  static List<Color> mycolors = const [
    Color.fromARGB(255, 222, 12, 12),
    Color.fromARGB(255, 238, 158, 21),
    Color.fromARGB(255, 192, 179, 38),
    Color.fromARGB(255, 37, 202, 216),
    Color.fromARGB(255, 43, 63, 212),
    Color.fromARGB(255, 177, 12, 163),
    Color.fromARGB(255, 215, 22, 67),
    Color.fromARGB(255, 37, 202, 216),
    Color.fromARGB(255, 209, 77, 30),
    Color.fromARGB(255, 43, 63, 212),
    Color.fromARGB(255, 146, 98, 14),
    Color.fromARGB(255, 88, 3, 22),
  ];

  const ExamRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        color: ColorManager.bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // Get.back();
                    },
                    icon: const Icon(Icons.arrow_back)),

                // get exam room name
                const ReviewMissionHeaderWidget(
                  title: "Exam Room : " /*${controller.currentRoom!.name}*/,
                ),
                const Spacer(),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        // controller.autoSetStudents();
                      },
                      child: const Text("Auto Generate(Simple)"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        // controller.autoSetStudentCrosess();
                      },
                      child: const Text("Auto Generate(Crosses)"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        // controller.removeAllStudent();
                      },
                      child: const Text("Remove All"),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 40),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 20,
                            offset: const Offset(
                              2,
                              15,
                            ), // changes position of shadow
                          ),
                        ],
                        color: ColorManager.ligthBlue,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorManager.bgSideMenu,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(11),
                                topRight: Radius.circular(11),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Exam Room Students",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // CompleteMissionsController
                                    //     completeMissionsController = Get.find();
                                    // controller.newGrades =
                                    //     completeMissionsController
                                    //         .missionDetials?.grades;

                                    // for (int i = 0;
                                    //     i < controller.newGrades!.length;) {
                                    //   controller.newGrades![i]
                                    //           .studentseatnumbers =
                                    //       controller
                                    //           .newGrades![i].studentseatnumbers!
                                    //           .where((stud) =>
                                    //               stud.desk == null ||
                                    //               stud.desk!.schoolclassId ==
                                    //                   controller
                                    //                       .selectedExamRoom!
                                    //                       .id!)
                                    //           .toList();
                                    //   i++;
                                    // }

                                    // MyDialogs.showAddDialog(
                                    //   context,
                                    //   AddGroupDialog(),
                                    // );
                                  },
                                  icon: Icon(
                                    Icons.person_add,
                                    color: ColorManager.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Expanded(
                          //     // child: GetBuilder<DistrbutionController>(
                          //     //   builder: (distrbutionController) =>
                          //     //       ListView.builder(
                          //     //     itemCount:
                          //     //         distrbutionController.studentsTosets.length,
                          //     //     itemBuilder: (context, i) {
                          //     //       final gradeStudents = distrbutionController
                          //     //               .studentsTosets.values
                          //     //               .elementAt(i) ??
                          //     //           [];
                          //     //       return gradeStudents.isEmpty
                          //     //           ? const SizedBox.shrink()
                          //     //           : Container(
                          //     //               padding: const EdgeInsets.symmetric(
                          //     //                   horizontal: 10, vertical: 20),
                          //     //               child: ListView.builder(
                          //     //                 shrinkWrap: true,
                          //     //                 itemCount: gradeStudents.length,
                          //     //                 itemBuilder: (context, index) {
                          //     //                   final gradeStud =
                          //     //                       gradeStudents[index];

                          //     //                   return Container(
                          //     //                     padding:
                          //     //                         const EdgeInsets.all(10),
                          //     //                     margin:
                          //     //                         const EdgeInsets.all(10),
                          //     //                     decoration: BoxDecoration(
                          //     //                         boxShadow: [
                          //     //                           BoxShadow(
                          //     //                             color: Colors.grey
                          //     //                                 .withOpacity(0.5),
                          //     //                             spreadRadius: 5,
                          //     //                             blurRadius: 10,
                          //     //                             offset: const Offset(2,
                          //     //                                 3), // changes position of shadow
                          //     //                           ),
                          //     //                         ],
                          //     //                         color: mycolors[gradeStud
                          //     //                                     .gradesId! %
                          //     //                                 12]
                          //     //                             .withOpacity(0.5),
                          //     //                         borderRadius:
                          //     //                             BorderRadius.circular(
                          //     //                                 10)),
                          //     //                     child: Row(
                          //     //                       mainAxisAlignment:
                          //     //                           MainAxisAlignment
                          //     //                               .spaceBetween,
                          //     //                       children: [
                          //     //                         Expanded(
                          //     //                           child: Column(
                          //     //                             crossAxisAlignment:
                          //     //                                 CrossAxisAlignment
                          //     //                                     .start,
                          //     //                             children: [
                          //     //                               Text(
                          //     //                                 "Name : ${gradeStud.students!.firstName!} ${gradeStud.students!.middleName!} ${gradeStud.students!.lastName!}",
                          //     //                                 style:                                                                 .nunitoRegular
                          //     //                                     .copyWith(
                          //     //                                         color: ColorManager
                          //     //                                             .bgSideMenu,
                          //     //                                         fontSize:
                          //     //                                             12),
                          //     //                                 softWrap: true,
                          //     //                                 overflow:
                          //     //                                     TextOverflow
                          //     //                                         .ellipsis,
                          //     //                                 maxLines: 2,
                          //     //                               ),
                          //     //                               Text(
                          //     //                                   "Seat NO : ${gradeStud.seatNumbers}",
                          //     //                                   style:                                                                   .nunitoRegular
                          //     //                                       .copyWith(
                          //     //                                           color: ColorManager
                          //     //                                               .bgSideMenu,
                          //     //                                           fontSize:
                          //     //                                               16)),
                          //     //                               // Text(
                          //     //                               //     "Grade: ${StudentServices.getGrade(id: gradeStud.gradesId).name}",
                          //     //                               //     style:                                                                   .nunitoRegular
                          //     //                               //         .copyWith(
                          //     //                               //             color: ColorManager
                          //     //                               //                 .bgSideMenu,
                          //     //                               //             fontSize:
                          //     //                               //                 16))
                          //     //                             ],
                          //     //                           ),
                          //     //                         ),
                          //     //                         Container(
                          //     //                           height: 40,
                          //     //                           decoration: BoxDecoration(
                          //     //                             color: const Color(
                          //     //                                 0xffF2F2F2),
                          //     //                             borderRadius:
                          //     //                                 const BorderRadius
                          //     //                                     .all(
                          //     //                                     Radius.circular(
                          //     //                                         10)),
                          //     //                             border: Border.all(
                          //     //                               color: ColorManager
                          //     //                                   .white,
                          //     //                               width: 2,
                          //     //                             ),
                          //     //                           ),
                          //     //                           padding:
                          //     //                               const EdgeInsets.all(
                          //     //                             8,
                          //     //                           ),
                          //     //                           child: DropdownButton<
                          //     //                               String>(
                          //     //                             value: distrbutionController
                          //     //                                     .selectedSeat[
                          //     //                                 gradeStud
                          //     //                                     .seatNumbers],
                          //     //                             underline: Container(),
                          //     //                             hint: Padding(
                          //     //                               padding:
                          //     //                                   const EdgeInsets
                          //     //                                       .symmetric(
                          //     //                                       horizontal:
                          //     //                                           5),
                          //     //                               child: Text(
                          //     //                                 "select seat",
                          //     //                                 style:                                                                 .nunitoBold
                          //     //                                     .copyWith(
                          //     //                                   color: ColorManager
                          //     //                                       .bgSideMenu,
                          //     //                                   fontSize: 14,
                          //     //                                 ),
                          //     //                               ),
                          //     //                             ),
                          //     //                             borderRadius:
                          //     //                                 BorderRadius
                          //     //                                     .circular(10),
                          //     //                             icon: Container(
                          //     //                               height: 40,
                          //     //                               decoration:
                          //     //                                   const BoxDecoration(
                          //     //                                 border: Border(
                          //     //                                   left: BorderSide(
                          //     //                                     color: Colors
                          //     //                                         .white,
                          //     //                                     width: 2,
                          //     //                                   ),
                          //     //                                 ),
                          //     //                               ),
                          //     //                               child: const Icon(
                          //     //                                 Icons
                          //     //                                     .keyboard_arrow_down_rounded,
                          //     //                                 color: Color(
                          //     //                                   0xff7E8389,
                          //     //                                 ),
                          //     //                               ),
                          //     //                             ),
                          //     //                             style:                                                             .nunitoRegular
                          //     //                                 .copyWith(
                          //     //                                     color: ColorManager
                          //     //                                         .bgSideMenu,
                          //     //                                     fontSize: 16),
                          //     //                             onChanged:
                          //     //                                 (String? value) {
                          //     //                               distrbutionController
                          //     //                                   .changeSeatVal(
                          //     //                                       gradeStud
                          //     //                                           .seatNumbers!,
                          //     //                                       value!);

                          //     //                               distrbutionController
                          //     //                                   .addSeatsToRender(
                          //     //                                 rowcolumn: value,
                          //     //                                 examRoomId:
                          //     //                                     controller
                          //     //                                         .currentRoom!
                          //     //                                         .id!,
                          //     //                                 studNumber:
                          //     //                                     gradeStud,
                          //     //                               );
                          //     //                             },
                          //     //                             items: distrbutionController
                          //     //                                 .allSeatsIds.values
                          //     //                                 .map<
                          //     //                                     DropdownMenuItem<
                          //     //                                         String>>(
                          //     //                               (String value) {
                          //     //                                 return DropdownMenuItem<
                          //     //                                     String>(
                          //     //                                   value: value,
                          //     //                                   child: Padding(
                          //     //                                     padding: const EdgeInsets
                          //     //                                         .symmetric(
                          //     //                                         horizontal:
                          //     //                                             5),
                          //     //                                     child: Text(
                          //     //                                       value
                          //     //                                           .toString(),
                          //     //                                       maxLines: 1,
                          //     //                                       overflow:
                          //     //                                           TextOverflow
                          //     //                                               .ellipsis,
                          //     //                                       softWrap:
                          //     //                                           true,
                          //     //                                       style:                                                                       .nunitoSemiBold
                          //     //                                           .copyWith(
                          //     //                                         fontSize:
                          //     //                                             12,
                          //     //                                         color: ColorManager
                          //     //                                             .bgSideMenu,
                          //     //                                       ),
                          //     //                                     ),
                          //     //                                   ),
                          //     //                                 );
                          //     //                               },
                          //     //                             ).toList(),
                          //     //                           ),
                          //     //                         )
                          //     //                       ],
                          //     //                     ),
                          //     //                   );
                          //     //                 },
                          //     //               ),
                          //     //             );
                          //     //     },
                          //     //   ),
                          //     // ),
                          //     )
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 3,
                  //   child: GetBuilder<DistrbutionController>(
                  //     builder: (distrbutionController) {
                  //       return RendarSeatsExam(
                  //         seatsNumbers: distrbutionController.seatsNumbers,
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // GetBuilder<DistrbutionController>(
            //   builder: (distrbutionController) => Row(
            //     children: [
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {
            //             GenerateSeatNumber.generateSeating(
            //               blockSeats: distrbutionController.blockSeats,
            //               fileName: distrbutionController.currentRoom!.name,
            //               numbers: distrbutionController.numbers.value,
            //               classSeats: distrbutionController.classSeats,
            //               count: 0,
            //               classdesk: distrbutionController
            //                   .selectedExamRoom!.classdesk!,
            //               allSeatsIds: distrbutionController.allSeatsIds,
            //               controller: distrbutionController,
            //               seatsNumbers: distrbutionController.seatsNumbers,
            //             );
            //           },
            //           child: Container(
            //             padding: const EdgeInsets.all(20),
            //             decoration: BoxDecoration(
            //               borderRadius: const BorderRadius.only(
            //                 bottomLeft: Radius.circular(11),
            //               ),
            //               color: ColorManager.glodenColor,
            //             ),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Text(
            //                   "Print",
            //                   style: nunitoRegular.copyWith(
            //                       color: ColorManager.white, fontSize: 20),
            //                 ),
            //                 const SizedBox(
            //                   width: 20,
            //                 ),
            //                 Icon(Icons.print, color: ColorManager.white)
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 20,
            //       ),
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {
            //             // Get.offNamed(Routes.distribution);
            //           },
            //           child: Container(
            //             padding: const EdgeInsets.all(20),
            //             decoration: BoxDecoration(
            //               borderRadius: const BorderRadius.only(
            //                 bottomRight: Radius.circular(11),
            //               ),
            //               color: ColorManager.bgSideMenu,
            //             ),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Text(
            //                   "Finish",
            //                   style: nunitoRegular.copyWith(
            //                     color: ColorManager.white,
            //                     fontSize: 20,
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   width: 20,
            //                 ),
            //                 Icon(Icons.done, color: ColorManager.white)
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
