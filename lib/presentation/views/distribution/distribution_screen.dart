import 'package:flutter/material.dart';

import '../../resource_manager/index.dart';

class DistributionScreen extends StatelessWidget {
  const DistributionScreen({super.key});

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
                    // Get.toNamed(Routes.controlMission);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                // GetBuilder<CompleteMissionsController>(
                //   builder: (completeMissionsController) {
                //     return completeMissionsController.missionDetials == null
                //         ? const SizedBox.shrink()
                //         : HeaderReviewMessionWidget(
                //             text:
                //                 "Distribution : ${completeMissionsController.missionDetials!.name!}",
                //           );
                //   },
                // ),
                const Spacer(),
                InkWell(
                  // onTap: () {
                  //   MyDialogs.showAddDialog(
                  //     context,
                  //     AddExamRookmDialog(),
                  //   );
                  // },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.bgSideMenu,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Create new exam room",
                      style: nunitoBold.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
//             GetBuilder<CompleteMissionsController>(
//               builder: (completeMissionsController) =>
//                   completeMissionsController.isLoading
//                       ? const Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : completeMissionsController.missionDetials == null
//                           ? const Center(
//                               child: Text("No Rooms"),
//                             )
//                           : completeMissionsController
//                                   .missionDetials!.examrooms!.isNotEmpty
//                               ? Expanded(
//                                   child: Container(
//                                   margin: const EdgeInsets.all(10),
//                                   padding: const EdgeInsets.all(10),
//                                   child: ListView.builder(
//                                     itemCount: completeMissionsController
//                                         .missionDetials!.examrooms!.length,
//                                     itemBuilder: (context, index) {
//                                       final room = completeMissionsController
//                                           .missionDetials!.examrooms![index];
//                                       var classname = controller
//                                           .classController.classesRooms
//                                           .firstWhere((element) =>
//                                               room.schoolClassId == element.id)
//                                           .className;
//                                       return Container(
//                                         decoration: BoxDecoration(
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.5),
//                                               spreadRadius: 5,
//                                               blurRadius: 20,
//                                               offset: const Offset(
//                                                 2,
//                                                 15,
//                                               ), // changes position of shadow
//                                             ),
//                                           ],
//                                           color: ColorManager.ligthBlue,
//                                           borderRadius:
//                                               BorderRadius.circular(11),
//                                         ),
//                                         margin: const EdgeInsets.symmetric(
//                                             horizontal: 30, vertical: 20),
//                                         child: Column(
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal: 20,
//                                                 vertical: 40,
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Exam Room: ${room.name}",
//                                                     style:                                                         .nunitoBold
//                                                         .copyWith(
//                                                       fontSize: 20,
//                                                       color: ColorManager
//                                                           .bgSideMenu,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "Division : ${room.division}",
//                                                     style:                                                         .nunitoBold
//                                                         .copyWith(
//                                                       fontSize: 20,
//                                                       color: ColorManager
//                                                           .bgSideMenu,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "Class Name : $classname",
//                                                     style:                                                         .nunitoBold
//                                                         .copyWith(
//                                                       fontSize: 20,
//                                                       color: ColorManager
//                                                           .bgSideMenu,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "Students Max Capacity : ${room.capacity}",
//                                                     style:                                                         .nunitoBold
//                                                         .copyWith(
//                                                       fontSize: 20,
//                                                       color: ColorManager
//                                                           .bgSideMenu,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       showGeneralDialog(
//                                                         context: context,
//                                                         pageBuilder:
//                                                             (ctx, a1, a2) {
//                                                           return Container();
//                                                         },
//                                                         transitionBuilder: (ctx,
//                                                             a1, a2, child) {
//                                                           var curve = Curves
//                                                               .easeInOut
//                                                               .transform(
//                                                             a1.value,
//                                                           );

//                                                           return Transform
//                                                               .scale(
//                                                             scale: curve,
//                                                             child:
//                                                                 StatefulBuilder(
//                                                               builder: (context,
//                                                                       setState) =>
//                                                                   AlertDialog(
//                                                                 shape:
//                                                                     const RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .all(
//                                                                     Radius.circular(
//                                                                         20.0),
//                                                                   ),
//                                                                 ),
//                                                                 backgroundColor:
//                                                                     Colors
//                                                                         .white,
//                                                                 content: Form(
//                                                                   child: Column(
//                                                                     mainAxisSize:
//                                                                         MainAxisSize
//                                                                             .min,
//                                                                     children: [
//                                                                       Align(
//                                                                         alignment:
//                                                                             AlignmentDirectional.topEnd,
//                                                                         child:
//                                                                             IconButton(
//                                                                           alignment:
//                                                                               AlignmentDirectional.topEnd,
//                                                                           color:
//                                                                               Colors.black,
//                                                                           icon:
//                                                                               const Icon(Icons.close),
//                                                                           onPressed:
//                                                                               () {
//                                                                             Get.back();
//                                                                           },
//                                                                         ),
//                                                                       ),
//                                                                       Text(
//                                                                         "Delete Exam Room",
//                                                                         style: nunitoBold.copyWith(
//                                                                             color:
//                                                                                 Colors.black,
//                                                                             fontSize: 20),
//                                                                       ),
//                                                                       Text(
//                                                                         "Are You Sure ?",
//                                                                         style: nunitoRegular.copyWith(
//                                                                             color:
//                                                                                 Colors.black,
//                                                                             fontSize: 18),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         height:
//                                                                             20,
//                                                                       ),
//                                                                       Row(
//                                                                         children: [
//                                                                           Expanded(
//                                                                             child:
//                                                                                 InkWell(
//                                                                               onTap: () {
//                                                                                 Get.back();
//                                                                               },
//                                                                               child: Container(
//                                                                                 height: 45,
//                                                                                 decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(11)), color: ColorManager.bgSideMenu),
//                                                                                 child: Center(
//                                                                                   child: Text(
//                                                                                     "No",
//                                                                                     style: nunitoRegular.copyWith(color: Colors.white, fontSize: 18),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           const SizedBox(
//                                                                             width:
//                                                                                 10,
//                                                                           ),
//                                                                           Expanded(
//                                                                             child:
//                                                                                 InkWell(
//                                                                               onTap: () {
//                                                                                 completeMissionsController.deleteExamRoom(id: room.id!);
//                                                                                 completeMissionsController.getDetialsControlMissionById(missionId: controller.missionDetials!.id!);

//                                                                                 completeMissionsController.update();

//                                                                                 Get.back();
//                                                                               },
//                                                                               child: Container(
//                                                                                 height: 45,
//                                                                                 decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomRight: Radius.circular(11)), color: ColorManager.glodenColor),
//                                                                                 child: Center(
//                                                                                   child: Text(
//                                                                                     "Yes",
//                                                                                     style: nunitoRegular.copyWith(color: Colors.white, fontSize: 18),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                       );
//                                                     },
//                                                     child: Container(
//                                                       height: 45,
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             const BorderRadius
//                                                                 .only(
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                             11,
//                                                           ),
//                                                         ),
//                                                         color: ColorManager.red,
//                                                       ),
//                                                       child: Center(
//                                                         child: Text(
//                                                           "Delete",
//                                                           style:                                                               .nunitoRegular
//                                                               .copyWith(
//                                                             color: Colors.white,
//                                                             fontSize: 18,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Expanded(
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       DistrbutionController
//                                                           distrbutionController =
//                                                           Get.find();

//                                                       distrbutionController.setRoom(
//                                                           classRoom: StudentServices
//                                                               .getClassResponse(
//                                                                   id: room
//                                                                       .schoolClassId)!,
//                                                           room: room);
//                                                       distrbutionController
//                                                           .goToRendarPage();

// // get rooom stud from server
//                                                     },
//                                                     child: Container(
//                                                       height: 45,
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             const BorderRadius
//                                                                 .only(
//                                                                 bottomRight: Radius
//                                                                     .circular(
//                                                                         11)),
//                                                         color: ColorManager
//                                                             .glodenColor,
//                                                       ),
//                                                       child: Center(
//                                                         child: Text(
//                                                           "Distribution",
//                                                           style:                                                               .nunitoRegular
//                                                               .copyWith(
//                                                             color: Colors.white,
//                                                             fontSize: 18,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ))
//                               : Expanded(
//                                   child: Center(
//                                     child: Text(
//                                       "No exam rooms",
//                                       style: nunitoBold.copyWith(
//                                         color: ColorManager.bgSideMenu,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//             )
          ],
        ),
      ),
    );
  }
}
