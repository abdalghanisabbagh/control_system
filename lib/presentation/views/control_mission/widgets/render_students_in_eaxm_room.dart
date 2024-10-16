import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/student_seat/student_seat_res_model.dart';
import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';

class RenderStudentsInEaxmRoom extends GetView<DistributeStudentsController> {
  const RenderStudentsInEaxmRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistributeStudentsController>(
      builder: (_) {
        return SizedBox(
          height: Get.height * 0.6,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    controller.numberOfRows,
                    (i) {
                      return Row(
                        children: [
                          ...List.generate(
                            controller.classDeskCollection.entries
                                .toList()[i]
                                .value
                                .length,
                            (j) {
                              return controller.blockedClassDesks.contains(
                                      controller.classDeskCollection.entries
                                          .toList()[i]
                                          .value[j]
                                          .id)
                                  ? SizedBox(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.1,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.5,
                                                ),
                                                color: ColorManager.yellow,
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  controller.unBlockClassDesk(
                                                      classDeskId: controller
                                                          .classDeskCollection
                                                          .entries
                                                          .toList()[i]
                                                          .value[j]
                                                          .id!);
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons
                                                      .arrowRotateLeft,
                                                  color: ColorManager.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.5,
                                                ),
                                                color: ColorManager.red,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${i != 0 ? i * controller.classDeskCollection.entries.toList()[i - 1].value.length + j + 1 : i * controller.classDeskCollection.entries.toList()[i].value.length + j + 1}',
                                                style: nunitoBold.copyWith(
                                                  color: ColorManager.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).paddingSymmetric(horizontal: 5)
                                  : (controller.availableStudents
                                          .map((element) => element.classDeskID)
                                          .toList()
                                          .contains(controller
                                              .classDeskCollection.entries
                                              .toList()[i]
                                              .value[j]
                                              .id!))
                                      ? SizedBox(
                                          height: Get.height * 0.2,
                                          width: Get.width * 0.1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1.5,
                                                    ),
                                                    color: ColorManager.yellow,
                                                  ),
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).seatNumber}',
                                                          style: nunitoRegular,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          controller.removeStudentFromDesk(
                                                              studentSeatNumberId: controller
                                                                  .availableStudents
                                                                  .firstWhere((element) =>
                                                                      element
                                                                          .classDeskID ==
                                                                      controller
                                                                          .classDeskCollection
                                                                          .entries
                                                                          .toList()[
                                                                              i]
                                                                          .value[
                                                                              j]
                                                                          .id)
                                                                  .iD!);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .deleteLeft,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1.5,
                                                    ),
                                                    color: ColorManager
                                                            .gradesColor[
                                                        controller
                                                            .availableStudents
                                                            .firstWhere((element) =>
                                                                element
                                                                    .classDeskID ==
                                                                controller
                                                                    .classDeskCollection
                                                                    .entries
                                                                    .toList()[i]
                                                                    .value[j]
                                                                    .id)
                                                            .student!
                                                            .gradeResModel!
                                                            .name!],
                                                  ),
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Student Name: ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.firstName!} ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.secondName!} ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.thirdName!} ',
                                                          style: nunitoBold
                                                              .copyWith(
                                                            fontSize: 14,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Text(
                                                          'Class: ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.classRoomResModel?.name}',
                                                          style: nunitoBold
                                                              .copyWith(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Text(
                                                          'Grade : ${controller.availableStudents.firstWhere((element) => element.classDeskID == controller.classDeskCollection.entries.toList()[i].value[j].id).student?.gradeResModel?.name}',
                                                          style: nunitoBold
                                                              .copyWith(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ).paddingSymmetric(
                                                    horizontal: 5,
                                                    vertical: 5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ).paddingSymmetric(horizontal: 5)
                                      : DragTarget<StudentSeatNumberResModel>(
                                          onAcceptWithDetails: (details) {
                                            controller.addStudentToDesk(
                                              studentSeatNumberId:
                                                  details.data.iD!,
                                              classDeskId: controller
                                                  .classDeskCollection.entries
                                                  .toList()[i]
                                                  .value[j]
                                                  .id!,
                                            );
                                          },
                                          builder: (BuildContext context,
                                                  List<StudentSeatNumberResModel?>
                                                      data,
                                                  List<dynamic> rejects) =>
                                              SizedBox(
                                            height: Get.height * 0.2,
                                            width: Get.width * 0.1,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1.5,
                                                      ),
                                                      color:
                                                          ColorManager.yellow,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        controller.blockClassDesk(
                                                            classDeskId: controller
                                                                .classDeskCollection
                                                                .entries
                                                                .toList()[i]
                                                                .value[j]
                                                                .id!);
                                                      },
                                                      icon: const Icon(
                                                        FontAwesomeIcons.ban,
                                                        color: ColorManager.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1.5,
                                                      ),
                                                      color:
                                                          ColorManager.greyA8,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: FittedBox(
                                                      fit: BoxFit.fill,
                                                      child: Text(
                                                        '${i != 0 ? i * controller.classDeskCollection.entries.toList()[i - 1].value.length + j + 1 : i * controller.classDeskCollection.entries.toList()[i].value.length + j + 1}',
                                                        style:
                                                            nunitoBold.copyWith(
                                                          color: ColorManager
                                                              .white,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).paddingSymmetric(horizontal: 5),
                                        );
                            },
                          ),
                        ],
                      ).paddingOnly(bottom: 10);
                    },
                  ),
                ],
              ).paddingOnly(top: 20, right: 20),
            ),
          ),
        );
      },
    );
  }
}
