import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/styles_manager.dart';
import '../../../resource_manager/values_manager.dart';

class ExamRoomsAssignedToProctorWidget extends GetView<ProctorController> {
  const ExamRoomsAssignedToProctorWidget({
    super.key,
    required this.proctorName,
  });

  final String proctorName;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: nunitoBold.copyWith(
        color: Colors.black,
        fontSize: AppSize.s16,
      ),
      child: GetBuilder<ProctorController>(
        builder: (controller) {
          return SizedBox(
            height: 500,
            width: 600,
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
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
                                'Proctor Name: $proctorName',
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
                            children: controller.proctorHasExamRooms
                                .where((examRoom) => examRoom.period!)
                                .map(
                                  (examRoom) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${examRoom.examRoom!.name} ',
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${examRoom.month}/${examRoom.year} ',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
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
                          ListBody(
                            mainAxis: Axis.vertical,
                            children: controller.proctorHasExamRooms
                                .where((examRoom) => !examRoom.period!)
                                .map(
                                  (examRoom) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${examRoom.examRoom!.name} ',
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${examRoom.month}/${examRoom.year} ',
                                        ),
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
          );
        },
      ),
    );
  }
}
