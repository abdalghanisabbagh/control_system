import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/control_mission/control_mission_model.dart';
import 'package:control_system/Data/Models/exam_mission/exam_mission_res_model.dart';
import 'package:control_system/domain/controllers/batch_documents.dart/cover_shetts_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/views/batch_documents/widgets/add_new_cover_widget.dart';
import 'package:control_system/presentation/views/batch_documents/widgets/edit_cover_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/styles_manager.dart';

// ignore: must_be_immutable
class CoverWidget extends GetView<CoversSheetsController> {
  ExamMissionResModel examMissionObject;
  ControlMissionResModel controlMissionObject;
  CoverWidget({
    super.key,
    required this.examMissionObject,
    required this.controlMissionObject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            borderRadius: BorderRadius.circular(11)),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Mission name:${controlMissionObject.name}",
                        style: nunitoRegularStyle().copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          MyDialogs.showDialog(context, EditCoverWidget());
                        },
                        icon: CircleAvatar(
                          backgroundColor: ColorManager.primary,
                          child: Icon(Icons.edit, color: ColorManager.white),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      IconButton(
                          onPressed: () {
                            MyAwesomeDialogue(
                              title: 'Delete Exam Cover Sheet',
                              desc:
                                  'Are you sure you want to delete this mission?',
                              dialogType: DialogType.warning,
                              btnCancelOnPressed: () {},
                              btnOkOnPressed: () {
                                controller
                                    .deleteExamMission(
                                        id: examMissionObject.iD!)
                                    .then((value) {
                                  if (value) {
                                    MyFlashBar.showSuccess(
                                      'Success',
                                      'Students have been distributed successfully',
                                    ).show(context);
                                  }
                                });
                              },
                            ).showDialogue(context);
                          },
                          icon: CircleAvatar(
                              backgroundColor: ColorManager.red,
                              child: Icon(
                                Icons.delete_forever,
                                color: ColorManager.white,
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Exam Date : ${examMissionObject.startTime != null ? DateFormat('yyyy,MM,dd (HH:mm)').format(DateTime.parse(examMissionObject.startTime!)) : examMissionObject.month}  ( ${examMissionObject.period == 0 ? 'Session One Exams' : 'Session Two Exams'} )",
                        style: nunitoRegularStyle().copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.2,
                      ),
                      Text(
                        "Grade : ${examMissionObject.gradeResModel!.name}",
                        style: nunitoRegularStyle().copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Subject name : ${examMissionObject.subjectResModel!.name}",
                        style: nunitoRegularStyle().copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                      ),
                      Text("Exam Duration :${examMissionObject.duration} min",
                          style: nunitoRegularStyle().copyWith(
                            color: ColorManager.primary,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                controller.schoolTypeId == 1
                    ? Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: ColorManager.bgSideMenu,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "American Cover Sheet",
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.print,
                                  color: ColorManager.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                controller.schoolTypeId == 2
                    ? Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.lightBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "IB Cover Sheet",
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.print,
                                  color: ColorManager.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                controller.schoolTypeId == 5
                    ? Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                content: Column(
                              children: [
                                const Text("What do you want to print?"),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("WA Cover")),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("Exam Cover")),
                                  ],
                                ),
                              ],
                            ));
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: ColorManager.red,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "British Cover Sheet",
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.print,
                                  color: ColorManager.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ));
  }
}
