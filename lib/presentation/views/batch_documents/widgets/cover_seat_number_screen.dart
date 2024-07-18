import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/Data/Models/control_mission/control_mission_res_model.dart';
import 'package:control_system/Data/Models/exam_mission/exam_mission_res_model.dart';
import 'package:control_system/domain/controllers/batch_documents.dart/cover_sheets_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/styles_manager.dart';

// ignore: must_be_immutable
class CoverSeatNumberWidget extends GetView<CoversSheetsController> {
  ExamMissionResModel examMissionObject;
  ControlMissionResModel controlMissionObject;
  CoverSeatNumberWidget({
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
                      style: nunitoRegularStyle()
                          .copyWith(color: ColorManager.primary, fontSize: 30),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        MyAwesomeDialogue(
                          title: 'Delete Exam Cover Sheet',
                          desc: 'Are you sure you want to delete this mission?',
                          dialogType: DialogType.warning,
                          btnCancelOnPressed: () {},
                          btnOkOnPressed: () {
                            controller
                                .deleteExamMission(id: examMissionObject.iD!)
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
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
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
                    "Generate Pdf",
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
          )
        ],
      ),
    );
  }
}
