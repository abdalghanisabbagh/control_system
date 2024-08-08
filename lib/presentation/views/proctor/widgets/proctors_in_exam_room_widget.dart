import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

class ProctorsInExamRoomWidget extends GetView<ProctorController> {
  final String examRoomName;

  const ProctorsInExamRoomWidget({
    super.key,
    required this.examRoomName,
  });

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Exam Room Name: $examRoomName',
                                  style: nunitoBold.copyWith(
                                    fontSize: AppSize.s25,
                                  ),
                                  maxLines: 1,
                                ),
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
                            children: controller.proctorsInExamRoom
                                .where((proctor) => proctor.period!)
                                .map(
                                  (proctors) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${proctors.proctor!.userName} ',
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await controller
                                                .unAssignProctorFromExamRoom(
                                              proctorId: proctors.id!,
                                            )
                                                .then((value) {
                                              if (value) {
                                                Get.back();
                                                MyFlashBar.showSuccess(
                                                  'Unassigned Successfully',
                                                  'Success',
                                                ).show(Get.key.currentContext!);
                                              }
                                            });
                                          },
                                          child: const Text('UnAssign'),
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
                            children: controller.proctorsInExamRoom
                                .where((proctor) => !proctor.period!)
                                .map(
                                  (proctors) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${proctors.proctor!.userName} ',
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
