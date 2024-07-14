

import 'package:badges/badges.dart' as bdg;
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CoverWidget extends StatelessWidget {
  CoverWidget({
    Key? key,
  }) : super(key: key);

  // CreateCoversSheetsController controller = Get.find();
  // AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(2, 15), // changes position of shadow
          ),
        ], color: ColorManager.ligthBlue, borderRadius: BorderRadius.circular(11)),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  bdg.Badge(
                    // padding: const EdgeInsets.all(10),
                    // badgeColor: ColorManager.red,
                    badgeContent: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: IconButton(
                        onPressed: () {
                        //   showGeneralDialog(
                        //       context: context,
                        //       pageBuilder: (ctx, a1, a2) {
                        //         return Container();
                        //       },
                        //       transitionBuilder: (ctx, a1, a2, child) {
                        //         var curve =
                        //             Curves.easeInOut.transform(a1.value);

                        //         return DeleteMissionDialog(curve: curve);
                        //       });
                        // },
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mission name :",
                         
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Exam Date :",
                              // style: AppTextStyle.nunitoRegular.copyWith(
                              //     color: ColorManager.bgSideMenu, fontSize: 16),
                            ),
                            Text(
                              "Grade : ",
                              // style: AppTextStyle.nunitoRegular.copyWith(
                              //     color: ColorManager.bgSideMenu, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Subject name :",
                              // style: AppTextStyle.nunitoRegular.copyWith(
                              //     color: ColorManager.bgSideMenu, fontSize: 16),
                            ),
                            Text(
                              "Exam Duration :",
                              // style: AppTextStyle.nunitoRegular.copyWith(
                              //     color: ColorManager.bgSideMenu, fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (true)
                    Positioned(
                        top: 0,
                        right: 60,
                        child: Container(
                          height: 60,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.bgSideMenu,
                          ),
                          child: IconButton(
                            onPressed: () {
                             // controller.isNight = objet.period;

                              // Get.dialog(
                              //     GetBuilder<CreateCoversSheetsController>(
                              //         builder: (controller) {
                              //   return AlertDialog(
                              //     content: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         const Center(
                              //             child: Text(
                              //           "Upload pdf Exams",
                              //           style: TextStyle(
                              //               fontSize: 36,
                              //               color: Colors.black,
                              //               fontWeight: FontWeight.w900),
                              //         )),
                              //         const SizedBox(
                              //           height: 20,
                              //         ),

                              //         /// exam version 1 pdf
                              //         controller.pdfLoading == true
                              //             ? Column(
                              //                 children: const [
                              //                   LinearProgressIndicator(),
                              //                   Padding(
                              //                     padding: EdgeInsets.all(8.0),
                              //                     child: Text(
                              //                         'Uplaoding the file'),
                              //                   ),
                              //                 ],
                              //               )
                              //             : Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   ElevatedButton(
                              //                       onPressed: () async {
                              //                         FilePickerResult? pdf =
                              //                             await FilePicker
                              //                                 .platform
                              //                                 .pickFiles(
                              //                                     allowMultiple:
                              //                                         false,
                              //                                     dialogTitle:
                              //                                         "Upload Exam As Pdf file",
                              //                                     type: FileType.custom,
                              //                                     allowedExtensions: [
                              //                               'pdf'
                              //                             ]);
                              //                         if (pdf == null ||
                              //                             pdf.files.single
                              //                                     .bytes ==
                              //                                 null) {
                              //                           return;
                              //                         }
                              //                         try {
                              //                           var responseString =
                              //                               await controller
                              //                                   .fbUploadPDf(pdf
                              //                                       .files
                              //                                       .single);
                              //                           controller.pdfname = pdf
                              //                               .files.single.name;
                              //                           controller.pdfUrl =
                              //                               responseString;
                              //                         } catch (e) {
                              //                           print(e);
                              //                         }

                              //                         controller.pdfLoading =
                              //                             false;
                              //                         controller.update();
                              //                       },
                              //                       child: const Text(
                              //                           "upload Exam Version A")),
                              //                   Column(
                              //                     children: [
                              //                       if (controller.pdfname !=
                              //                           null)
                              //                         Padding(
                              //                           padding:
                              //                               const EdgeInsets
                              //                                       .symmetric(
                              //                                   horizontal: 16),
                              //                           child: Text(
                              //                               'New name : ${controller.pdfname}'),
                              //                         ),
                              //                       if (objet.pdf != null)
                              //                         Padding(
                              //                           padding:
                              //                               const EdgeInsets
                              //                                       .symmetric(
                              //                                   horizontal: 16),
                              //                           child: Text(
                              //                               'Old name : ${objet.pdf}',
                              //                               overflow:
                              //                                   TextOverflow
                              //                                       .visible,
                              //                               maxLines: 1,
                              //                               softWrap: true),
                              //                         ),
                              //                     ],
                              //                   )
                              //                 ],
                              //               ),

                              //         /// exam version 2 pdf
                              //         if (objet.pdfV2 != null)
                              //           controller.pdfLoading == true
                              //               ? Column(
                              //                   children: const [
                              //                     LinearProgressIndicator(),
                              //                     Padding(
                              //                       padding:
                              //                           EdgeInsets.all(8.0),
                              //                       child: Text(
                              //                           'Uplaoding the file'),
                              //                     ),
                              //                   ],
                              //                 )
                              //               : Column(
                              //                   children: [
                              //                     const SizedBox(
                              //                       height: 20,
                              //                     ),
                              //                     Row(
                              //                       children: [
                              //                         ElevatedButton(
                              //                             onPressed: () async {
                              //                               FilePickerResult?
                              //                                   pdf =
                              //                                   await FilePicker
                              //                                       .platform
                              //                                       .pickFiles(
                              //                                           type: FileType
                              //                                               .custom,
                              //                                           allowedExtensions: [
                              //                                     'pdf'
                              //                                   ]);
                              //                               if (pdf == null ||
                              //                                   pdf.files.single
                              //                                           .bytes ==
                              //                                       null) {
                              //                                 return;
                              //                               }
                              //                               try {
                              //                                 var responseString =
                              //                                     await controller
                              //                                         .fbUploadPDf(pdf
                              //                                             .files
                              //                                             .single);
                              //                                 controller
                              //                                         .pdfname_v2 =
                              //                                     pdf
                              //                                         .files
                              //                                         .single
                              //                                         .name;
                              //                                 controller
                              //                                         .pdfUrl_v2 =
                              //                                     responseString;
                              //                               } catch (e) {
                              //                                 print(e);
                              //                               }
                              //                               controller
                              //                                       .pdfLoading =
                              //                                   false;
                              //                               print(controller
                              //                                   .pdfname_v2);
                              //                               controller.update();
                              //                             },
                              //                             child: const Text(
                              //                                 "upload Exam Version B")),
                              //                         if (objet.pdfV2 !=
                              //                                 'true' ||
                              //                             controller
                              //                                     .pdfname_v2 !=
                              //                                 null)
                              //                           Column(
                              //                             children: [
                              //                               if (controller
                              //                                       .pdfname_v2 !=
                              //                                   null)
                              //                                 Padding(
                              //                                   padding: const EdgeInsets
                              //                                           .symmetric(
                              //                                       horizontal:
                              //                                           16),
                              //                                   child: Text(
                              //                                       'New name : ${controller.pdfname_v2}'),
                              //                                 ),
                              //                               if (objet.pdfV2 !=
                              //                                   null)
                              //                                 Padding(
                              //                                   padding: const EdgeInsets
                              //                                           .symmetric(
                              //                                       horizontal:
                              //                                           16),
                              //                                   child: Text(
                              //                                       'Old name : ${objet.pdfV2}',
                              //                                       overflow:
                              //                                           TextOverflow
                              //                                               .visible,
                              //                                       maxLines: 1,
                              //                                       softWrap:
                              //                                           true),
                              //                                 ),
                              //                             ],
                              //                           )
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),

                              //         Form(
                              //             child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             // start Date
                              //             Padding(
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: 20),
                              //               child: Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   const Text(
                              //                       "Pick Start Exam Date"),
                              //                   DateTimePicker(
                              //                     type: DateTimePickerType
                              //                         .dateTime,
                              //                     dateMask:
                              //                         'd MMM, yyyy - hh:mm:ss',
                              //                     initialValue: controller
                              //                                 .start_date !=
                              //                             null
                              //                         ? controller.start_date!
                              //                             .toString()
                              //                         : objet.starttime != null
                              //                             ? objet.starttime
                              //                                 .toString()
                              //                             : DateTime.now()
                              //                                 .toString(),
                              //                     firstDate:
                              //                         objet.starttime != null
                              //                             ? DateTime.tryParse(
                              //                                 objet.starttime!)
                              //                             : DateTime.now(),
                              //                     lastDate: DateTime(2100),
                              //                     icon: const Icon(Icons.event),
                              //                     dateLabelText: 'Date',
                              //                     timeLabelText: "Hour",
                              //                     // selectableDayPredicate: (date) {
                              //                     //   // Disable weekend days to select from the calendar
                              //                     // },
                              //                     onChanged: (val) {
                              //                       controller.start_date =
                              //                           DateTime.parse(val);
                              //                       var enddate = DateTime
                              //                               .parse(val)
                              //                           .add(Duration(
                              //                               minutes: int.parse(objet
                              //                                   .examDuration!
                              //                                   .split(
                              //                                       ' ')[0])));
                              //                       controller.end_date =
                              //                           enddate;
                              //                       controller.duration =
                              //                           int.parse(objet
                              //                               .examDuration!
                              //                               .split(' ')[0]);
                              //                       controller.update();
                              //                     },
                              //                     validator: (val) {
                              //                       print(val);
                              //                       return null;
                              //                     },
                              //                     onSaved: (val) => print(val),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),

                              //             /// end Date
                              //             if (controller.start_date != null)
                              //               Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   const Text(
                              //                       "Pick End Exam Date"),
                              //                   const SizedBox(
                              //                     height: 8,
                              //                   ),
                              //                   // Text((controller.end_date ??
                              //                   //         objet.endtime)
                              //                   /*  (controller.start_date !=
                              //                             null
                              //                         ? controller.start_date
                              //                             .toString()
                              //                         : controller.end_date !=
                              //                                 null
                              //                             ? controller.end_date
                              //                                 .toString()
                              //                             : objet.endtime !=
                              //                                     null
                              //                                 ? objet.endtime
                              //                                 : DateTime(2100)
                              //                                     .toString())
                              //                                     */
                              //                   // .toString())
                              //                   DateTimePicker(
                              //                     type: DateTimePickerType
                              //                         .dateTime,
                              //                     dateMask:
                              //                         'd MMM, yyyy - hh:mm:ss',
                              //                     initialValue: controller
                              //                                 .start_date !=
                              //                             null
                              //                         ? controller.start_date
                              //                             .toString()
                              //                         : controller.end_date !=
                              //                                 null
                              //                             ? controller.end_date
                              //                                 .toString()
                              //                             : objet.endtime !=
                              //                                     null
                              //                                 ? objet.endtime
                              //                                 : DateTime(2100)
                              //                                     .toString(),
                              //                     firstDate:
                              //                         controller.start_date,
                              //                     lastDate: DateTime(2100),
                              //                     icon: const Icon(Icons.event),
                              //                     dateLabelText: 'Date',
                              //                     timeLabelText: "Hour",
                              //                     onChanged: (val) {
                              //                       controller.end_date =
                              //                           DateTime.parse(val);

                              //                       // if (controller.examDurations
                              //                       //     .contains(controller
                              //                       //         .end_date!
                              //                       //         .difference(controller
                              //                       //             .start_date!)
                              //                       //         .inMinutes)) {
                              //                       // controller.duration =
                              //                       //     controller
                              //                       //         .end_date!
                              //                       //         .difference(
                              //                       //             controller
                              //                       //                 .start_date!)
                              //                       //         .inMinutes;
                              //                       // } else {
                              //                       //   Get.snackbar(
                              //                       //       "Auto Select DUration",
                              //                       //       "Your have select Wrong end time");
                              //                       // }
                              //                       // controller.update();
                              //                     },
                              //                     validator: (val) {
                              //                       print(val);
                              //                       return null;
                              //                     },
                              //                     onSaved: (val) => print(val),
                              //                   ),
                              //                 ],
                              //               ),

                              //             // Duration
                              //             Padding(
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: 20),
                              //               child: Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.stretch,
                              //                 children: [
                              //                   const Text("Duration"),
                              //                   // Text((controller.duration != null
                              //                   //         ? controller.duration
                              //                   //         : objet.examDuration !=
                              //                   //                 null
                              //                   //             ? int.parse(objet
                              //                   //                 .examDuration!
                              //                   //                 .split(' ')[0])
                              //                   //             : null)
                              //                   //     .toString())
                              //                   GetBuilder<
                              //                           CreateCoversSheetsController>(
                              //                       builder: (controller) {
                              //                     return DropdownButton<int>(
                              //                       value: controller
                              //                                   .duration !=
                              //                               null
                              //                           ? controller.duration
                              //                           : objet.duration != null
                              //                               ? objet.duration
                              //                               : objet.examDuration !=
                              //                                       null
                              //                                   ? int.parse(objet
                              //                                       .examDuration!
                              //                                       .split(
                              //                                           ' ')[0])
                              //                                   : null,
                              //                       items: controller
                              //                           .examDurations
                              //                           .map((item) =>
                              //                               DropdownMenuItem<
                              //                                   int>(
                              //                                 value: item,
                              //                                 child: Text(
                              //                                     '$item Mins'),
                              //                               ))
                              //                           .toList(),
                              //                       onChanged: (value) {
                              //                         if (value != null) {
                              //                           controller.duration =
                              //                               value;
                              //                           controller.update();
                              //                         } else {
                              //                           Get.snackbar("Duration",
                              //                               "You Must select Duration");
                              //                         }
                              //                       },
                              //                     );
                              //                   }),
                              //                 ],
                              //               ),
                              //             ),

                              //             const SizedBox(
                              //               height: 50,
                              //             ),

                              //             Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text("Exams Period :",
                              //                     style: AppTextStyle
                              //                         .nunitoRegular
                              //                         .copyWith(
                              //                       color: ColorManager.black,
                              //                     )),
                              //                 GetBuilder<
                              //                         CreateCoversSheetsController>(
                              //                     builder: (controller) {
                              //                   return Row(
                              //                     children: [
                              //                       Text(
                              //                         'Session One Exams',
                              //                         style: TextStyle(
                              //                             color: !controller
                              //                                     .isNight
                              //                                 ? Colors.black
                              //                                 : Colors.grey),
                              //                       ),
                              //                       Switch.adaptive(
                              //                           value:
                              //                               controller.isNight,
                              //                           onChanged: (newValue) {
                              //                             controller.isNight =
                              //                                 newValue;
                              //                             controller.update();
                              //                           }),
                              //                       Text(
                              //                         'Session Two Exams',
                              //                         style: TextStyle(
                              //                             color: controller
                              //                                     .isNight
                              //                                 ? Colors.black
                              //                                 : Colors.grey),
                              //                       ),
                              //                     ],
                              //                   );
                              //                 }),
                              //               ],
                              //             ),

                              //             const SizedBox(
                              //               height: 50,
                              //             ),

                              //             Center(
                              //               child: Obx(() {
                              //                 return controller
                              //                         .isLoadingSubmited.value
                              //                     ? Center(
                              //                         child:
                              //                             CircularProgressIndicator(
                              //                           color: ColorManager
                              //                               .glodenColor,
                              //                         ),
                              //                       )
                              //                     : ElevatedButton(
                              //                         onPressed: () async {
                              //                           print(objet.id);
                              //                           controller.pdfUrl ??=
                              //                               objet.pdf;
                              //                           controller.pdfUrl_v2 ??=
                              //                               objet.pdfV2;
                              //                           if (controller
                              //                                       .end_date ==
                              //                                   null &&
                              //                               objet.endtime !=
                              //                                   null) {
                              //                             controller.end_date =
                              //                                 DateTime.parse(
                              //                                     objet
                              //                                         .endtime!);
                              //                           }
                              //                           if (controller
                              //                                       .duration ==
                              //                                   null &&
                              //                               objet.examDuration !=
                              //                                   null) {
                              //                             controller.duration =
                              //                                 int.parse(objet
                              //                                     .examDuration!
                              //                                     .split(
                              //                                         ' ')[0]);
                              //                           }
                              //                           if (controller
                              //                                       .start_date ==
                              //                                   null &&
                              //                               objet.starttime !=
                              //                                   null) {
                              //                             controller
                              //                                     .start_date =
                              //                                 DateTime.parse(objet
                              //                                     .starttime!);
                              //                           }
                              //                           controller
                              //                               .submitPdfExam(
                              //                                   objet.id);
                              //                         },
                              //                         child:
                              //                             const Text("Submit"));
                              //               }),
                              //             )
                              //           ],
                              //         ))
                              //       ],
                              //     ),
                              //   );
                              // }));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  if (true)
                    Positioned(
                        top: 0,
                        right: 60,
                        child: Container(
                          height: 60,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.bgSideMenu,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Get.dialog(
                              //     GetBuilder<CreateCoversSheetsController>(
                              //         builder: (controller) {
                              //   return AlertDialog(
                              //     content: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         const Center(
                              //             child: Text(
                              //           "Edit Exam",
                              //           style: TextStyle(
                              //               fontSize: 36,
                              //               color: Colors.black,
                              //               fontWeight: FontWeight.w900),
                              //         )),
                              //         const SizedBox(
                              //           height: 20,
                              //         ),
                              //         Form(
                              //             child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             GetBuilder<
                              //                     CreateCoversSheetsController>(
                              //                 builder: (controller) {
                              //               return DropdownButtonFormField<int>(
                              //                   decoration: InputDecoration(
                              //                       focusedBorder: OutlineInputBorder(
                              //                           borderRadius:
                              //                               BorderRadius.circular(
                              //                                   8)),
                              //                       enabledBorder: OutlineInputBorder(
                              //                           borderRadius:
                              //                               BorderRadius.circular(
                              //                                   8))),
                              //                   hint: Text("Exam Duration",
                              //                       style: AppTextStyle
                              //                           .nunitoRegular
                              //                           .copyWith(
                              //                         color: ColorManager.black,
                              //                       )),
                              //                   value: controller
                              //                           .examTimeController
                              //                           .text
                              //                           .isEmpty
                              //                       ? objet.examDuration != null
                              //                           ? int.parse(objet
                              //                               .examDuration!
                              //                               .split(' ')[0])
                              //                           : null
                              //                       : int.parse(controller
                              //                           .examTimeController.text
                              //                           .split(' ')[0]),
                              //                   items: controller.examDurations
                              //                       .map((item) => DropdownMenuItem<int>(
                              //                             value: item,
                              //                             child: Text(
                              //                                 '$item Mins'),
                              //                           ))
                              //                       .toList(),
                              //                   onChanged: (newValue) {
                              //                     controller.examTimeController
                              //                         .text = '$newValue Mins';
                              //                     controller.update();
                              //                   });
                              //             }),
                              //             const SizedBox(
                              //               height: 50,
                              //             ),
                              //             Center(
                              //               child: Obx(() {
                              //                 return controller
                              //                         .isLoadingSubmited.value
                              //                     ? Center(
                              //                         child:
                              //                             CircularProgressIndicator(
                              //                           color: ColorManager
                              //                               .glodenColor,
                              //                         ),
                              //                       )
                              //                     : ElevatedButton(
                              //                         onPressed: () async {
                              //                           if (controller
                              //                               .examTimeController
                              //                               .text
                              //                               .isEmpty) {
                              //                             MyReusbleWidget
                              //                                 .mySnackBarError(
                              //                                     "Edit exam",
                              //                                     'You not change the duration Yet');
                              //                           } else {
                              //                             controller
                              //                                 .editExamDuration(
                              //                                     objet.id);
                              //                           }
                              //                         },
                              //                         child:
                              //                             const Text("Edit"));
                              //               }),
                              //             )
                              //           ],
                              //         ))
                              //       ],
                              //     ),
                              //   );
                              // }));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  // if (authController.type == 2)
                  //   objet.pdf != null || controller.pdfUrl != null
                  //       ? Positioned(
                  //           top: 0,
                  //           right: 120,
                  //           child: Container(
                  //             height: 60,
                  //             width: 55,
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               color: ColorManager.bgSideMenu,
                  //             ),
                  //             child: IconButton(
                  //               color: Colors.white,
                  //               icon: const Icon(Icons.picture_as_pdf),
                  //               onPressed: () async {
                  //                 //// get fileRequest

                  //                 var result = await controller
                  //                     .getexamPreview(objet.id!);
                  //                 if (result == null) {
                  //                   print('error from server');
                  //                 } else {
                  //                   objet.pdfV2 = result['B'];
                  //                   objet.pdf = result['A'];
                  //                 }

                  //                 if (objet.pdfV2 != null) {
                  //                   Get.defaultDialog(
                  //                       title: "Exams Preview",
                  //                       content: Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //                           ElevatedButton(
                  //                               onPressed: () {
                  //                                 js.context.callMethod(
                  //                                     'open', [objet.pdf]);
                  //                               },
                  //                               child: const Text("Version A")),
                  //                           ElevatedButton(
                  //                               onPressed: () {
                  //                                 js.context.callMethod(
                  //                                     'open', [objet.pdfV2]);
                  //                               },
                  //                               child: const Text("Version B")),
                  //                         ],
                  //                       ));
                  //                 } else {
                  //                   js.context.callMethod('open', [objet.pdf]);
                  //                 }
                  //               },
                  //             ),
                  //           ))
                  //       : Container()
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Get.defaultDialog(
                      //     content: Column(
                      //   children: [
                      //     const Text("What do you want to print ?"),
                      //     const SizedBox(
                      //       height: 50,
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         ElevatedButton(
                      //             onPressed: () {
                      //               log("Taped American");
                      //               Get.defaultDialog(
                      //                   title: "WA Covers",
                      //                   content: Column(
                      //                     children: [
                      //                       ElevatedButton(
                      //                           onPressed: () {
                      //                             CreateCoversSheetsController
                      //                                 controller = Get.find();
                      //                             controller
                      //                                 .printAnswerSheetsAM(
                      //                                     objet.id!, true);
                      //                           },
                      //                           child: const Text("old Cover")),
                      //                       const SizedBox(
                      //                         height: 20,
                      //                       ),
                      //                       ElevatedButton(
                      //                           onPressed: () {
                      //                             CreateCoversSheetsController
                      //                                 controller = Get.find();
                      //                             controller
                      //                                 .printAnswerSheetsArabicWritingAssessment(
                      //                                     objet.id!);
                      //                           },
                      //                           child: const Text(
                      //                               "Arabic Writing Assessment")),
                      //                       const SizedBox(
                      //                         height: 20,
                      //                       ),
                      //                       ElevatedButton(
                      //                           onPressed: () {
                      //                             CreateCoversSheetsController
                      //                                 controller = Get.find();
                      //                             controller
                      //                                 .printAnswerSheetsEnglishWritingAssessment(
                      //                                     objet.id!);
                      //                           },
                      //                           child: const Text(
                      //                               "English Writing Assessment")),
                      //                       const SizedBox(
                      //                         height: 20,
                      //                       ),
                      //                       ElevatedButton(
                      //                           onPressed: () {
                      //                             CreateCoversSheetsController
                      //                                 controller = Get.find();
                      //                             controller
                      //                                 .printAnswerSheetsEnglishSocialStudiesWritingAssessment(
                      //                                     objet.id!);
                      //                           },
                      //                           child: const Text(
                      //                               "English Social Studies Writing Assessment")),
                      //                     ],
                      //                   ));
                      //             },
                      //             child: const Text("WA Cover")),
                      //         ElevatedButton(
                      //             onPressed: () {
                      //               log("Taped American");
                      //               CreateCoversSheetsController controller =
                      //                   Get.find();
                      //               controller.printAnswerSheetsAM(
                      //                   objet.id!, false);
                      //             },
                      //             child: const Text("Exam Cover")),
                      //       ],
                      //     ),
                      //   ],
                      // ));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: ColorManager.bgSideMenu,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "American Cover Sheet",
                            // style: AppTextStyle.nunitoRegular
                            //     .copyWith(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.print,
                            color: ColorManager.white,
                          )
                        ],
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
                        // controller.printAnswerSheetsIB(
                        //                 objet.id!, false);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius:  BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.lightBlue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "IB Cover Sheet",
                            // style: AppTextStyle.nunitoRegular
                            //     .copyWith(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.print,
                            color: ColorManager.white,
                          )
                        ],
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
                      Get.defaultDialog(
                          content: Column(
                        children: [
                          const Text("What do you want to print?"),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    // log("Taped British");
                                    // CreateCoversSheetsController controller =
                                    //     Get.find();
                                    // controller.printAnswerSheetsBR(
                                    //     objet.id!, true);
                                  },
                                  child: const Text("WA Cover")),
                              ElevatedButton(
                                  onPressed: () {
                                    // log("Taped British");
                                    // CreateCoversSheetsController controller =
                                    //     Get.find();
                                    // controller.printAnswerSheetsBR(
                                    //     objet.id!, false);
                                  },
                                  child: const Text("Exam Cover")),
                            ],
                          ),
                        ],
                      ));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: ColorManager.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "British Cover Sheet",
                            // style: AppTextStyle.nunitoRegular
                            //     .copyWith(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.print,
                            color: ColorManager.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
