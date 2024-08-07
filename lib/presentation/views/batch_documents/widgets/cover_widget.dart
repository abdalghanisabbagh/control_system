import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../../Data/Models/exam_mission/exam_mission_res_model.dart';
import '../../../../domain/controllers/batch_documents.dart/cover_sheets_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import 'edit_cover_widget.dart';
import 'officer_edit_cover_widget.dart';

// ignore: must_be_immutable
class CoverWidget extends GetView<CoversSheetsController> {
  ControlMissionResModel controlMissionObject;

  ExamMissionResModel examMissionObject;
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
                        style: nunitoBoldStyle().copyWith(
                          color: ColorManager.primary,
                          fontSize: 25,
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: examMissionObject.pdf != null,
                        child: IconButton(
                          onPressed: () {
                            controller.previewExamMission(
                                examMissionId: examMissionObject.iD!);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ColorManager.glodenColor,
                            child: Icon(Icons.picture_as_pdf_rounded,
                                color: ColorManager.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          MyDialogs.showDialog(
                              context,
                              EditCoverWidget(
                                examMissionObject: examMissionObject,
                                controlMissionObject: controlMissionObject,
                              ));
                        },
                        icon: CircleAvatar(
                          backgroundColor: ColorManager.primary,
                          child: Icon(Icons.edit, color: ColorManager.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          MyDialogs.showDialog(
                              context,
                              OfficerEditCoverWidget(
                                examMissionObject: examMissionObject,
                                controlMissionObject: controlMissionObject,
                              ));
                        },
                        icon: CircleAvatar(
                          backgroundColor: ColorManager.primary,
                          child: Icon(Icons.edit, color: ColorManager.white),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
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
                        "Exam Date : ${examMissionObject.startTime != null ? DateFormat('yyyy,MM,dd (HH:mm)').format(DateTime.parse(examMissionObject.startTime!)) : "${examMissionObject.month} "}  ( ${examMissionObject.period! ? 'Session One Exams' : 'Session Two Exams'} )",
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
                        width: Get.width * 0.35,
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
                    ? controller.isLoadingGeneratePdf
                        ? Expanded(
                            child: Center(
                              child: SizedBox(
                                height: 50,
                                child: FittedBox(
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.generateAmCoverSheet(
                                  examMissionId: examMissionObject.iD!,
                                  controlMissionName:
                                      controlMissionObject.name!,
                                );
                              },
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
                    ? controller.isLoadingGeneratePdf
                        ? Expanded(
                            child: Center(
                              child: SizedBox(
                                height: 50,
                                child: FittedBox(
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.generateBrCoverSheet(
                                  examMissionId: examMissionObject.iD!,
                                  controlMissionName:
                                      controlMissionObject.name!,
                                );
                              },
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
                    ? controller.isLoadingGeneratePdf
                        ? Expanded(
                            child: Center(
                              child: SizedBox(
                                height: 50,
                                child: FittedBox(
                                  child:
                                      LoadingIndicators.getLoadingIndicator(),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.generateIBCoverSheet(
                                  examMissionId: examMissionObject.iD!,
                                  controlMissionName:
                                      controlMissionObject.name!,
                                );
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
