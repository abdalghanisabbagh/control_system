import 'package:control_system/presentation/resource_manager/ReusableWidget/loading_indicators.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/styles_manager.dart';

class AssignProctorToExamMission extends GetView<ProctorController> {
  const AssignProctorToExamMission({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProctorController>(
      id: 'assignProctorToExamRoom',
      builder: (controller) {
        return DefaultTextStyle(
          style: nunitoBold.copyWith(
            color: Colors.black,
            fontSize: AppSize.s16,
          ),
          child: SizedBox(
            height: 500,
            width: 600,
            child: controller.isLoading
                ? Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(
                                flex: 5,
                              ),
                              Text(
                                'Proctor ${controller.selectedProctor!.fullName}',
                                style: nunitoBold,
                              ),
                              const Spacer(
                                flex: 4,
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ],
                          ),
                          //     if (morningExams.isNotEmpty)
                          //       Column(
                          //         children: [
                          //           Row(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             mainAxisSize: MainAxisSize.max,
                          //             children: [
                          //               Text(
                          //                 "Session One Exams",
                          //                 style: nunitoBlack.copyWith(
                          //                   fontSize: 24,
                          //                   color: Colors.orange,
                          //                 ),
                          //               ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session One Exam",
                                style: nunitoBlack.copyWith(
                                  fontSize: 24,
                                  color: Colors.orange,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          ListBody(
                            mainAxis: Axis.vertical,
                            children: controller
                                .selectedExamRoom!
                                .controlMissionResModel!
                                .examMissionsResModel!
                                .data!
                                .where((exam) => exam.period!)
                                .map(
                                  (exam) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${exam.subjectResModel?.name} ',
                                              ),
                                              TextSpan(
                                                text:
                                                    ' (${exam.gradeResModel?.name})',
                                                style: nunitoBold.copyWith(
                                                  color: ColorManager
                                                          .gradesColor[
                                                      exam.gradeResModel?.name],
                                                  fontSize: AppSize.s16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (exam.startTime != null)
                                          Text(
                                            DateFormat('yy/MM/dd (HH:mm)')
                                                .format(
                                              DateTime.parse(exam.startTime!),
                                            ),
                                          ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            controller
                                                .assignProctorToExamRoom(
                                                    examMission: exam)
                                                .then(
                                                  (value) => value
                                                      ? {
                                                          Get.back(),
                                                          MyFlashBar.showSuccess(
                                                                  'proctor is assigned successfully',
                                                                  'Success')
                                                              .show(context),
                                                        }
                                                      : null,
                                                );
                                          },
                                          child:
                                              const Text('assign to proctor'),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          //             ],
                          //           ),
                          //           ListView.builder(
                          //             shrinkWrap: true,
                          //             itemCount: 0,
                          //             itemBuilder: (context, index) {
                          //               return Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Row(
                          //                   mainAxisSize: MainAxisSize.max,
                          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     if (exam.subjects != null)
                          //                       Text(
                          //                           "${exam.subjects!.name} (${exam.grades != null ? exam.grades!.name : ''})"),
                          //                     if (exam.starttime != null)
                          //                       Text(
                          //                         DateFormat('yy/MM/dd (HH:mm)').format(
                          //                           DateTime.parse(exam.starttime!),
                          //                         ),
                          //                       ),
                          //                   ],
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          //     if (nightExams.isNotEmpty)
                          //       Column(
                          //         children: [
                          //           Row(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             mainAxisSize: MainAxisSize.max,
                          //             children: [
                          //               Text(
                          //                 "Session Two Exams",
                          //                 style: nunitoBlack.copyWith(
                          //                     fontSize: 24, color: Colors.orange),
                          //               ),
                          //               ElevatedButton(
                          //                 onPressed: () async {},
                          //                 child: const Text('assign to proctor'),
                          //               ),
                          //             ],
                          //           ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Session Two Exams",
                                style: nunitoBlack.copyWith(
                                  fontSize: 24,
                                  color: Colors.orange,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),

                          //           ListView.builder(
                          //             shrinkWrap: true,
                          //             itemCount: 0,
                          //             itemBuilder: (context, index) {
                          //               return Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Row(
                          //                   mainAxisSize: MainAxisSize.max,
                          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     if (exam.subjects != null)
                          //                       Text(
                          //                           "${exam.subjects!.name} (${exam.grades != null ? exam.grades!.name : ''})"),
                          //                     if (exam.starttime != null)
                          //                       Text(
                          //                         DateFormat('yy/MM/dd (HH:mm)').format(
                          //                           DateTime.parse(exam.starttime!),
                          //                         ),
                          //                       ),
                          //                   ],
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          ListBody(
                            mainAxis: Axis.vertical,
                            children: controller
                                .selectedExamRoom!
                                .controlMissionResModel!
                                .examMissionsResModel!
                                .data!
                                .where((exam) => !exam.period!)
                                .map(
                                  (exam) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '',
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${exam.subjectResModel?.name} ',
                                              ),
                                              TextSpan(
                                                text:
                                                    ' (${exam.gradeResModel?.name})',
                                                style: TextStyle(
                                                  color: ColorManager
                                                          .gradesColor[
                                                      exam.gradeResModel!.name],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (exam.startTime != null)
                                          Text(
                                            DateFormat('yy/MM/dd (HH:mm)')
                                                .format(
                                              DateTime.parse(exam.startTime!),
                                            ),
                                          ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            controller.assignProctorToExamRoom(
                                                examMission: exam);
                                          },
                                          child:
                                              const Text('assign to proctor'),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
