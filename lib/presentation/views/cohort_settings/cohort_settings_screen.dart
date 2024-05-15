import 'package:control_system/presentation/resource_manager/ReusableWidget/add_dialogs.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

class CohortSettingsScreen extends StatelessWidget {
  const CohortSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cohorts",
                  style: nunitoBlack.copyWith(
                    color: ColorManager.bgSideMenu,
                    fontSize: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    TextEditingController editingController =
                        TextEditingController();
                    MyDialogs.showAddDialog(
                      context,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add new Cohort",
                            style: nunitoRegular.copyWith(
                              color: ColorManager.bgSideMenu,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            cursorColor: ColorManager.bgSideMenu,
                            style: nunitoRegular.copyWith(
                                fontSize: 14, color: ColorManager.bgSideMenu),
                            decoration: InputDecoration(
                              hintText: "Cohort name",
                              hintStyle: nunitoRegular.copyWith(
                                fontSize: 14,
                                color: ColorManager.bgSideMenu,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            controller: editingController,
                            onChanged: (value) {
                              // int found =
                              //     controller.cohorts.indexWhere(
                              //   (p0) => p0.name == value,
                              // );
                              // if (found > -1) {
                              //   log('founded');
                              // }
                            },
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          // Expanded(
                          //   child: InkWell(
                          //     onTap: () async {
                          // if (editingController.text !=
                          //     "") {
                          //   int found = controller.cohorts
                          //       .indexWhere(
                          //     (p0) =>
                          //         p0.name ==
                          //         editingController.text,
                          //   );
                          //   if (found > -1) {
                          //     log('founded');
                          //   } else {
                          //     try {
                          //       await controller
                          //           .addNewCohotFromServer(
                          //               editingController
                          //                   .text);
                          //       // ignore: use_build_context_synchronously
                          //       Navigator.pop(context);
                          //       MyReusbleWidget.mySnackBarGood(
                          //           "Cohort Create",
                          //           "Cohort has been created");
                          //     } catch (e) {
                          //       if (kDebugMode) {
                          //         print(e);
                          //       }
                          //     }
                          //   }
                          // } else {
                          //   MyReusbleWidget.mySnackBarError(
                          //       "Cohort Create",
                          //       "enter cohort name");
                          // }
                          // },
                          // child: Container(
                          //   height: 45,
                          //   decoration: BoxDecoration(
                          //     borderRadius: const BorderRadius.only(
                          //       bottomRight: Radius.circular(11),
                          //     ),
                          //     color: ColorManager.glodenColor,
                          //   ),
                          //   child: Center(
                          //     child: Text(
                          //       "Yes",
                          //       style: nunitoReguler.copyWith(
                          //         color: Colors.white,
                          //         fontSize: 18,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.glodenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Add Cohorts",
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      // controller.cohorts.isEmpty?
                      Center(
                    child: Text(
                      "Please Add Cohorts",
                      style: nunitoBold.copyWith(
                        color: ColorManager.bgSideMenu,
                        fontSize: 16,
                      ),
                    ),
                  )
                  // : ListView.builder(
                  //     itemCount: controller.cohorts.length,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Stack(
                  //           children: [
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(
                  //                       vertical: 50),
                  //               child: Container(
                  //                 height: 250,
                  //                 width: double.infinity,
                  //                 decoration: BoxDecoration(
                  //                     boxShadow: [
                  //                       BoxShadow(
                  //                         color: Colors.grey
                  //                             .withOpacity(0.5),
                  //                         spreadRadius: 5,
                  //                         blurRadius: 20,
                  //                         offset: const Offset(2,
                  //                             15), // changes position of shadow
                  //                       ),
                  //                     ],
                  //                     color: ColorManager.white,
                  //                     borderRadius:
                  //                         BorderRadius.circular(
                  //                             11)),
                  //                 padding:
                  //                     const EdgeInsets.all(10),
                  //                 child: Padding(
                  //                   padding:
                  //                       const EdgeInsets.all(20),
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment
                  //                             .start,
                  //                     children: [
                  //                       Text(
                  //                           controller
                  //                               .cohorts[index]
                  //                               .name,
                  //                           style:                                                       .nunitoBold
                  //                               .copyWith(
                  //                                   color: ColorManager
                  //                                       .bgSideMenu,
                  //                                   fontSize:
                  //                                       35)),
                  //                       const SizedBox(
                  //                         height: 10,
                  //                       ),
                  //                       Text(
                  //                           controller
                  //                               .selectedSchool!
                  //                               .name,
                  //                           style:                                                       .nunitoReguler
                  //                               .copyWith(
                  //                                   color: ColorManager
                  //                                       .bgSideMenu,
                  //                                   fontSize:
                  //                                       20)),
                  //                       SizedBox(
                  //                         width: MediaQuery.of(
                  //                                     context)
                  //                                 .size
                  //                                 .width *
                  //                             .6,
                  //                         height: 50,
                  //                         child: ListView.builder(
                  //                           scrollDirection:
                  //                               Axis.horizontal,
                  //                           itemCount: controller
                  //                               .cohorts[index]
                  //                               .subjects!
                  //                               .length,
                  //                           itemBuilder:
                  //                               (context, i) {
                  //                             return Padding(
                  //                               padding:
                  //                                   const EdgeInsets
                  //                                       .symmetric(
                  //                                       horizontal:
                  //                                           5),
                  //                               child: Text(
                  //                                 controller
                  //                                     .cohorts[
                  //                                         index]
                  //                                     .subjects![
                  //                                         i]
                  //                                     .name,
                  //                                 style:                                                             .nunitoReguler
                  //                                     .copyWith(
                  //                                         color: ColorManager
                  //                                             .bgSideMenu,
                  //                                         fontSize:
                  //                                             14),
                  //                               ),
                  //                             );
                  //                           },
                  //                         ),
                  //                       ),
                  //                       Row(
                  //                         children: [
                  //                           InkWell(
                  //                             onTap: () {
                  //                               SubjectsControllers
                  //                                   subjCont =
                  //                                   Get.find();

                  //                               ASHTARTDialogs
                  //                                   .showAddDialog(
                  //                                       context,
                  //                                       Column(
                  //                                         mainAxisSize:
                  //                                             MainAxisSize.min,
                  //                                         children: [
                  //                                           Text(controller
                  //                                               .cohorts[index]
                  //                                               .name),
                  //                                           const Divider(),
                  //                                           DropdownSearch<
                  //                                               SubjectResponse>.multiSelection(
                  //                                             popupProps:
                  //                                                 PopupPropsMultiSelection.menu(
                  //                                               searchFieldProps: TextFieldProps(decoration: InputDecoration(hintText: "search", hintStyle: nunitoReguler.copyWith(color: Colors.black, fontSize: 16), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.black), borderRadius: BorderRadius.circular(10)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.black), borderRadius: BorderRadius.circular(10))), cursorColor: ColorManager.black),
                  //                                               showSearchBox: true,
                  //                                             ),
                  //                                             selectedItems:
                  //                                                 subjCont.subjectsController,
                  //                                             items:
                  //                                                 subjCont.subjects,
                  //                                             itemAsString: (item) =>
                  //                                                 item.name,
                  //                                             dropdownDecoratorProps:
                  //                                                 DropDownDecoratorProps(
                  //                                               dropdownSearchDecoration: InputDecoration(focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.glodenColor), borderRadius: BorderRadius.circular(10)), border: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.glodenColor), borderRadius: BorderRadius.circular(10)), hintText: "Select Subject", hintStyle: nunitoReguler.copyWith(fontSize: 16, color: ColorManager.black)),
                  //                                             ),
                  //                                             onChanged:
                  //                                                 ((value) {
                  //                                               subjCont.subjectsController.value = value;
                  //                                               if (kDebugMode) {
                  //                                                 print(subjCont.subjectsController);
                  //                                               }
                  //                                             }),
                  //                                           ),
                  //                                           const SizedBox(
                  //                                             height:
                  //                                                 20,
                  //                                           ),
                  //                                           InkWell(
                  //                                             onTap:
                  //                                                 () async {
                  //                                               subjCont.addLoading.value = true;

                  //                                               await controller.addNewsubjectToCohort(subjCont.subjectsController, controller.cohorts[index].id);
                  //                                               subjCont.subjectsController.clear();
                  //                                               subjCont.addLoading.value = false;
                  //                                               // ignore: use_build_context_synchronously
                  //                                               Navigator.pop(context);
                  //                                             },
                  //                                             child: subjCont.addLoading.value == true
                  //                                                 ? const Center(
                  //                                                     child: CircularProgressIndicator(),
                  //                                                   )
                  //                                                 : Container(
                  //                                                     height: 50,
                  //                                                     width: double.infinity,
                  //                                                     decoration: BoxDecoration(color: ColorManager.bgSideMenu, borderRadius: BorderRadius.circular(10)),
                  //                                                     child: Center(
                  //                                                         child: Text(
                  //                                                       "Add Subjects",
                  //                                                       style: nunitoReguler.copyWith(color: Colors.white),
                  //                                                     )),
                  //                                                   ),
                  //                                           ),
                  //                                           SizedBox(
                  //                                             height:
                  //                                                 300,
                  //                                             width:
                  //                                                 200,
                  //                                             child:
                  //                                                 ListView.builder(
                  //                                               itemCount: controller.cohorts[index].subjects!.length,
                  //                                               itemBuilder: (context, i) {
                  //                                                 return Padding(
                  //                                                   padding: const EdgeInsets.symmetric(vertical: 10),
                  //                                                   child: Row(
                  //                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                     children: [
                  //                                                       Text(controller.cohorts[index].subjects![i].name),
                  //                                                       IconButton(
                  //                                                           onPressed: () {
                  //                                                             //delete supject from cohort
                  //                                                             controller.deleteubjectFromCohort(controller.cohorts[index].subjects![i].id, controller.cohorts[index].id);
                  //                                                             Navigator.pop(context);
                  //                                                           },
                  //                                                           icon: const Icon(Icons.delete))
                  //                                                     ],
                  //                                                   ),
                  //                                                 );
                  //                                               },
                  //                                             ),
                  //                                           ),
                  //                                           InkWell(
                  //                                             onTap:
                  //                                                 () {
                  //                                               Get.back();
                  //                                             },
                  //                                             child:
                  //                                                 Container(
                  //                                               width: double.infinity,
                  //                                               height: 45,
                  //                                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorManager.bgSideMenu),
                  //                                               child: Center(
                  //                                                 child: Text(
                  //                                                   "Back",
                  //                                                   style: nunitoReguler.copyWith(color: Colors.white, fontSize: 18),
                  //                                                 ),
                  //                                               ),
                  //                                             ),
                  //                                           ),
                  //                                         ],
                  //                                       ));
                  //                             },
                  //                             child: Container(
                  //                               decoration: BoxDecoration(
                  //                                   color: ColorManager
                  //                                       .glodenColor,
                  //                                   borderRadius:
                  //                                       BorderRadius
                  //                                           .circular(
                  //                                               10)),
                  //                               child: Center(
                  //                                 child: Padding(
                  //                                   padding:
                  //                                       const EdgeInsets
                  //                                           .all(
                  //                                           10),
                  //                                   child: Text(
                  //                                       "Add subjects",
                  //                                       style:                                                                   .nunitoBold
                  //                                           .copyWith(
                  //                                         color: ColorManager
                  //                                             .white,
                  //                                         fontSize:
                  //                                             16,
                  //                                       )),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           const SizedBox(
                  //                             width: 20,
                  //                           ),
                  //                           InkWell(
                  //                             onTap: () {},
                  //                             child: Container(
                  //                               decoration: BoxDecoration(
                  //                                   color: Colors
                  //                                       .red,
                  //                                   borderRadius:
                  //                                       BorderRadius
                  //                                           .circular(
                  //                                               10)),
                  //                               child: Center(
                  //                                 child: Padding(
                  //                                   padding:
                  //                                       const EdgeInsets
                  //                                           .all(
                  //                                           10),
                  //                                   child: Text(
                  //                                       "Delete Cohort",
                  //                                       style:                                                                   .nunitoBold
                  //                                           .copyWith(
                  //                                         color: ColorManager
                  //                                             .white,
                  //                                         fontSize:
                  //                                             16,
                  //                                       )),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             Positioned(
                  //               right: 100,
                  //               bottom: 150,
                  //               child: Image.asset(
                  //                 Constants.assetsImagesPath +
                  //                     Paths.arabic,
                  //                 fit: BoxFit.fill,
                  //                 height: 200,
                  //                 width: 200,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
