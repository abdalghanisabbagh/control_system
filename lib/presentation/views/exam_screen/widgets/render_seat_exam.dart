import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RenderSeatsExam extends StatelessWidget {
  const RenderSeatsExam({super.key});

  // Map<String, Studentseatnumber> seatsNumbers = {};

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return const SizedBox.shrink();

    // return GetBuilder<DistrbutionController>(
    //   builder: (seatControll) {
    //     int count = 0;

    //     return controller.classSeats.isEmpty
    //         ? const SizedBox.shrink()
    //         :
    //         // columns
    //         Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(
    //                 width: 400,
    //                 padding: const EdgeInsets.all(20),
    //                 decoration: BoxDecoration(color: ColorManager.bgSideMenu),
    //                 child: Center(
    //                   child: Text(
    //                     "Smart Board",
    //                     style: nunitoRegular.copyWith(
    //                       color: ColorManager.white,
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               Expanded(
    //                 child: ListView.builder(
    //                   itemCount: controller.numbers.value,
    //                   itemBuilder: (context, index) {
    //                     return Padding(
    //                       padding: const EdgeInsets.symmetric(vertical: 5),
    //                       child: SizedBox(
    //                         height: 150,
    //                         child: ListView.separated(
    //                           separatorBuilder: (context, index) => SizedBox(
    //                             width: MediaQuery.of(context).size.width * 0.01,
    //                           ),
    //                           scrollDirection: Axis.horizontal,
    //                           shrinkWrap: true,
    //                           itemCount: controller.classSeats[index],
    //                           itemBuilder: (context, i) {
    //                             count++;
    //                             final id = count;
    //                             final classDesk = controller
    //                                 .selectedExamRoom!.classdesk![id - 1];
    //                             if (index == controller.numbers.value &&
    //                                 i == controller.classSeats[index]) {
    //                               count = 0;
    //                             }
    //                             try {
    //                               if (!controller.allSeatsIds.values
    //                                   .contains("$index,$i")) {
    //                                 if (!controller.blockSeats.contains(id)) {
    //                                   controller.allSeatsIds
    //                                       .addAll({id: "$index,$i"});
    //                                 }
    //                               } else {
    //                                 log('added in block before ');
    //                               }
    //                             } catch (e) {
    //                               log(e.toString());
    //                             }

    //                             Studentseatnumber? data;
    //                             String? gradeName;
    //                             try {
    //                               data = seatsNumbers[seatsNumbers.keys
    //                                   .firstWhere(
    //                                       (element) => element == "$index,$i")];
    //                               gradeName = StudentServices.getGrade(
    //                                       id: data?.gradesId)
    //                                   .name;

    //                               if (data!.desk == null) {
    //                                 final desk = controller
    //                                     .selectedExamRoom!.classdesk!
    //                                     .firstWhere((d) =>
    //                                         d.columnNum - 1 == index &&
    //                                         d.rowNum - 1 == i);

    //                                 controller.updateSeatsInServer(
    //                                   studNumberId: data.id!,
    //                                   desk: desk,
    //                                 );
    //                               }
    //                             } catch (e) {
    //                               if (kDebugMode) {
    //                               }
    //                             }

    //                             return Container(
    //                               padding:
    //                                   const EdgeInsets.symmetric(horizontal: 5),
    //                               width: size.width * 0.1,
    //                               height: size.height * 0.05,
    //                               child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 children: [
    //                                   Container(
    //                                     alignment: Alignment.center,
    //                                     width: size.width * 0.08,
    //                                     height: size.height * 0.05,
    //                                     decoration: BoxDecoration(
    //                                       color: seatControll.blockSeats
    //                                               .contains(id)
    //                                           ? ColorManager.red
    //                                           : seatControll.seatColorTitle,
    //                                       border: Border.all(
    //                                         color: seatControll.blockSeats
    //                                                 .contains(id)
    //                                             ? ColorManager.red
    //                                             : Colors.black,
    //                                         width: 1.5,
    //                                       ),
    //                                     ),
    //                                     child: data != null
    //                                         ? Row(
    //                                             mainAxisAlignment:
    //                                                 MainAxisAlignment.center,
    //                                             crossAxisAlignment:
    //                                                 CrossAxisAlignment.center,
    //                                             children: [
    //                                               Text(
    //                                                 data.seatNumbers!,
    //                                                 textAlign: TextAlign.center,
    //                                                 style:                                                         .nunitoBold
    //                                                     .copyWith(
    //                                                   color: ColorManager.black,
    //                                                   fontSize: 16,
    //                                                 ),
    //                                               ),
    //                                               IconButton(
    //                                                 tooltip: "Delete Student",
    //                                                 onPressed: () {
    //                                                   seatControll
    //                                                       .removeSeatFromRender(
    //                                                           rowcolumn:
    //                                                               "$index,$i",
    //                                                           stdsetNum: data!);
    //                                                 },
    //                                                 icon: const Icon(
    //                                                   Icons.undo,
    //                                                   color: Colors.red,
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           )
    //                                         : seatControll.blockSeats
    //                                                 .contains(id)
    //                                             ? Center(
    //                                                 child: IconButton(
    //                                                   tooltip:
    //                                                       "Unblock the seat",
    //                                                   onPressed: () {
    //                                                     seatControll
    //                                                         .unBlockSeat(id,
    //                                                             "$index,$i");
    //                                                   },
    //                                                   icon: const Icon(
    //                                                     Icons.undo,
    //                                                     color: Colors.green,
    //                                                   ),
    //                                                 ),
    //                                               )
    //                                             : Center(
    //                                                 child: IconButton(
    //                                                   tooltip: "Block the seat",
    //                                                   onPressed: () {
    //                                                     seatControll
    //                                                         .blockSeat(id);
    //                                                   },
    //                                                   icon: const Icon(
    //                                                     Icons.block,
    //                                                     color: Colors.red,
    //                                                   ),
    //                                                 ),
    //                                               ),
    //                                   ),
    //                                   Container(
    //                                     alignment: Alignment.center,
    //                                     width: size.width * 0.08,
    //                                     height: size.height * 0.08,
    //                                     decoration: BoxDecoration(
    //                                       color: data != null
    //                                           ? ExamRoomScreen
    //                                               .mycolors[data.gradesId! % 12]
    //                                               .withOpacity(0.5)
    //                                           : seatControll.blockSeats
    //                                                   .contains(id)
    //                                               ? ColorManager.red
    //                                               : seatControll.seatColorBody,
    //                                       border: Border.all(
    //                                         color: seatControll.blockSeats
    //                                                 .contains(id)
    //                                             ? ColorManager.red
    //                                             : Colors.black,
    //                                         width: 1.5,
    //                                       ),
    //                                     ),
    //                                     child: Column(
    //                                       mainAxisSize: MainAxisSize.min,
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.center,
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.center,
    //                                       children: [
    //                                         Text(
    //                                           data != null
    //                                               ? "${data.students?.firstName} ${data.students?.middleName} ${data.students?.lastName}"
    //                                               : "",
    //                                           textAlign: TextAlign.center,
    //                                           style: nunitoRegular
    //                                               .copyWith(
    //                                             color: ColorManager.black,
    //                                             fontSize: 12,
    //                                           ),
    //                                         ),
    //                                         Text(
    //                                           data != null
    //                                               ? gradeName ?? ""
    //                                               : "$index , $i",
    //                                           textAlign: TextAlign.center,
    //                                           style: nunitoRegular
    //                                               .copyWith(
    //                                             color: ColorManager.black,
    //                                             fontSize: 12,
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           );
    //   },
    // );
  }
}
