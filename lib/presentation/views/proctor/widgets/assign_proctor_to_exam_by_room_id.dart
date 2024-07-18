import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/proctor_controller.dart';
import '../../../resource_manager/styles_manager.dart';

class AssignProctorToExamByRoomId extends GetView<ProctorController> {
  const AssignProctorToExamByRoomId({
    super.key,
    required this.proctorId,
  });

  final int proctorId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 600,
      child: Padding(
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
                  '${controller.proctors.firstWhere((element) => element.iD == proctorId).fullName}',
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
            //     if (morningExams.isNotEmpty)
            //       Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             mainAxisSize: MainAxisSize.max,
            //             children: [
            //               Text(
            //                 "Session One Exams",
            //                 style: nunitoBlack.copyWith(
            //                   fontSize: 24,
            //                   color: Colors.orange,
            //                 ),
            //               ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Session One Exams",
                  style: nunitoBlack.copyWith(
                    fontSize: 24,
                    color: Colors.orange,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('assign to proctor'),
                ),
              ],
            ),
            //             ],
            //           ),
            //           ListView.builder(
            //             shrinkWrap: true,
            //             itemCount: 0,
            //             itemBuilder: (context, index) {
            //               return Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     if (exam.subjects != null)
            //                       Text(
            //                           "${exam.subjects!.name} (${exam.grades != null ? exam.grades!.name : ''})"),
            //                     if (exam.starttime != null)
            //                       Text(
            //                         DateFormat('yy/MM/dd (HH:mm)').format(
            //                           DateTime.parse(exam.starttime!),
            //                         ),
            //                       ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ),
            //         ],
            //       ),
            //     if (nightExams.isNotEmpty)
            //       Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             mainAxisSize: MainAxisSize.max,
            //             children: [
            //               Text(
            //                 "Session Two Exams",
            //                 style: nunitoBlack.copyWith(
            //                     fontSize: 24, color: Colors.orange),
            //               ),
            //               ElevatedButton(
            //                 onPressed: () async {},
            //                 child: const Text('assign to proctor'),
            //               ),
            //             ],
            //           ),
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
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('assign to proctor'),
                ),
              ],
            ),

            //           ListView.builder(
            //             shrinkWrap: true,
            //             itemCount: 0,
            //             itemBuilder: (context, index) {
            //               return Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     if (exam.subjects != null)
            //                       Text(
            //                           "${exam.subjects!.name} (${exam.grades != null ? exam.grades!.name : ''})"),
            //                     if (exam.starttime != null)
            //                       Text(
            //                         DateFormat('yy/MM/dd (HH:mm)').format(
            //                           DateTime.parse(exam.starttime!),
            //                         ),
            //                       ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ),
            //         ],
            //       ),
          ],
        ),
      ),
    );
  }
}
