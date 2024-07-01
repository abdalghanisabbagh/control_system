import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_back_button.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import 'add_new_students_to_exam_room_widget.dart';

class DistributeStudents extends GetView<DistributeStudentsController> {
  const DistributeStudents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DistributeStudentsController>(
        builder: (_) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const MyBackButton(),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Exam Room: ${controller.examRoomResModel.name}',
                          style: nunitoBold.copyWith(
                            fontSize: AppSize.s25,
                            color: ColorManager.black,
                          ),
                        ),
                        const Spacer(),
                        const Row(children: [
                          // List.generate(controller.studentsSeatNumbers, generator)
                        ]),
                        const Spacer(),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Auto Generate (Simple)',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Auto Generate (Cross)',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Remove All',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: Get.height * 0.7,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: const Offset(
                                          2,
                                          15,
                                        ),
                                      ),
                                    ],
                                    color: ColorManager.primary,
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Exam Room Students',
                                        style: nunitoBold.copyWith(
                                          color: ColorManager.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          MyDialogs.showDialog(
                                            context,
                                            AddNewStudentsToExamRoomWidget(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.person_add_alt_1,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.6,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: List.generate(
                                        controller.availableStudents.length,
                                        (i) {
                                          return Draggable(
                                            feedback: Container(
                                              alignment: Alignment.topLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              height: Get.height * 0.1,
                                              width: Get.width * 0.1,
                                              decoration: BoxDecoration(
                                                color: ColorManager.glodenColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Student Name: ${controller.availableStudents[i].student?.firstName!} ${controller.availableStudents[i].student?.secondName!} ${controller.availableStudents[i].student?.thirdName!} ',
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager.white,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    'Seat NO: ${controller.studentsSeatNumbers[i].seatNumber}',
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Grade : ${controller.studentsSeatNumbers[i].student?.gradeResModel?.name}',
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              height: Get.height * 0.1,
                                              width: Get.width * 0.1,
                                              decoration: BoxDecoration(
                                                color: ColorManager.glodenColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Student Name: ${controller.availableStudents[i].student?.firstName!} ${controller.availableStudents[i].student?.secondName!} ${controller.availableStudents[i].student?.thirdName!} ',
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager.white,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    'Seat NO: ${controller.availableStudents[i].seatNumber}',
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Grade : ${controller.availableStudents[i].student?.gradeResModel?.name}',
                                                    style: nunitoBold.copyWith(
                                                      color: ColorManager.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).paddingAll(
                                              5,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: Get.height * 0.7,
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height * 0.08,
                                  width: Get.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Smart Board',
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.6,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                          5,
                                          (i) {
                                            return Row(
                                              children: [
                                                ...List.generate(
                                                  6,
                                                  (j) {
                                                    return Container(
                                                      height: Get.height * 0.2,
                                                      width: Get.width * 0.1,
                                                      decoration: BoxDecoration(
                                                        color: ColorManager
                                                            .primary,
                                                        border: Border.all(
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Class Desk ${i * 6 + j + 1}',
                                                          style: nunitoBold
                                                              .copyWith(
                                                            color: ColorManager
                                                                .white,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ).paddingSymmetric(
                                                        horizontal: 5);
                                                  },
                                                ),
                                              ],
                                            ).paddingOnly(bottom: 10);
                                          },
                                        ),
                                      ],
                                    ).paddingOnly(top: 20),
                                  ),
                                ).paddingOnly(top: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(
                      horizontal: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.print, color: Colors.white),
                              label: const Text('Print'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.glodenColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                fixedSize: Size(Get.width * 0.3, 50),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.done, color: Colors.white),
                              label: const Text('Finish'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.bgSideMenu,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                fixedSize: Size(Get.width * 0.3, 50),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
