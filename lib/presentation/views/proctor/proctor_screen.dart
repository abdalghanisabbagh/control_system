import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/proctor_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';
import '../base_screen.dart';
import 'widgets/add_new_proctor.dart';

class ProctorScreen extends GetView<ProctorController> {
  const ProctorScreen({super.key});

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: controller.selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      // controller.selectedDate = picked;
      // controller.onSelectDate();
    }
    // controller.dateController.text =
    //     DateFormat('dd MMMM yyyy').format(controller.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: GetBuilder<ProctorController>(
        id: 'proctorEntryScreen',
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: LoadingIndicators.getLoadingIndicator(),
                )
              : Column(
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
                                const CreateNewProctor(),
                              );
                            },
                            child: const Text("Create new proctor"),
                          )
                        ],
                      ),
                    ),
                    MultiSelectDropDownView(
                      hintText: "Select Education Year",
                      multiSelect: false,
                      showChipSelect: true,
                      onOptionSelected: controller.onEducationYearChange,
                      options: controller.optionsEducationYear,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<ProctorController>(
                        builder: (_) => controller.controlMissionsAreLoading
                            ? Center(
                                child: LoadingIndicators.getLoadingIndicator(),
                              )
                            : controller.selectedEducationYearId == null
                                ? Center(
                                    child: Text(
                                      "Please Select Education Year First",
                                      style: nunitoRegular,
                                    ),
                                  )
                                : controller.controlMissions.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Missions Created For Selected Education Year",
                                          style: nunitoRegular,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: MultiSelectDropDownView(
                                              showChipSelect: true,
                                              searchEnabled: true,
                                              multiSelect: false,
                                              options: controller
                                                  .optionsControlMissions,
                                              onOptionSelected: controller
                                                  .onControlMissionsChange,
                                              hintText:
                                                  "Select Control Missions",
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _selectDate(context);
                                            },
                                            child: Container(
                                              width: 200,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: TextFormField(
                                                cursorColor:
                                                    ColorManager.bgSideMenu,
                                                enabled: false,
                                                style: nunitoRegular.copyWith(
                                                  fontSize: 14,
                                                ),
                                                // controller:
                                                //     controller.dateController,
                                                decoration: InputDecoration(
                                                  suffixIcon: const Icon(
                                                    Icons.date_range_outlined,
                                                    color: Colors.black,
                                                  ),
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText:
                                                      'Example: DD/MM/YYYY',
                                                  hintStyle:
                                                      nunitoRegular.copyWith(
                                                    color: ColorManager.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                      ),
                    ),

                    //// rooms / proctors
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: controller.proctors.isEmpty
                            ? const Center(
                                child: Text("No Proctors"),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,
                                        border: Border.all(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    "Proctors (${controller.proctors.length})",
                                                    style: nunitoBold.copyWith(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                GetBuilder<ProctorController>(
                                                  id: 'proctors',
                                                  builder: (context) {
                                                    return Expanded(
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: controller
                                                            .proctors.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return InkWell(
                                                            onDoubleTap: () {},
                                                            // onDoubleTap: () {
                                                            //   MyDialogs
                                                            //       .showDialog(
                                                            //     context,
                                                            //     EditProctorWidget(
                                                            //       proctor: controller
                                                            //               .proctors[
                                                            //           index],
                                                            //     ),
                                                            //   );
                                                            // },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ColorManager
                                                                      .ligthBlue,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                      10,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child: Text(
                                                                    '${index + 1} - ${controller.proctors[index].userName}',
                                                                    style: nunitoBold
                                                                        .copyWith(
                                                                      color: ColorManager
                                                                          .black,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                            height: 3,
                                          ),
                                          // Expanded(
                                          //   child: Column(
                                          //     children: [
                                          //       Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(20),
                                          //         child: Text(
                                          //           "Principals",
                                          //           style: nunitoBold.copyWith(
                                          //             fontSize: 20,
                                          //             color: Colors.black,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         child: ListView.builder(
                                          //           scrollDirection:
                                          //               Axis.vertical,
                                          //           shrinkWrap: true,
                                          //           itemCount: controller
                                          //               .proctors.length,
                                          //           itemBuilder:
                                          //               (context, index) {
                                          //             return Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(8.0),
                                          //               child: InkWell(
                                          //                 onDoubleTap: () {
                                          //                   // ProctorExams
                                          //                   //     .unAssignProctorFromExam(
                                          //                   //         proctor);
                                          //                 },
                                          //                 onTap: () {
                                          //                   controller
                                          //                           .selectedProctor =
                                          //                       controller
                                          //                               .proctors[
                                          //                           index];
                                          //                   controller.update();
                                          //                 },
                                          //                 child: Container(
                                          //                   decoration:
                                          //                       BoxDecoration(
                                          //                     color: controller
                                          //                                 .selectedProctor !=
                                          //                             null
                                          //                         ? controller.selectedProctor
                                          //                                     ?.iD ==
                                          //                                 controller
                                          //                                     .proctors[
                                          //                                         index]
                                          //                                     .iD
                                          //                             ? Colors
                                          //                                 .white
                                          //                             : Colors
                                          //                                 .blueGrey
                                          //                         : Colors
                                          //                             .blueGrey,
                                          //                     borderRadius:
                                          //                         const BorderRadius
                                          //                             .all(
                                          //                       Radius.circular(
                                          //                         10,
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                   child: Padding(
                                          //                     padding:
                                          //                         const EdgeInsets
                                          //                             .symmetric(
                                          //                       horizontal: 8,
                                          //                     ),
                                          //                     child: Row(
                                          //                       mainAxisAlignment:
                                          //                           MainAxisAlignment
                                          //                               .spaceBetween,
                                          //                       children: [
                                          //                         Text(
                                          //                           controller
                                          //                                   .proctors[index]
                                          //                                   .userName ??
                                          //                               '',
                                          //                           style: nunitoBold
                                          //                               .copyWith(
                                          //                             color: ColorManager
                                          //                                 .black,
                                          //                             fontSize:
                                          //                                 20,
                                          //                           ),
                                          //                         ),
                                          //                         // Text(
                                          //                         //   controller.proctors[index].isFloorManager ??
                                          //                         //       '',
                                          //                         //   style:nunitoBold.copyWith(
                                          //                         //       color:
                                          //                         //           ColorManager.red,
                                          //                         //       fontSize: 20,),
                                          //                         // ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             );
                                          //           },
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: GetBuilder<ProctorController>(
                                      builder: (_) => controller
                                              .examRoomsAreLoading
                                          ? Center(
                                              child: LoadingIndicators
                                                  .getLoadingIndicator(),
                                            )
                                          : controller.examRooms.isEmpty
                                              ? controller.selectedEducationYearId !=
                                                          null &&
                                                      controller
                                                              .selectedControlMissionsId !=
                                                          null
                                                  ? Center(
                                                      child: Text(
                                                        'No Exam Rooms Available. Please Create At Least One Exam Room',
                                                        style:
                                                            nunitoBold.copyWith(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'First Select Education Year',
                                                          style: nunitoBold
                                                              .copyWith(
                                                            decoration: controller
                                                                        .selectedEducationYearId !=
                                                                    null
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : null,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          'Second Select Control Mission',
                                                          style: nunitoBold
                                                              .copyWith(
                                                            decoration: controller
                                                                        .selectedControlMissionsId !=
                                                                    null
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : null,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                              : GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 6,
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 5,
                                                    childAspectRatio: 2,
                                                  ),
                                                  itemCount: controller
                                                      .examRooms.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      // onTap: () {
                                                      //   /// get exam missin in this room
                                                      //   ProctorExams
                                                      //       .assignProctorToExamByRoomId(
                                                      //           room
                                                      //               .id!,
                                                      //           controller
                                                      //               .selectedProctor);
                                                      // },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .lightBlueAccent,
                                                          border: Border.all(
                                                            color: Colors.blue,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  '${controller.examRooms[index].name}'),
                                                            ),
                                                            Text(
                                                              '${controller.examRooms[index].stage}',
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                    ),
                                  ),
                                ],
                              ),
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
                        //                           Border.all(color: Colors.blue,),
                        //                       borderRadius:
                        //                           BorderRadius.circular(20),),
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
                        //               //               ? Center(
                        //               //                   child: Column(
                        //               //                     mainAxisSize:
                        //               //                         MainAxisSize.min,
                        //               //                     children: [
                        //               //                       LoadingIndicators.getLoadingIndicator(),
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
                ).paddingSymmetric(
                  horizontal: 10,
                );
        },
      ),
    );
  }
}
