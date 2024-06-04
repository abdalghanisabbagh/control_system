import 'package:flutter/material.dart';

import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../base_screen.dart';
import 'widgets/add_new_proctor.dart';

class ProctorScreen extends StatelessWidget {
  const ProctorScreen({super.key});

  // Future _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: controller.selectedDate,
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime(2015),
  //       lastDate: DateTime(2101));
  //   if (picked != null) {
  //     controller.selectedDate = picked;
  //     controller.onSelectDate();
  //   }
  //   controller.dateController.text =
  //       DateFormat('dd MMMM yyyy').format(controller.selectedDate);
  // }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// userdata + create new proctors
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    MyDialogs.showDialog(
                      context,
                      const AddNewProctor(),
                    );
                  },
                  child: const Text("Create new proctor"),
                )
              ],
            ),
          ),

          //// missions / date
          // Obx(() => creatMissionController.yearList.isEmpty
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : DropdownSearch<YearsResponse>(
          //         items: creatMissionController.yearList,
          //         itemAsString: (item) => item.year,
          //         selectedItem:
          //             creatMissionController.selectedyear?.value,
          //         dropdownDecoratorProps: DropDownDecoratorProps(
          //           dropdownSearchDecoration: InputDecoration(
          //               focusedBorder: OutlineInputBorder(
          //                   borderSide:
          //                       BorderSide(color: ColorManager.glodenColor),
          //                   borderRadius: BorderRadius.circular(10)),
          //               border: OutlineInputBorder(
          //                   borderSide:
          //                       BorderSide(color: ColorManager.glodenColor),
          //                   borderRadius: BorderRadius.circular(10)),
          //               hintText: "Select Education Years",
          //               hintStyle:.nunitoRegular.copyWith(
          //                   fontSize: 16, color: ColorManager.black)),
          //         ),
          //         onChanged: ((value) {
          //           controller.selectedyear = value;
          //           controller.onChangeYear(value!);
          //         },),
          //       ),),
          const Padding(
            padding: EdgeInsets.all(8.0),
            // child: Obx(
            //   () => controller.mission.missionsLoader.value
            //       ? const Center(
            //           child: LinearProgressIndicator(),
            //         )
            //       : controller.mission.missions.isEmpty
            //           ? const Center(
            //               child: Text("No Missions"),
            //             )
            //           : Row(
            //               children: [
            //                 Expanded(
            //                   child:
            //                       DropdownSearch<MissionObjectResponse>(
            //                     popupProps: PopupProps.menu(
            //                       searchFieldProps: TextFieldProps(
            //                           decoration: InputDecoration(
            //                               hintText: "search",
            //                               hintStyle:
            //                                   .nunitoRegular
            //                                   .copyWith(
            //                                       fontSize: 16,
            //                                       color: ColorManager.black),
            //                               focusedBorder: OutlineInputBorder(
            //                                   borderSide: BorderSide(
            //                                       color: ColorManager.black),
            //                                   borderRadius:
            //                                       BorderRadius.circular(
            //                                           10)),
            //                               enabledBorder: OutlineInputBorder(
            //                                   borderSide: BorderSide(
            //                                       color: ColorManager.black),
            //                                   borderRadius:
            //                                       BorderRadius.circular(
            //                                           10))),
            //                           cursorColor: ColorManager.glodenColor),
            //                       showSearchBox: true,
            //                     ),
            //                     items: controller.mission.missions,
            //                     itemAsString: (item) => item.name!,
            //                     dropdownDecoratorProps:
            //                         DropDownDecoratorProps(
            //                       dropdownSearchDecoration:
            //                           InputDecoration(
            //                               focusedBorder:
            //                                   OutlineInputBorder(
            //                                       borderSide: BorderSide(
            //                                           color:
            //                                               ColorManager.black),
            //                                       borderRadius:
            //                                           BorderRadius
            //                                               .circular(10),),
            //                               border: OutlineInputBorder(
            //                                   borderSide: BorderSide(
            //                                       color: ColorManager.black),
            //                                   borderRadius:
            //                                       BorderRadius.circular(
            //                                           10),),
            //                               hintText: "Select Mission",
            //                               hintStyle:
            //                                   .nunitoRegular
            //                                   .copyWith(
            //                                       fontSize: 16,
            //                                       color: ColorManager.black)),
            //                     ),
            //                     onChanged: (value) {
            //                       controller.onchangeMission(value);
            //                     },
            //                     selectedItem: controller.selectedMission,
            //                   ),
            //                 ),
            //                 InkWell(
            //                   onTap: () {
            //                     _selectDate(context);
            //                   },
            //                   child: Container(
            //                     width: 200,
            //                     margin: const EdgeInsets.symmetric(
            //                         horizontal: 10),
            //                     decoration: BoxDecoration(
            //                       border: Border.all(
            //                           color: ColorManager.bgSideMenu,
            //                           width: 0.5),
            //                       borderRadius: const BorderRadius.all(
            //                           Radius.circular(15)),
            //                     ),
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 10),
            //                     child: TextFormField(
            //                       cursorColor: ColorManager.bgSideMenu,
            //                       enabled: false,
            //                       style:.nunitoRegular
            //                           .copyWith(fontSize: 14),
            //                       controller: controller.dateController,
            //                       decoration: InputDecoration(
            //                           suffixIcon: const Icon(
            //                             Icons.date_range_outlined,
            //                             color: Colors.black,
            //                           ),
            //                           focusedBorder: InputBorder.none,
            //                           enabledBorder: InputBorder.none,
            //                           errorBorder: InputBorder.none,
            //                           disabledBorder: InputBorder.none,
            //                           // hintText:
            //                           //     'Example: DD/MM/YYYY',
            //                           hintStyle:
            //                               .nunitoRegular
            //                               .copyWith(
            //                             color: ColorManager.black,
            //                           )),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            // ),
          ),

          //// rooms / proctors
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              // child: GetBuilder<Proctor_controller>(
              //   builder: (controller) {
              //     return controller.proctors.isEmpty
              //         ? const Center(
              //             child: Text("No Proctors"),
              //           )
              //         : Row(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisSize: MainAxisSize.max,
              //             children: [
              //               Expanded(
              //                 flex: 1,
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.lightBlueAccent,
              //                       border:
              //                           Border.all(color: Colors.blue),
              //                       borderRadius:
              //                           BorderRadius.circular(20)),
              //                   child: Column(
              //                     mainAxisSize: MainAxisSize.max,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.start,
              //                     children: [
              //                       Expanded(
              //                         child: Column(
              //                           children: [
              //                             Padding(
              //                               padding:
              //                                   const EdgeInsets.all(20),
              //                               child: Text(
              //                                 "Proctors (${controller.proctors.length}/${controller.allProctors.length})",
              //                                 style:
              //                                     .nunitoBold
              //                                     .copyWith(
              //                                         fontSize: 20,
              //                                         color:
              //                                             Colors.black),
              //                               ),
              //                             ),
              //                             Expanded(
              //                               child: ListView.builder(
              //                                 scrollDirection:
              //                                     Axis.vertical,
              //                                 shrinkWrap: true,
              //                                 itemCount: controller
              //                                     .proctors.length,
              //                                 itemBuilder:
              //                                     (context, index) {
              //                                   var proctor = controller
              //                                       .proctors[index];
              //                                   return Padding(
              //                                     padding:
              //                                         const EdgeInsets
              //                                             .all(8.0),
              //                                     child: InkWell(
              //                                       onDoubleTap: () {
              //                                         ProctorExams
              //                                             .unAssignProctorFromExam(
              //                                                 proctor);
              //                                       },
              //                                       onTap: () {
              //                                         controller
              //                                                 .selectedProctor =
              //                                             proctor;
              //                                         controller.update();
              //                                       },
              //                                       child: Container(
              //                                         decoration:
              //                                             BoxDecoration(
              //                                           color: controller
              //                                                       .selectedProctor !=
              //                                                   null
              //                                               ? controller.selectedProctor!
              //                                                           .id ==
              //                                                       proctor
              //                                                           .id
              //                                                   ? Colors
              //                                                       .white
              //                                                   : Colors
              //                                                       .blueGrey
              //                                               : Colors
              //                                                   .blueGrey,
              //                                           borderRadius:
              //                                               const BorderRadius
              //                                                   .all(
              //                                                   Radius.circular(
              //                                                       10)),
              //                                         ),
              //                                         child: Padding(
              //                                           padding:
              //                                               const EdgeInsets
              //                                                   .symmetric(
              //                                                   horizontal:
              //                                                       8),
              //                                           child: Text(
              //                                             '${index + 1}- ${proctor.userName}',
              //                                             style:
              //                                                 .nunitoBold
              //                                                 .copyWith(
              //                                                     color: ColorManager
              //                                                         .black,
              //                                                     fontSize:
              //                                                         20),
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   );
              //                                 },
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       /*
              //                        const Divider(
              //                           color: Colors.white,
              //                           height: 3,
              //                         ),
              //                         Expanded(
              //                           child: Column(
              //                             children: [
              //                               Padding(
              //                                 padding:
              //                                     const EdgeInsets.all(
              //                                         20),
              //                                 child: Text(
              //                                   "Principals",
              //                                   style:
              //                                       .nunitoBold
              //                                       .copyWith(
              //                                           fontSize: 20,
              //                                           color: Colors
              //                                               .black),
              //                                 ),
              //                               ),
              //                               Expanded(
              //                                 child: ListView.builder(
              //                                   scrollDirection:
              //                                       Axis.vertical,
              //                                   shrinkWrap: true,
              //                                   itemCount: controller
              //                                       .principal.length,
              //                                   itemBuilder:
              //                                       (context, index) {
              //                                     var proctor =
              //                                         controller
              //                                                 .principal[
              //                                             index];
              //                                     return Padding(
              //                                       padding:
              //                                           const EdgeInsets
              //                                               .all(8.0),
              //                                       child: InkWell(
              //                                         onDoubleTap: () {
              //                                           ProctorExams
              //                                               .unAssignProctorFromExam(
              //                                                   proctor);
              //                                         },
              //                                         onTap: () {
              //                                           controller
              //                                                   .selectedProctor =
              //                                               proctor;
              //                                           controller
              //                                               .update();
              //                                         },
              //                                         child: Container(
              //                                           decoration:
              //                                               BoxDecoration(
              //                                             color: controller
              //                                                         .selectedProctor !=
              //                                                     null
              //                                                 ? controller.selectedProctor!.id ==
              //                                                         proctor
              //                                                             .id
              //                                                     ? Colors
              //                                                         .white
              //                                                     : Colors
              //                                                         .blueGrey
              //                                                 : Colors
              //                                                     .blueGrey,
              //                                             borderRadius: const BorderRadius
              //                                                     .all(
              //                                                 Radius.circular(
              //                                                     10)),
              //                                           ),
              //                                           child: Padding(
              //                                             padding: const EdgeInsets
              //                                                     .symmetric(
              //                                                 horizontal:
              //                                                     8),
              //                                             child: Row(
              //                                               mainAxisAlignment:
              //                                                   MainAxisAlignment
              //                                                       .spaceBetween,
              //                                               children: [
              //                                                 Text(
              //                                                   proctor.userName ??
              //                                                       '',
              //                                                   style:.nunitoBold.copyWith(
              //                                                       color:
              //                                                           ColorManager.black,
              //                                                       fontSize: 20),
              //                                                 ),
              //                                                 Text(
              //                                                   proctor.isFloorManager ??
              //                                                       '',
              //                                                   style:.nunitoBold.copyWith(
              //                                                       color:
              //                                                           ColorManager.red,
              //                                                       fontSize: 20),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     );
              //                                   },
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                      */
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 width: 20,
              //               ),
              //               // Expanded(
              //               //   flex: 3,
              //               //   child: Obx(
              //               //     () {
              //               //       return controller.selectedProctor
              //               //                   ?.isFloorManager !=
              //               //               null
              //               //           ? ListView(
              //               //               shrinkWrap: true,
              //               //               children: [
              //               //                 Center(
              //               //                   child: Padding(
              //               //                     padding:
              //               //                         const EdgeInsets.all(
              //               //                             8.0),
              //               //                     child: Text(
              //               //                       "Rooms",
              //               //                       style:
              //               //                           nunitoSemiBold
              //               //                           .copyWith(
              //               //                               fontSize: 36,
              //               //                               fontWeight:
              //               //                                   FontWeight
              //               //                                       .bold,),
              //               //                     ),
              //               //                   ),
              //               //                 ),
              //               //                 controller.allExamRooms
              //               //                         .where((p0) =>
              //               //                             p0.schoolClassType ==
              //               //                             controller
              //               //                                 .selectedProctor
              //               //                                 ?.isFloorManager)
              //               //                         .toList()
              //               //                         .isEmpty
              //               //                     ? Center(
              //               //                         child: Text(
              //               //                             "No Room With in ${controller.selectedProctor?.isFloorManager} School"),
              //               //                       )
              //               //                     : GridView.builder(
              //               //                         shrinkWrap: true,
              //               //                         gridDelegate:
              //               //                             const SliverGridDelegateWithFixedCrossAxisCount(
              //               //                                 crossAxisCount:
              //               //                                     6,
              //               //                                 mainAxisSpacing:
              //               //                                     5,
              //               //                                 crossAxisSpacing:
              //               //                                     5,
              //               //                                 childAspectRatio:
              //               //                                     2.2),
              //               //                         itemCount: controller
              //               //                             .allExamRooms
              //               //                             .where((p0) =>
              //               //                                 p0.schoolClassType ==
              //               //                                 controller
              //               //                                     .selectedProctor
              //               //                                     ?.isFloorManager)
              //               //                             .toList()
              //               //                             .length,
              //               //                         itemBuilder:
              //               //                             (context, index) {
              //               //                           var room = controller
              //               //                               .allExamRooms
              //               //                               .where((p0) =>
              //               //                                   p0.schoolClassType ==
              //               //                                   controller
              //               //                                       .selectedProctor
              //               //                                       ?.isFloorManager)
              //               //                               .toList()[index];
              //               //                           return InkWell(
              //               //                             // onTap: () {
              //               //                             //   /// get exam missin in this room
              //               //                             //   ProctorExams
              //               //                             //       .assignProctorToExamByRoomId(
              //               //                             //           room
              //               //                             //               .id!,
              //               //                             //           controller
              //               //                             //               .selectedProctor);
              //               //                             // },
              //               //                             child: Container(
              //               //                               padding:
              //               //                                   const EdgeInsets
              //               //                                       .all(8),
              //               //                               decoration: BoxDecoration(
              //               //                                   color: Colors
              //               //                                       .lightBlueAccent,
              //               //                                   border: Border.all(
              //               //                                       color: Colors
              //               //                                           .blue),
              //               //                                   borderRadius:
              //               //                                       BorderRadius.circular(
              //               //                                           10),),
              //               //                               child: Column(
              //               //                                 mainAxisAlignment:
              //               //                                     MainAxisAlignment
              //               //                                         .center,
              //               //                                 mainAxisSize:
              //               //                                     MainAxisSize
              //               //                                         .min,
              //               //                                 children: [
              //               //                                   Text(room
              //               //                                       .name),
              //               //                                   Text(
              //               //                                     room.schoolClassType,
              //               //                                   )
              //               //                                 ],
              //               //                               ),
              //               //                             ),
              //               //                           );
              //               //                         },
              //               //                       ),
              //               //               ],
              //               //             )
              //               //           : controller.roomsLoading
              //               //               ? const Center(
              //               //                   child: Column(
              //               //                     mainAxisSize:
              //               //                         MainAxisSize.min,
              //               //                     children: [
              //               //                       CircularProgressIndicator(),
              //               //                       Text('Loading...')
              //               //                     ],
              //               //                   ),
              //               //                 )
              //               //               : controller
              //               //                       .allExamRooms.isEmpty
              //               //                   ? const Center(
              //               //                       child: Text(
              //               //                         "No Rooms",
              //               //                       ),
              //               //                     )
              //               //                   : ListView(
              //               //                       shrinkWrap: true,
              //               //                       children: [
              //               //                         Center(
              //               //                           child: Padding(
              //               //                             padding:
              //               //                                 const EdgeInsets
              //               //                                     .all(
              //               //                               8.0,
              //               //                             ),
              //               //                             child: Text(
              //               //                               "Rooms",
              //               //                               style:
              //               //                                   nunitoSemiBold
              //               //                                   .copyWith(
              //               //                                 fontSize: 36,
              //               //                                 fontWeight:
              //               //                                     FontWeight
              //               //                                         .bold,
              //               //                               ),
              //               //                             ),
              //               //                           ),
              //               //                         ),
              //               //                         GridView.builder(
              //               //                           shrinkWrap: true,
              //               //                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //               //                               crossAxisCount:
              //               //                                   6,
              //               //                               mainAxisSpacing:
              //               //                                   5,
              //               //                               crossAxisSpacing:
              //               //                                   5,
              //               //                               childAspectRatio:
              //               //                                   1.8),
              //               //                           itemCount: controller
              //               //                               .allExamRooms
              //               //                               .where((p0) =>
              //               //                                   p0.schoolClassType ==
              //               //                                   controller
              //               //                                       .userStage)
              //               //                               .length,
              //               //                           itemBuilder:
              //               //                               (context,
              //               //                                   index) {
              //               //                             var room = controller
              //               //                                 .allExamRooms
              //               //                                 .where((p0) =>
              //               //                                     p0.schoolClassType ==
              //               //                                     controller
              //               //                                         .userStage)
              //               //                                 .toList()[index];
              //               //                             controller
              //               //                                 .userStage;
              //               //                             return InkWell(
              //               //                               // onTap:
              //               //                               //     () {
              //               //                               //   /// get exam missin in this room

              //               //                               //   ProctorExams.assignProctorToExamByRoomId(
              //               //                               //       room.id!,
              //               //                               //       controller.selectedProctor);
              //               //                               // },
              //               //                               // onDoubleTap:
              //               //                               // () {
              //               //                               /// get exam missin in this room

              //               //                               // ProctorExams.unAssignProctorFromRoom(
              //               //                               // room);
              //               //                               // },
              //               //                               child:
              //               //                                   Container(
              //               //                                 padding:
              //               //                                     const EdgeInsets
              //               //                                         .all(
              //               //                                         8),
              //               //                                 decoration: BoxDecoration(
              //               //                                     color: Colors
              //               //                                         .lightBlueAccent,
              //               //                                     border: Border.all(
              //               //                                         color: Colors
              //               //                                             .blue),
              //               //                                     borderRadius:
              //               //                                         BorderRadius.circular(
              //               //                                             10),),
              //               //                                 child: Column(
              //               //                                   mainAxisAlignment:
              //               //                                       MainAxisAlignment
              //               //                                           .center,
              //               //                                   mainAxisSize:
              //               //                                       MainAxisSize
              //               //                                           .min,
              //               //                                   children: [
              //               //                                     Row(
              //               //                                       mainAxisSize:
              //               //                                           MainAxisSize.max,
              //               //                                       crossAxisAlignment:
              //               //                                           CrossAxisAlignment.start,
              //               //                                       mainAxisAlignment:
              //               //                                           MainAxisAlignment.spaceBetween,
              //               //                                       children: [
              //               //                                         Text(room
              //               //                                             .name),
              //               //                                         Text(room
              //               //                                             .schoolClassType)
              //               //                                       ],
              //               //                                     ),
              //               //                                     if (room.proctoInRoomWithExam !=
              //               //                                             null &&
              //               //                                         room.proctoInRoomWithExam!
              //               //                                             .isNotEmpty)
              //               //                                       Center(
              //               //                                         child:
              //               //                                             ListView.builder(
              //               //                                           shrinkWrap:
              //               //                                               true,
              //               //                                           itemCount:
              //               //                                               room.proctoInRoomWithExam!.length,
              //               //                                           itemBuilder:
              //               //                                               (context, index) {
              //               //                                             return Center(
              //               //                                               child: Text(
              //               //                                                 room.proctoInRoomWithExam![index].proctor.userName!,
              //               //                                                 style: const TextStyle(color: Colors.red),
              //               //                                               ),
              //               //                                             );
              //               //                                           },
              //               //                                         ),
              //               //                                       )
              //               //                                   ],
              //               //                                 ),
              //               //                               ),
              //               //                             );
              //               //                           },
              //               //                         ),
              //               //                       ],
              //               //                     );
              //               //     },
              //               //   ),
              //               // )
              //             ],
              //           );
              //   },
              // ),
            ),
          )
        ],
      ),
    );
  }
}
