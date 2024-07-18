import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/styles_manager.dart';
import '../../../resource_manager/values_manager.dart';

class ProctorsInExamRoomWidget extends GetView<ProctorController> {
  const ProctorsInExamRoomWidget({
    super.key,
    required this.examRoomName,
  });

  final String examRoomName;

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
                              'Exam Room Name: $examRoomName',
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
                          children: controller.proctorsInExamRoom
                              .where((proctor) => proctor.period!)
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
          );
        },
      ),
    );
  }
}
