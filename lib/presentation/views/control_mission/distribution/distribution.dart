import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/control_mission/distribution_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/header_widget.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../widgets/add_exam_room_widget.dart';

class DistributionScreen extends GetView<DistributionController> {
  final String name;
  final String id;

  const DistributionScreen({super.key, required this.name, required this.id});

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
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.goNamed(
                          AppRoutesNamesAndPaths.controlBatchScreenName);
                    },
                    icon: const Icon(Icons.arrow_back)),
                HeaderWidget(
                  text: "Distribution: $name",
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      MyDialogs.showDialog(context, AddExamRoomWidget());
                       controller.getStageAndClassRoom();
                      // controller.getClassesRoomsBySchoolId();
                      // controller.getStage();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.bgSideMenu,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Create new exam room",
                          style: nunitoLight.copyWith(color: Colors.white),
                        )))
              ],
            ),
            GetBuilder<DistributionController>(
                builder: (_) => controller.isLodingGetExamRooms
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : controller.listExamRoom.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                "No Rooms",
                                style: nunitoRegular.copyWith(
                                  color: ColorManager.bgSideMenu,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              itemCount: controller.listExamRoom.length,
                              itemBuilder: (context, index) {
                                final room = controller.listExamRoom[index];
                                // var classname = controller
                                //     .classController.classesRooms
                                //     .firstWhere((element) =>
                                //         room.schoolClassId == element.id)
                                //     .className;
                                return Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 20,
                                          offset: const Offset(2,
                                              15), // changes position of shadow
                                        ),
                                      ],
                                      color: ColorManager.ligthBlue,
                                      borderRadius: BorderRadius.circular(11)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Exam Room: ${room.name}",
                                              style: nunitoBold.copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      ColorManager.bgSideMenu),
                                            ),
                                            // Text(
                                            //   "Division : ${room.}",
                                            //   style:
                                            //       nunitoBold
                                            //       .copyWith(
                                            //           fontSize: 20,
                                            //           color: ColorManager
                                            //               .bgSideMenu),
                                            // ),
                                            // Text(
                                            //   "Class Name : $classname",
                                            //   style:
                                            //       nunitoBold
                                            //       .copyWith(
                                            //           fontSize: 20,
                                            //           color: ColorManager
                                            //               .bgSideMenu),
                                            // ),
                                            Text(
                                              "Students Max Capacity : ${room.capacity}",
                                              style: nunitoBold.copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      ColorManager.bgSideMenu),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                MyAwesomeDialogue(
                                                  title:
                                                      'You Are About To Delete This Exam Room',
                                                  desc: 'Are You Sure?',
                                                  dialogType:
                                                      DialogType.warning,
                                                  btnOkOnPressed: () async {
                                                    controller
                                                        .deleteExamRoom(
                                                            room.id!)
                                                        .then((value) {
                                                      value
                                                          ? MyFlashBar.showSuccess(
                                                                  'Exam Room Deleted Successfully',
                                                                  "Success")
                                                              .show(context)
                                                          : null;
                                                    });

                                                    // controller
                                                    //     .deleteClassRoom(
                                                    //   id: controller
                                                    //       .classesRooms[
                                                    //           index]
                                                    //       .iD!,
                                                    // )
                                                    //     .then(
                                                    //   (value) {
                                                    //     value
                                                    //         ? MyFlashBar.showSuccess("Class deleted successfully",
                                                    //                 "Success")
                                                    //             .show(context)
                                                    //         : null;
                                                    //   },
                                                    // );
                                                  },
                                                  btnCancelOnPressed: () {
                                                    Get.back();
                                                  },
                                                ).showDialogue(
                                                  context,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      10,
                                                    ),
                                                    child: Text(
                                                      "Delete Exam Room",
                                                      style:
                                                          nunitoBold.copyWith(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: InkWell(
                                          //     onTap: () {
                                          //       showGeneralDialog(
                                          //           context: context,
                                          //           pageBuilder: (ctx, a1, a2) {
                                          //             return Container();
                                          //           },
                                          //           transitionBuilder:
                                          //               (ctx, a1, a2, child) {
                                          //             var curve = Curves
                                          //                 .easeInOut
                                          //                 .transform(a1.value);

                                          //             return Transform.scale(
                                          //               scale: curve,
                                          //               child: StatefulBuilder(
                                          //                 builder: (context,
                                          //                         setState) =>
                                          //                     AlertDialog(
                                          //                   shape: const RoundedRectangleBorder(
                                          //                       borderRadius: BorderRadius
                                          //                           .all(Radius
                                          //                               .circular(
                                          //                                   20.0))),
                                          //                   backgroundColor:
                                          //                       Colors.white,
                                          //                   content: Form(
                                          //                     child: Column(
                                          //                       mainAxisSize:
                                          //                           MainAxisSize
                                          //                               .min,
                                          //                       children: [
                                          //                         Align(
                                          //                           alignment:
                                          //                               AlignmentDirectional
                                          //                                   .topEnd,
                                          //                           child:
                                          //                               IconButton(
                                          //                             alignment:
                                          //                                 AlignmentDirectional
                                          //                                     .topEnd,
                                          //                             color: Colors
                                          //                                 .black,
                                          //                             icon: const Icon(
                                          //                                 Icons
                                          //                                     .close),
                                          //                             onPressed:
                                          //                                 () {
                                          //                               Get.back();
                                          //                             },
                                          //                           ),
                                          //                         ),
                                          //                         Text(
                                          //                           "Delete Exam Room",
                                          //                           style: nunitoBold.copyWith(
                                          //                               color: Colors
                                          //                                   .black,
                                          //                               fontSize:
                                          //                                   20),
                                          //                         ),
                                          //                         Text(
                                          //                           "Are You Sure ?",
                                          //                           style: nunitoRegular.copyWith(
                                          //                               color: Colors
                                          //                                   .black,
                                          //                               fontSize:
                                          //                                   18),
                                          //                         ),
                                          //                         const SizedBox(
                                          //                           height: 20,
                                          //                         ),
                                          //                         Row(
                                          //                           children: [
                                          //                             Expanded(
                                          //                               child:
                                          //                                   InkWell(
                                          //                                 onTap:
                                          //                                     () {
                                          //                                   Get.back();
                                          //                                 },
                                          //                                 child:
                                          //                                     Container(
                                          //                                   height:
                                          //                                       45,
                                          //                                   decoration:
                                          //                                       BoxDecoration(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(11)), color: ColorManager.bgSideMenu),
                                          //                                   child:
                                          //                                       Center(
                                          //                                     child: Text(
                                          //                                       "No",
                                          //                                       style: nunitoRegular.copyWith(color: Colors.white, fontSize: 18),
                                          //                                     ),
                                          //                                   ),
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                             const SizedBox(
                                          //                               width:
                                          //                                   10,
                                          //                             ),
                                          //                             Expanded(
                                          //                               child:
                                          //                                   InkWell(
                                          //                                 onTap:
                                          //                                     () {
                                          //                                   //controller.deleteExamRoom(id: room.id!);
                                          //                                   // controller.getDetialsControlMissionById(missionId: controller.missionDetials!.id!);

                                          //                                   //  controller.update();

                                          //                                   // Get.back();
                                          //                                 },
                                          //                                 child:
                                          //                                     Container(
                                          //                                   height:
                                          //                                       45,
                                          //                                   decoration:
                                          //                                       BoxDecoration(borderRadius: const BorderRadius.only(bottomRight: Radius.circular(11)), color: ColorManager.glodenColor),
                                          //                                   child:
                                          //                                       Center(
                                          //                                     child: Text(
                                          //                                       "Yes",
                                          //                                       style: nunitoRegular.copyWith(color: Colors.white, fontSize: 18),
                                          //                                     ),
                                          //                                   ),
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                           ],
                                          //                         )
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             );
                                          //           });
                                          //     },
                                          //     child: Container(
                                          //       height: 45,
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               const BorderRadius.only(
                                          //                   bottomLeft:
                                          //                       Radius.circular(
                                          //                           11)),
                                          //           color: ColorManager.red),
                                          //       child: Center(
                                          //         child: Text(
                                          //           "Delete",
                                          //           style:
                                          //               nunitoRegular.copyWith(
                                          //                   color: Colors.white,
                                          //                   fontSize: 18),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                context.goNamed(
                                                  AppRoutesNamesAndPaths
                                                      .distributeStudentsScreenName,
                                                  extra: room.toExtra(),
                                                );
                                                // DistrbutionController
                                                //     distrbutionController =
                                                //     Get.find();

                                                // distrbutionController.setRoom(
                                                //     classRoom: StudentServices
                                                //         .getClassResponse(
                                                //             id: room
                                                //                 .schoolClassId)!,
                                                //     room: room);
                                                // distrbutionController
                                                //     .goToRendarPage();

// get rooom stud from server
                                              },
                                              child: Container(
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    11)),
                                                    color: ColorManager
                                                        .glodenColor),
                                                child: Center(
                                                  child: Text(
                                                    "Distribution",
                                                    style:
                                                        nunitoRegular.copyWith(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ))
                //  Expanded(
                //     child: Center(
                //     child: Text(
                //       "No exam rooms",
                //       style: nunitoBold
                //           .copyWith(color: ColorManager.bgSideMenu),
                //     ),
                //   )),
                )
          ],
        ),
      ),
    );
  }
}
