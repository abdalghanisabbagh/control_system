import 'package:control_system/Data/Models/exam_room/exam_room_res_model.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_back_button.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DistributeStudents extends StatelessWidget {
  const DistributeStudents({super.key, required this.currentExamRoom});

  final ExamRoomResModel currentExamRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const MyBackButton(),
              const SizedBox(
                width: 20,
              ),
              Text(
                'Exam Room: ${currentExamRoom.name}',
                style: nunitoBold.copyWith(
                  fontSize: AppSize.s25,
                  color: ColorManager.black,
                ),
              ),
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
                          color: ColorManager.primary,
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Exam Room Students',
                              style: nunitoBold.copyWith(
                                color: ColorManager.white,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.person_add_alt_1,
                                color: ColorManager.white,
                              ),
                            ),
                          ],
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
                                              color: ColorManager.primary,
                                              border: Border.all(
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Class Desk ${i * 6 + j + 1}',
                                                style: nunitoBold.copyWith(
                                                  color: ColorManager.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ).paddingSymmetric(horizontal: 5);
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
                    icon: const Icon(Icons.print, color: Colors.white),
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
      ),
    );
  }
}
