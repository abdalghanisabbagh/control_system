import 'package:flutter/material.dart';

class AssignProctorToExamByRoomId extends StatelessWidget {
  const AssignProctorToExamByRoomId({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 500,
      width: 600,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        // child: Column(
        //   children: [
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
        //               if (proctor.isFloorManager == null)
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     var result =
        //                         await ProctorsServices.assignExamToProctor(
        //                       period: 0,
        //                       examrooms_Id: roomId,
        //                       user_proctor_id: proctor.id ?? 0,
        //                       year: year,
        //                       month: month,
        //                       token: Hive.box('Token').get('token'),
        //                     );
        //                     proctorController.selectedProctor = null;
        //                     Get.back();
        //                     if (result != null) {
        //                       if (jsonDecode(result)['statusCode'] == 'P2002') {
        //                         MyFlashBar.showSuccess(
        //                             "Assign to proctor", 'Assign Before');
        //                       } else {
        //                         proctorController.getExamRooms(
        //                             proctorController.selectedMission!.id!);
        //                         MyFlashBar.showSuccess(
        //                             "Assign to proctor", 'Done');
        //                       }
        //                     } else {
        //                       MyFlashBar.showError(
        //                           "Assign to proctor", 'Error');
        //                     }
        //                   },
        //                   child: const Text('assign to proctor'),
        //                 ),
        //             ],
        //           ),
        //           ListView.builder(
        //             shrinkWrap: true,
        //             itemCount: morningExams.length,
        //             itemBuilder: (context, index) {
        //               var exam = morningExams[index];
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
        //               if (proctor.isFloorManager == null)
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     var result =
        //                         await ProctorsServices.assignExamToProctor(
        //                             period: 1,
        //                             examrooms_Id: roomId,
        //                             user_proctor_id: proctor.id ?? 0,
        //                             year: year,
        //                             month: month,
        //                             token: Hive.box('Token').get('token'));
        //                     proctorController.selectedProctor = null;
        //                     Get.back();
        //                     if (result != null) {
        //                       if (jsonDecode(result)['statusCode'] == 'P2002') {
        //                         MyFlashBar.showSuccess(
        //                             "Assign to proctor", 'Assign Before');
        //                       } else {
        //                         proctorController.getExamRooms(
        //                             proctorController.selectedMission!.id!);
        //                         MyFlashBar.showSuccess(
        //                             "Assign to proctor", 'Done');
        //                       }
        //                     } else {
        //                       MyFlashBar.showError(
        //                           "Assign to proctor", 'Error');
        //                     }
        //                   },
        //                   child: const Text('assign to proctor'),
        //                 ),
        //             ],
        //           ),
        //           ListView.builder(
        //             shrinkWrap: true,
        //             itemCount: nightExams.length,
        //             itemBuilder: (context, index) {
        //               var exam = nightExams[index];
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
        //   ],
        // ),
      ),
    );
  }
}
