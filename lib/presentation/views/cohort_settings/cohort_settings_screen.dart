import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/cohort/cohort_res_model.dart';
import 'package:control_system/domain/controllers/cohorts_settings_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import "package:control_system/presentation/views/cohort_settings/widgets/add_cohort_widget.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

class CohortSettingsScreen extends GetView<CohortsSettingsController> {
  const CohortSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: GetBuilder<CohortsSettingsController>(
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
                      "Cohorts",
                      style: nunitoBlack.copyWith(
                        color: ColorManager.bgSideMenu,
                        fontSize: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        MyDialogs.showDialog(
                          context,
                          const AddCohortWidget(),
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
                    child: controller.getAllLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.cohorts.isEmpty
                            ? Center(
                                child: Text(
                                  "Please Add Cohorts",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.bgSideMenu,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : SearchableList<CohortResModel>(
                                initialList: controller.cohorts,
                                emptyWidget: Center(
                                  child: Text(
                                    "No data found",
                                    style: nunitoBold.copyWith(
                                      color: ColorManager.bgSideMenu,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                filter: (value) => controller.cohorts
                                    .where((element) => element.name!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList(),
                                itemBuilder: (CohortResModel item) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 50,
                                          ),
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
                                                  offset: const Offset(
                                                    2,
                                                    15,
                                                  ), // changes position of shadow
                                                ),
                                              ],
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                11,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name ?? "no name",
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                      fontSize: 35,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Text(
                                                  //     controller
                                                  //         .selectedSchool
                                                  //         .name,
                                                  //     style:                                                       .nunitoReguler
                                                  //         .copyWith(
                                                  //             color: ColorManager
                                                  //                 .bgSideMenu,
                                                  //             fontSize:
                                                  //                 20)),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .6,
                                                    height: 50,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: item
                                                          .cohortsSubjects!
                                                          .cohortHasSubjects!
                                                          .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            item
                                                                .cohortsSubjects!
                                                                .cohortHasSubjects![
                                                                    i]
                                                                .subjects!
                                                                .name!,
                                                            style: nunitoRegular
                                                                .copyWith(
                                                                    color: ColorManager
                                                                        .bgSideMenu,
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      // InkWell(
                                                      //   onTap: () {
                                                      //     SubjectsControllers
                                                      //         subjCont =
                                                      //         Get.find();

                                                      //     MyDialogs
                                                      //         .showAddDialog(
                                                      //             context,
                                                      //             Column(
                                                      //               mainAxisSize:
                                                      //                   MainAxisSize.min,
                                                      //               children: [
                                                      //                 Text(controller
                                                      //                     .cohorts[index]
                                                      //                     .name),
                                                      //                 const Divider(),
                                                      //                 DropdownSearch<
                                                      //                     SubjectResponse>.multiSelection(
                                                      //                   popupProps:
                                                      //                       PopupPropsMultiSelection.menu(
                                                      //                     searchFieldProps: TextFieldProps(decoration: InputDecoration(hintText: "search", hintStyle: nunitoReguler.copyWith(color: Colors.black, fontSize: 16), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.black), borderRadius: BorderRadius.circular(10)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.black), borderRadius: BorderRadius.circular(10),),), cursorColor: ColorManager.black,),
                                                      //                     showSearchBox: true,
                                                      //                   ),
                                                      //                   selectedItems:
                                                      //                       subjCont.subjectsController,
                                                      //                   items:
                                                      //                       subjCont.subjects,
                                                      //                   itemAsString: (item) =>
                                                      //                       item.name,
                                                      //                   dropdownDecoratorProps:
                                                      //                       DropDownDecoratorProps(
                                                      //                     dropdownSearchDecoration: InputDecoration(focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.glodenColor), borderRadius: BorderRadius.circular(10)), border: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.glodenColor), borderRadius: BorderRadius.circular(10)), hintText: "Select Subject", hintStyle: nunitoReguler.copyWith(fontSize: 16, color: ColorManager.black),),
                                                      //                   ),
                                                      //                   onChanged:
                                                      //                       ((value) {
                                                      //                     subjCont.subjectsController.value = value;
                                                      //                     if (kDebugMode) {
                                                      //                       print(subjCont.subjectsController);
                                                      //                     }
                                                      //                   }),
                                                      //                 ),
                                                      //                 const SizedBox(
                                                      //                   height:
                                                      //                       20,
                                                      //                 ),
                                                      //                 InkWell(
                                                      //                   onTap:
                                                      //                       () async {
                                                      //                     subjCont.addLoading.value = true;

                                                      //                     // await controller.addNewsubjectToCohort(subjCont.subjectsController, controller.cohorts[index].id);
                                                      //                     subjCont.subjectsController.clear();
                                                      //                     subjCont.addLoading.value = false;
                                                      //                     // ignore: use_build_context_synchronously
                                                      //                     Navigator.pop(context);
                                                      //                   },
                                                      //                   child: subjCont.addLoading.value == true
                                                      //                       ? const Center(
                                                      //                           child: CircularProgressIndicator(),
                                                      //                         )
                                                      //                       : Container(
                                                      //                           height: 50,
                                                      //                           width: double.infinity,
                                                      //                           decoration: BoxDecoration(color: ColorManager.bgSideMenu, borderRadius: BorderRadius.circular(10),),
                                                      //                           child: Center(
                                                      //                               child: Text(
                                                      //                             "Add Subjects",
                                                      //                             style: nunitoRegular.copyWith(color: Colors.white),
                                                      //                           ),),
                                                      //                         ),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       300,
                                                      //                   width:
                                                      //                       200,
                                                      //                   child:
                                                      //                       ListView.builder(
                                                      //                     itemCount: controller.cohorts[index].subjects!.length,
                                                      //                     itemBuilder: (context, i) {
                                                      //                       return Padding(
                                                      //                         padding: const EdgeInsets.symmetric(vertical: 10),
                                                      //                         child: Row(
                                                      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      //                           children: [
                                                      //                             Text(controller.cohorts[index].subjects![i].name),
                                                      //                             IconButton(
                                                      //                                 onPressed: () {
                                                      //                                   //delete supject from cohort
                                                      //                                   controller.deleteubjectFromCohort(controller.cohorts[index].subjects![i].id, controller.cohorts[index].id);
                                                      //                                   Navigator.pop(context);
                                                      //                                 },
                                                      //                                 icon: const Icon(Icons.delete))
                                                      //                           ],
                                                      //                         ),
                                                      //                       );
                                                      //                     },
                                                      //                   ),
                                                      //                 ),
                                                      //                 InkWell(
                                                      //                   onTap:
                                                      //                       () {
                                                      //                     Get.back();
                                                      //                   },
                                                      //                   child:
                                                      //                       Container(
                                                      //                     width: double.infinity,
                                                      //                     height: 45,
                                                      //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorManager.bgSideMenu),
                                                      //                     child: Center(
                                                      //                       child: Text(
                                                      //                         "Back",
                                                      //                         style: nunitoRegular.copyWith(color: Colors.white, fontSize: 18),
                                                      //                       ),
                                                      //                     ),
                                                      //                   ),
                                                      //                 ),
                                                      //               ],
                                                      //             ),);
                                                      //   },
                                                      //   child: Container(
                                                      //     decoration: BoxDecoration(
                                                      //         color: ColorManager
                                                      //             .glodenColor,
                                                      //         borderRadius:
                                                      //             BorderRadius
                                                      //                 .circular(
                                                      //                     10,),),
                                                      //     child: Center(
                                                      //       child: Padding(
                                                      //         padding:
                                                      //             const EdgeInsets
                                                      //                 .all(
                                                      //                 10),
                                                      //         child: Text(
                                                      //             "Add subjects",
                                                      //             style:                                                                   nunitoBold
                                                      //                 .copyWith(
                                                      //               color: ColorManager
                                                      //                   .white,
                                                      //               fontSize:
                                                      //                   16,
                                                      //             ),),
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          MyAwesomeDialogue(
                                                            title:
                                                                'You are bout to delete this cohort',
                                                            desc:
                                                                'Are you sure ?',
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            btnOkOnPressed: () {
                                                              controller
                                                                  .deleteCohort(
                                                                      item.iD!)
                                                                  .then(
                                                                (value) {
                                                                  value
                                                                      ? MyFlashBar.showSuccess(
                                                                              'Cohort deleted successfully',
                                                                              'Success')
                                                                          .show(
                                                                              context)
                                                                      : null;
                                                                },
                                                              );
                                                            },
                                                            btnCancelOnPressed:
                                                                () {
                                                              Get.back();
                                                            },
                                                          ).showDialogue(
                                                              context);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                "Delete Cohort",
                                                                style: nunitoBold
                                                                    .copyWith(
                                                                  color:
                                                                      ColorManager
                                                                          .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
