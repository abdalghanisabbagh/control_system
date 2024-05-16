import 'package:flutter/material.dart';

class UnAssignProctorFromRoom extends StatelessWidget {
  const UnAssignProctorFromRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 500,
      height: 400,
      // child: ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: room.proctoInRoomWithExam!.length,
      //   itemBuilder: (context, index) {
      //     var proctor = room.proctoInRoomWithExam![index].proctor;
      //     var isNightExams = room.proctoInRoomWithExam![index].morningExams;
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           Text(proctor.userName ?? ''),
      //           Text(isNightExams ? "Session Two Exams" : "Session One Exams"),
      //           // Text(DateFormat('dd/MM - hh:mm')
      //           //     .format(DateTime.tryParse(exammission.start_time!)!)),
      //           ElevatedButton(
      //             onPressed: () async {
      //               Proctor_controller proctorController = Get.find();
      //               var month = DateFormat('dd MMMM')
      //                   .format(proctorController.selectedDate);
      //               var year = DateFormat('yyyy')
      //                   .format(proctorController.selectedDate);

      //               await ProctorsServices.unAssignExamToProctor(
      //                   examRoomId: room.id!,
      //                   period: isNightExams ? 1 : 0,
      //                   month: month,
      //                   year: year,
      //                   proctorId: proctor.id ?? 0);
      //               proctorController
      //                   .getExamRooms(proctorController.selectedMission!.id!);

      //               Get.back();
      //             },
      //             child: const Text("UnAssgin"),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
