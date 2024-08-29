import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';

class HeaderWidget extends GetView<DistributeStudentsController> {
  const HeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistributeStudentsController>(
      builder: (_) {
        return SizedBox(
          width: Get.width * 0.4,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                controller.countByGrade.keys.length,
                (index) => IntrinsicHeight(
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                              ),
                              color: ColorManager.yellow,
                            ),
                            child: Text(
                              '${controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).name} (${controller.countByGrade.values.toList()[index]})',
                              style: nunitoRegular,
                            ).paddingSymmetric(horizontal: 10, vertical: 5),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                              ),
                              color: ColorManager.gradesColor[controller.grades
                                  .firstWhere((element) =>
                                      element.iD.toString() ==
                                      controller.countByGrade.keys
                                          .toList()[index])
                                  .name],
                            ),
                            child: Text(
                              '${controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).name} (${controller.availableStudents.where((element) => element.gradesID == controller.grades.firstWhere((element) => element.iD.toString() == controller.countByGrade.keys.toList()[index]).iD).length})',
                              style: nunitoRegular,
                            ).paddingSymmetric(horizontal: 10, vertical: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).paddingSymmetric(horizontal: 10),
              )..insert(
                  0,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Available: ${controller.availableStudentsCount}',
                        style: nunitoRegular,
                      ),
                      Text(
                        'Current: ${controller.availableStudents.length}',
                        style: nunitoRegular,
                      ),
                      Text(
                        'Max: ${controller.examRoomResModel.classRoomResModel?.maxCapacity}',
                        style: nunitoRegular,
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
