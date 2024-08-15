import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../../Data/Models/school/grade_response/grade_res_model.dart';
import '../../../../domain/controllers/batch_documents.dart/cover_sheets_controller.dart';
import '../../../../domain/controllers/batch_documents.dart/seat_number_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';

// ignore: must_be_immutable
class SeatNumberWidget extends GetView<SeatNumberController> {
  final ControlMissionResModel controlMissionObject;
  final int id;
  final GradeResModel gradeObject;
  const SeatNumberWidget({
    super.key,
    required this.gradeObject,
    required this.controlMissionObject,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
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
                      "Control Mission Name: ${controlMissionObject.name}",
                      style: const TextStyle(
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    GetBuilder<CoversSheetsController>(
                        builder: (coversSheetsController) {
                      return IconButton(
                        onPressed: () {
                          MyAwesomeDialogue(
                            title: 'Delete Exam Cover Sheet',
                            desc:
                                'Are you sure you want to delete this mission?',
                            dialogType: DialogType.warning,
                            btnCancelOnPressed: () {},
                            btnOkOnPressed: () {
                              coversSheetsController
                                  .deleteExamMission(id: gradeObject.iD!)
                                  .then((value) {
                                if (value) {
                                  MyFlashBar.showSuccess(
                                    'Success',
                                    'Students have been distributed successfully',
                                  ).show(context.mounted
                                      ? context
                                      : Get.key.currentContext!);
                                }
                              });
                            },
                          ).showDialogue(context);
                        },
                        icon: const CircleAvatar(
                          backgroundColor: ColorManager.red,
                          child: Icon(
                            Icons.delete_forever,
                            color: ColorManager.white,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Text(
                  "Grade: ${gradeObject.name}",
                  style: const TextStyle(
                    color: ColorManager.primary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<SeatNumberController>(
            id: id,
            builder: (_) {
              if (controller.isLoadingGeneratePdf) {
                return Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: FittedBox(
                      child: LoadingIndicators.getLoadingIndicator(),
                    ),
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  controller.generatePdfSeatNumber(
                      gradeId: gradeObject.iD!,
                      controlMissionName: controlMissionObject.name!,
                      controlMissionId: controlMissionObject.iD!);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: ColorManager.bgSideMenu,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Generate Pdf"),
                      SizedBox(width: 20),
                      Icon(Icons.print, color: ColorManager.white),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
