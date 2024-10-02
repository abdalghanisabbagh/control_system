import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/student_seat/student_seat_res_model.dart';
import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';

class AvailableStudents extends GetView<DistributeStudentsController> {
  const AvailableStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistributeStudentsController>(
      builder: (_) {
        return SizedBox(
          height: Get.height * 0.63,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                controller.availableStudents.length,
                (i) {
                  Widget child = Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    height: Get.height * 0.13,
                    width: Get.width * 0.2,
                    decoration: BoxDecoration(
                      color: ColorManager.gradesColor[controller
                          .availableStudents[i].student!.gradeResModel!.name!],
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student Name: ${controller.availableStudents[i].student?.firstName!} ${controller.availableStudents[i].student?.secondName!} ${controller.availableStudents[i].student?.thirdName!} ',
                          style: nunitoBold.copyWith(
                            fontSize: 15,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          'Seat NO: ${controller.availableStudents[i].seatNumber}',
                          style: nunitoBold.copyWith(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Grade/Class : ${controller.availableStudents[i].student?.gradeResModel?.name}/${controller.availableStudents[i].student?.classRoomResModel?.name}',
                          style: nunitoBold.copyWith(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Desk NO : ${controller.classDesks.indexWhere((element) => element.id == controller.availableStudents[i].classDeskID) + 1}',
                          style: nunitoBold.copyWith(
                            fontSize: 15,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FittedBox(
                                child: IconButton(
                                  onPressed: () {
                                    controller.removeStudentFromExamRoom(
                                        studentSeatNumberId: controller
                                            .availableStudents[i].iD!);
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.trashCan,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  return Draggable<StudentSeatNumberResModel>(
                          data: controller.availableStudents[i],
                          feedback: child,
                          child: child)
                      .paddingAll(
                        5,
                      )
                      .paddingOnly(right: 15);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
