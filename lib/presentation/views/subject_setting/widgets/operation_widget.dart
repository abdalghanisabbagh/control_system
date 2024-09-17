import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../../Data/Models/subject/subject_res_model.dart';
import '../../../../domain/controllers/controllers.dart';
import '../../../../domain/controllers/subject/operation_controoler.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import 'edit_operation_widget.dart';

class OperationWidget extends GetView<OperationController> {
  const OperationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: GetBuilder<OperationController>(
            builder: (controller) => controller.getAllLoading
                ? Center(
                    child: LoadingIndicators.getLoadingIndicator(),
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
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: RepaintBoundary(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyBackButton(
                                  onPressed: () {},
                                ),
                                const SizedBox(height: 20),
                                controller.getAllLoading
                                    ? Center(
                                        child: LoadingIndicators
                                            .getLoadingIndicator(),
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
                                        : Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  100,
                                              child: SearchableList<
                                                  SubjectResModel>(
                                                inputDecoration:
                                                    const InputDecoration(
                                                  label: Text(
                                                    'Search by name',
                                                  ),
                                                ),
                                                initialList:
                                                    controller.subjects,
                                                emptyWidget: Center(
                                                  child: Text(
                                                    "No data found",
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager
                                                          .bgSideMenu,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                filter: (value) => controller
                                                    .subjects
                                                    .where((element) => element
                                                        .name!
                                                        .toLowerCase()
                                                        .contains(value
                                                            .toLowerCase()))
                                                    .toList(),
                                                itemBuilder:
                                                    (SubjectResModel item) {
                                                  var schoolTypes = item
                                                      .schoolTypeHasSubjectsResModel!
                                                      .schooltypeHasSubjects!
                                                      .map((e) =>
                                                          e.schoolType!.name)
                                                      .join(', ');

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 10,
                                                          ),
                                                          child: Container(
                                                            height: 240,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      5,
                                                                  blurRadius:
                                                                      20,
                                                                  offset:
                                                                      const Offset(
                                                                    2,
                                                                    15,
                                                                  ),
                                                                ),
                                                              ],
                                                              color: ColorManager
                                                                  .ligthBlue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 25,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15.0),
                                                                  child: Text(
                                                                    item.name ??
                                                                        "Subject Name",
                                                                    style: nunitoBold
                                                                        .copyWith(
                                                                      color: ColorManager
                                                                          .bgSideMenu,
                                                                      fontSize:
                                                                          35,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15.0),
                                                                  child: Text(
                                                                    'School type ($schoolTypes)',
                                                                    style: nunitoRegular
                                                                        .copyWith(
                                                                      color: ColorManager
                                                                          .bgSideMenu,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "In Exam ",
                                                                        style: nunitoRegular
                                                                            .copyWith(
                                                                          color:
                                                                              ColorManager.bgSideMenu,
                                                                          fontSize:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                      Switch(
                                                                        activeColor:
                                                                            ColorManager.bgSideMenu,
                                                                        value: item.inExam ==
                                                                                1
                                                                            ? true
                                                                            : false,
                                                                        onChanged:
                                                                            (value) {},
                                                                      ),
                                                                      SizedBox(
                                                                        width: Get.width *
                                                                            0.1,
                                                                      ),
                                                                      Text(
                                                                        "Active ",
                                                                        style: nunitoRegular
                                                                            .copyWith(
                                                                          color:
                                                                              ColorManager.bgSideMenu,
                                                                          fontSize:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                      Switch(
                                                                        activeColor:
                                                                            ColorManager.bgSideMenu,
                                                                        value: item.active ==
                                                                                1
                                                                            ? true
                                                                            : false,
                                                                        onChanged:
                                                                            (value) {},
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      child: GetBuilder<
                                                                              SubjectsController>(
                                                                          builder:
                                                                              (subjectsController) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            MyAwesomeDialogue(
                                                                              title: 'You are about to delete this subject',
                                                                              desc: 'Are you sure?',
                                                                              dialogType: DialogType.warning,
                                                                              btnOkOnPressed: () async {
                                                                                await subjectsController.deleteSubject(id: item.iD!).then(
                                                                                  (value) {
                                                                                    value
                                                                                        ? {
                                                                                            MyFlashBar.showSuccess(
                                                                                              "Subject has been deleted successfully",
                                                                                              "Subject Deleted",
                                                                                            ).show(context.mounted ? context : Get.key.currentContext!),
                                                                                          }
                                                                                        : null;
                                                                                    controller.onInit();
                                                                                  },
                                                                                );
                                                                              },
                                                                              btnCancelOnPressed: () {
                                                                                Get.back();
                                                                              },
                                                                            ).showDialogue(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                150,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.red,
                                                                              borderRadius: BorderRadius.horizontal(left: Radius.circular(11)),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "Delete Subject",
                                                                                style: nunitoBold.copyWith(
                                                                                  color: ColorManager.white,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          MyDialogs
                                                                              .showDialog(
                                                                            context,
                                                                            EditOperationWidget(
                                                                              subjectResModel: item,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              150,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                ColorManager.glodenColor,
                                                                            borderRadius:
                                                                                BorderRadius.horizontal(right: Radius.circular(11)),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "Edit Subject",
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
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 100,
                                                          bottom: 80,
                                                          child: Image.asset(
                                                            AssetsManager
                                                                .assetsIconsArabic,
                                                            fit: BoxFit.fill,
                                                            height: 150,
                                                            width: 150,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                              ]),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
