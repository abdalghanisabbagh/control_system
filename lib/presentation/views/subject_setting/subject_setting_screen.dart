import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/presentation/views/subject_setting/widgets/edit_Subjects_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../Data/Models/subject/subject_res_model.dart';
import '../../../domain/controllers/profile_controller.dart';
import '../../../domain/controllers/subject/subject_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/assets_manager.dart';
import '../../resource_manager/index.dart';
import '../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../base_screen.dart';
import "widgets/add_subject_widget.dart";

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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Subject",
                      style: nunitoBlack.copyWith(
                        color: ColorManager.bgSideMenu,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.6,
                    ),
                    InkWell(
                      onTap: () {
                        context.goNamed(
                            AppRoutesNamesAndPaths.oprerationsScreenName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.bgSideMenu,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              " Operation ",
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Visibility(
                      visible: Get.find<ProfileController>().canAccessWidget(
                        widgetId: '7100',
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: "Add New Subject",
                            titleStyle: nunitoRegular.copyWith(
                              color: ColorManager.bgSideMenu,
                              fontSize: 25,
                            ),
                            content: AddSubjectWidget(),
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
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: controller.getAllLoading
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
                                var schoolTypes = item
                                    .schoolTypeHasSubjectsResModel!
                                    .schooltypeHasSubjects!
                                    .map((e) => e.schoolType!.name)
                                    .join(', ');

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
                                                  height: 8,
                                                ),
                                                Text(
                                                  'School type ($schoolTypes)',
                                                  style: nunitoRegular.copyWith(
                                                    color:
                                                        ColorManager.bgSideMenu,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
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
                                                          } else {
                                                            inExam = true;
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
                                                Row(
                                                  children: [
                                                    Visibility(
                                                      visible: Get.find<
                                                              ProfileController>()
                                                          .canAccessWidget(
                                                        widgetId: '7200',
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          MyAwesomeDialogue(
                                                            title:
                                                                'You are about to delete this subject',
                                                            desc:
                                                                'Are you sure?',
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
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
                                                            btnCancelOnPressed:
                                                                () {
                                                              Get.back();
                                                            },
                                                          ).showDialogue(
                                                              context);
                                                        },
                                                        child: Container(
                                                          width: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Visibility(
                                                      visible: Get.find<
                                                              ProfileController>()
                                                          .canAccessWidget(
                                                        widgetId: '7300',
                                                      ),
                                                      child: SizedBox(
                                                        width: 150,
                                                        height: 43,
                                                        child:
                                                            ElevatedEditButton(
                                                          onPressed: () =>
                                                              MyDialogs
                                                                  .showDialog(
                                                            context,
                                                            EditSubject(
                                                              subjectResModel:
                                                                  item,
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
                                      ),
                                      Positioned(
                                        right: 100,
                                        bottom: 100,
                                        child: Image.asset(
                                          AssetsManager.assetsIconsArabic,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
