import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/constants/app_constatnts.dart';
import 'assign_proctor_to_exam_by_room_id.dart';
import 'edit_proctor_widget.dart';
import 'exam_rooms_assigned_to_proctor.dart';

class ProctorsWidget extends GetView<ProctorController> {
  const ProctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProctorController>(
      id: 'proctors',
      builder: (controller) {
        return RepaintBoundary(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.proctors.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  if (controller.selectedProctor?.iD ==
                      controller.proctors[index].iD) {
                    controller.selectedProctor = null;
                    controller.update(['proctors']);
                  } else {
                    controller.selectedProctor = controller.proctors[index];
                    controller.update(['proctors']);
                    if (controller.canAssignProctorToExamRoom()) {
                      MyDialogs.showDialog(
                        context,
                        const AssignProctorToExamMission(),
                      );
                    }
                  }
                },
                onLongPress: () {
                  MyDialogs.showDialog(
                    context,
                    EditProctorWidget(
                      proctor: controller.proctors[index],
                    ),
                  );
                },
                onDoubleTap: () {
                  controller.getExamRoomsByProctorId(
                      proctorId: controller.proctors[index].iD!);
                  MyDialogs.showDialog(
                    context,
                    ExamRoomsAssignedToProctorWidget(
                      proctorName: controller.proctors[index].userName!,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    duration: AppConstants.mediumDuration,
                    decoration: BoxDecoration(
                      color: controller.selectedProctor?.iD ==
                              controller.proctors[index].iD
                          ? ColorManager.primary
                          : ColorManager.ligthBlue,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${index + 1} - ${controller.proctors[index].userName}',
                        style: nunitoBold.copyWith(
                          color: controller.selectedProctor?.iD ==
                                  controller.proctors[index].iD
                              ? ColorManager.white
                              : ColorManager.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
