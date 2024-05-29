import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/subject/subject_res_model.dart';
import 'package:control_system/domain/controllers/subject_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import "package:control_system/presentation/views/subject_setting/widgets/add_subject_widget.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SubjectSettingScreen extends GetView<SubjectsController> {
  const SubjectSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: GetBuilder<SubjectsController>(
        builder: (_) {
          return Container(
            color: ColorManager.bgColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subject",
                      style: nunitoBlack.copyWith(
                        color: ColorManager.bgSideMenu,
                        fontSize: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // RxBool inExam = true.obs;
                        // TextEditingController subjectTitleController =
                        //     TextEditingController();

                        MyDialogs.showDialog(
                          context,
                          const AddSubjectWidget(),
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
                              "Add Subject",
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: controller.getAllLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.subjects.isEmpty
                          ? Center(
                              child: Text(
                                "No Subject",
                                style: nunitoBold.copyWith(
                                  color: ColorManager.bgSideMenu,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : SearchableList<SubjectResModel>(
                              initialList: controller.subjects,
                              emptyWidget: Center(
                                child: Text(
                                  "No data found",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.bgSideMenu,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              filter: (value) => controller.subjects
                                  .where((element) => element.name!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList(),
                              itemBuilder: (SubjectResModel item) {
                                bool inExam = true;
                                // bool inExam = controller.subjects[index].inExam == 0
                                //     ? false
                                //     : true;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 50),
                                        child: Container(
                                          height: 250,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 20,
                                                offset: const Offset(2,
                                                    15), // changes position of shadow
                                              ),
                                            ],
                                            color: ColorManager.ligthBlue,
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name ?? "Subject Name",
                                                  style: nunitoBold.copyWith(
                                                    color:
                                                        ColorManager.bgSideMenu,
                                                    fontSize: 35,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                // Text(
                                                //     controller
                                                //         .selectedSchool!
                                                //         .name,
                                                //     style:                                                     nunitoRegular
                                                //         .copyWith(
                                                //             color: ColorManager
                                                //                 .bgSideMenu,
                                                //             fontSize:
                                                //                 20),),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "In Exam ",
                                                      style: nunitoRegular
                                                          .copyWith(
                                                        color: ColorManager
                                                            .bgSideMenu,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    GetBuilder<
                                                        SubjectsController>(
                                                      builder:
                                                          (subjectsControllers) =>
                                                              Switch(
                                                        activeColor:
                                                            ColorManager
                                                                .bgSideMenu,
                                                        value: inExam,
                                                        onChanged: (value) {
                                                          if (inExam) {
                                                            inExam = false;
                                                            if (kDebugMode) {
                                                              print(inExam);
                                                            }
                                                          } else {
                                                            inExam = true;
                                                            if (kDebugMode) {
                                                              print(inExam);
                                                            }
                                                          }
                                                          subjectsControllers
                                                              .update();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    MyAwesomeDialogue(
                                                      title:
                                                          'You are about to delete this subject',
                                                      desc: 'Are you sure?',
                                                      dialogType:
                                                          DialogType.warning,
                                                      btnOkOnPressed: () {
                                                        controller
                                                            .deleteSubject(
                                                          id: item.iD!,
                                                        )
                                                            .then(
                                                          (value) {
                                                            value
                                                                ? {
                                                                    MyFlashBar
                                                                        .showSuccess(
                                                                      "Subject has been deleted successfully",
                                                                      "Subject Deleted",
                                                                    ).show(
                                                                        context),
                                                                  }
                                                                : null;
                                                          },
                                                        );
                                                      },
                                                      btnCancelOnPressed: () {
                                                        Get.back();
                                                      },
                                                    ).showDialogue(context);
                                                  },
                                                  child: Container(
                                                    width: 150,
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
                                                            const EdgeInsets
                                                                .all(
                                                          10,
                                                        ),
                                                        child: Text(
                                                          "Delete Subject",
                                                          style: nunitoBold
                                                              .copyWith(
                                                            color: ColorManager
                                                                .white,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 100,
                                        bottom: 150,
                                        child: Image.asset(
                                          AssetsManager.assetsIconsArabic,
                                          fit: BoxFit.fill,
                                          height: 200,
                                          width: 200,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),

            // child: Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text("Cohort",
            //             style: nunitoBlack.copyWith(
            //               color: ColorManager.bgSideMenu,
            //               fontSize: 30,
            //             )),
            //         IconButton(
            //             onPressed: () {
            //               TextEditingController editingController =
            //                   TextEditingController();
            //               MyDialogs.showAddDialog(
            //                   context,
            //                   Column(
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       Text("Add new Cohort",
            //                           style: nunitoRegular
            //                               .copyWith(
            //                             color: ColorManager.bgSideMenu,
            //                             fontSize: 25,
            //                           )),
            //                       const SizedBox(
            //                         height: 10,
            //                       ),
            //                       TextFormField(
            //                         cursorColor: ColorManager.bgSideMenu,
            //                         style: nunitoRegular
            //                             .copyWith(
            //                                 fontSize: 14,
            //                                 color: ColorManager.bgSideMenu),
            //                         decoration: InputDecoration(
            //                           hintText: "Cohort name",
            //                           hintStyle:           //                               nunitoRegular
            //                               .copyWith(
            //                                   fontSize: 14,
            //                                   color: ColorManager.bgSideMenu),
            //                           focusedBorder: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(5)),
            //                           enabledBorder: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(5)),
            //                           errorBorder: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(5)),
            //                           disabledBorder: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(5)),
            //                         ),
            //                         controller: editingController,
            //                         onChanged: (value) {
            //                           int found =
            //                               controller.cohorts.indexWhere(
            //                             (p0) => p0.name == value,
            //                           );
            //                           if (found > -1) {
            //                             log('founded');
            //                           }
            //                         },
            //                       ),
            //                       const SizedBox(
            //                         height: 10,
            //                       ),
            //                       Row(
            //                         children: [
            //                           Expanded(
            //                             child: InkWell(
            //                               onTap: () {
            //                                 Get.back();
            //                               },
            //                               child: Container(
            //                                 height: 45,
            //                                 decoration: BoxDecoration(
            //                                     borderRadius:
            //                                         const BorderRadius
            //                                                 .only(
            //                                             bottomLeft: Radius
            //                                                 .circular(
            //                                                     11)),
            //                                     color:
            //                                         ColorManager.bgSideMenu),
            //                                 child: Center(
            //                                   child: Text(
            //                                     "Back",
            //                                     style:           //                                         nunitoRegular
            //                                         .copyWith(
            //                                             color:
            //                                                 Colors.white,
            //                                             fontSize: 18),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                           const SizedBox(
            //                             width: 10,
            //                           ),
            //                           Expanded(
            //                             child: InkWell(
            //                               onTap: () async {
            //                                 if (editingController.text !=
            //                                     "") {
            //                                   int found = controller
            //                                       .cohorts
            //                                       .indexWhere(
            //                                     (p0) =>
            //                                         p0.name ==
            //                                         editingController
            //                                             .text,
            //                                   );
            //                                   if (found > -1) {
            //                                     log('founded');
            //                                   } else {
            //                                     try {
            //                                       await controller
            //                                           .addNewCohotFromServer(
            //                                               editingController
            //                                                   .text);
            //                                       // ignore: use_build_context_synchronously
            //                                       Navigator.pop(context);
            //                                       MyReusbleWidget
            //                                           .mySnackBarGood(
            //                                               "Cohort Create",
            //                                               "Cohort has been created");
            //                                     } catch (e) {
            //                                       if (kDebugMode) {
            //                                         print(e);
            //                                       }
            //                                     }
            //                                   }
            //                                 } else {
            //                                   MyReusbleWidget
            //                                       .mySnackBarError(
            //                                           "Cohort Create",
            //                                           "enter cohort name");
            //                                 }
            //                               },
            //                               child: Container(
            //                                 height: 45,
            //                                 decoration: BoxDecoration(
            //                                     borderRadius:
            //                                         const BorderRadius
            //                                                 .only(
            //                                             bottomRight:
            //                                                 Radius
            //                                                     .circular(
            //                                                         11)),
            //                                     color:
            //                                         ColorManager.glodenColor),
            //                                 child: Center(
            //                                   child: Text(
            //                                     "Yes",
            //                                     style:           //                                         nunitoRegular
            //                                         .copyWith(
            //                                             color:
            //                                                 Colors.white,
            //                                             fontSize: 18),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       )
            //                     ],
            //                   ));
            //             },
            //             icon: const Icon(Icons.add))
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     const Expanded(
            //       child: CohotSystemWidget(),
            //     ),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     const Expanded(
            //       child: SubjectSystemWidget(),
            //     ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
