import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/constants/app_constants.dart';
import 'assign_proctor_to_exam_by_room_id.dart';
import 'proctors_in_exam_room_widget.dart';

class ExamRoomsWidget extends GetView<ProctorController> {
  const ExamRoomsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProctorController>(
      id: 'examRooms',
      builder: (_) => controller.examRoomsAreLoading
          ? Center(
              child: LoadingIndicators.getLoadingIndicator(),
            )
          : controller.examRooms.isEmpty
              ? controller.selectedEducationYearId != null &&
                      controller.selectedControlMissionsId != null &&
                      controller.selectedDate != null
                  ? Center(
                      child: Text(
                        'No Exam Rooms Available. Please Create At Least One Exam Room',
                        style: nunitoBold.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
              : RepaintBoundary(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(right: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2,
                    ),
                    itemCount: controller.examRooms.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          if (controller.selectedExamRoom?.id ==
                              controller.examRooms[index].id) {
                            controller.selectedExamRoom = null;
                            controller.update(['examRooms']);
                          } else {
                            controller.selectedExamRoom =
                                controller.examRooms[index];
                            controller.update(['examRooms']);
                            if (controller.canAssignProctorToExamRoom()) {
                              MyDialogs.showDialog(
                                context,
                                const AssignProctorToExamMission(),
                              );
                            }
                          }
                        },
                        onDoubleTap: () {
                          controller.getProctorsByExamRoomId(
                              examRoomId: controller.examRooms[index].id!);
                          MyDialogs.showDialog(
                            context,
                            ProctorsInExamRoomWidget(
                              examRoomName: controller.examRooms[index].name!,
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: AppConstants.mediumDuration,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: controller.selectedExamRoom?.id ==
                                    controller.examRooms[index].id
                                ? ColorManager.primary
                                : Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: DefaultTextStyle(
                            overflow: TextOverflow.ellipsis,
                            style: nunitoRegular.copyWith(
                              fontSize: 14,
                              color: controller.selectedExamRoom?.id ==
                                      controller.examRooms[index].id
                                  ? ColorManager.white
                                  : ColorManager.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                      '${controller.examRooms[index].name}'),
                                ),
                                Expanded(
                                  child: Text(
                                    '${controller.examRooms[index].stage}',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
