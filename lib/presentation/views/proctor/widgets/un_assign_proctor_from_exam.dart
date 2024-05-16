import 'package:flutter/material.dart';

class UnAssignProctorFromExam extends StatelessWidget {
  const UnAssignProctorFromExam({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 500,
      height: 400,
      // child: ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: result!.length,
      //   itemBuilder: (context, index) {
      //     var exam = result[index];
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           Text(exam.subjects!.subjectName),
      //           Text(exam.start_time ?? ''),
      //           Text(exam.examroomname ?? ''),
      //           ElevatedButton(
      //               onPressed: () async {
      //                 Proctor_controller proctor_controller = Get.find();
      //                 var month = DateFormat('dd MMMM')
      //                     .format(proctor_controller.selectedDate);
      //                 var year = DateFormat('yyyy')
      //                     .format(proctor_controller.selectedDate);

      //                 await ProctorsServices.unAssignExamToProctor(
      //                   period: 0,
      //                   examRoomId: 0,
      //                   proctorId: proctor.id ?? 0,
      //                   month: month,
      //                   year: year,
      //                 );
      //                 proctor_controller.getExamRooms(
      //                     proctor_controller.selectedMission!.id!);

      //                 Get.back();
      //               },
      //               child: const Text("UnAssgin"))
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
