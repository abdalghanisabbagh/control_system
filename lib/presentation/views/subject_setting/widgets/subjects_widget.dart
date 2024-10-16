import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../../Data/Models/subject/subject_res_model.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../../domain/controllers/subject/subject_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';
import 'edit_subjects_widget.dart';

class SubjectsWidget extends GetView<SubjectsController> {
  const SubjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectsController>(
      builder: (_) => controller.getAllLoading
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
                  secondaryWidget: PopupMenuButton(
                    tooltip: "Sort",
                    icon: const Icon(Icons.sort),
                    itemBuilder: (_) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            controller.sortSubjectsByName(asc: true);
                          },
                          value: "Sort by name asc",
                          child: const Text("Sort by name asc"),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            controller.sortSubjectsByName(asc: false);
                          },
                          value: "Sort by name desc",
                          child: const Text("Sort by name desc"),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            controller.sortSubjectsByCreationTime(asc: true);
                          },
                          value: "Sort by creation time asc",
                          child: const Text("Sort by creation time asc"),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            controller.sortSubjectsByCreationTime(asc: false);
                          },
                          value: "Sort by creation time desc",
                          child: const Text("Sort by creation time desc"),
                        ),
                      ];
                    },
                  ).paddingSymmetric(horizontal: 20),
                  inputDecoration: const InputDecoration(
                    label: Text(
                      'Search by name',
                    ),
                  ),
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
                    //  bool inExam = true;
                    var schoolTypes = item
                        .schoolTypeHasSubjectsResModel!.schooltypeHasSubjects!
                        .map((e) => e.schoolType!.name)
                        .join(', ');

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 20,
                                    offset: const Offset(2, 15),
                                  ),
                                ],
                                color: ColorManager.ligthBlue,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name ?? "Subject Name",
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 35,
                                      ),
                                    ),
                                    Text(
                                      'School type ($schoolTypes)',
                                      style: nunitoRegular.copyWith(
                                        color: ColorManager.bgSideMenu,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "In Exam",
                                          style: nunitoRegular.copyWith(
                                            color: ColorManager.bgSideMenu,
                                            fontSize: 20,
                                          ),
                                        ),
                                        item.inExam == 1
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: ColorManager.green,
                                                  size: 25,
                                                ),
                                              )
                                            : const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: ColorManager.red,
                                                  size: 25,
                                                ),
                                              )
                                        // GetBuilder<SubjectsController>(
                                        //   builder: (subjectsControllers) =>
                                        //       Switch(
                                        //     activeColor:
                                        //         ColorManager.bgSideMenu,
                                        //     value: inExam,
                                        //     onChanged: (value) {
                                        //       inExam = value;
                                        //       subjectsControllers.update();
                                        //     },
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: Get.find<ProfileController>()
                                              .canAccessWidget(
                                            widgetId: '7200',
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              MyAwesomeDialogue(
                                                title:
                                                    'You are about to delete this subject',
                                                desc: 'Are you sure?',
                                                dialogType: DialogType.warning,
                                                btnOkOnPressed: () async {
                                                  await controller
                                                      .deleteSubject(
                                                    id: item.iD!,
                                                  )
                                                      .then(
                                                    (value) {
                                                      if (value) {
                                                        MyFlashBar.showSuccess(
                                                          "Subject has been deleted successfully",
                                                          "Subject Deleted",
                                                        ).show(context.mounted
                                                            ? context
                                                            : Get.key
                                                                .currentContext!);
                                                      }
                                                    },
                                                  );
                                                },
                                                btnCancelOnPressed: () {},
                                              ).showDialogue(context);
                                            },
                                            child: Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Delete Subject",
                                                  style: nunitoBold.copyWith(
                                                    color: ColorManager.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Visibility(
                                          visible: Get.find<ProfileController>()
                                              .canAccessWidget(
                                            widgetId: '7300',
                                          ),
                                          child: SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: ElevatedEditButton(
                                              onPressed: () =>
                                                  MyDialogs.showDialog(
                                                context,
                                                EditSubject(
                                                  subjectResModel: item,
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
                            right: MediaQuery.of(context).size.width * 0.02,
                            bottom: 60,
                            child: Image.asset(
                              AssetsManager.assetsIconsArabic,
                              fit: BoxFit.fill,
                              height: 125,
                              width: 125,
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
