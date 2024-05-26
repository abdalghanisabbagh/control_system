import 'package:control_system/domain/controllers/class_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RendarSeats extends GetView<ClassRoomController> {
  RendarSeats({super.key});
  // List<Studentseatnumber> seatsNumbers = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ClassRoomController>(
      builder: (controller) => controller.classSeats.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.numbers.value,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0;
                          i < controller.classSeats[index];
                          i++, count++)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: size.width * 0.1,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //       Container(
                              //         alignment: Alignment.center,
                              //         width: size.width * 0.1,
                              //         height: size.height * 0.05,
                              //         decoration: BoxDecoration(
                              //           color: const Color(0xffffff00),
                              //           border: Border.all(
                              //               color: Colors.black, width: 1.5),
                              //         ),
                              //         child: count > seatsNumbers.length - 1
                              //             ? const Text("")
                              //             : Text(
                              //                 seatsNumbers[count].seatNumbers!,
                              //                 style: const TextStyle(
                              //                     fontSize: 20,
                              //                     fontWeight: FontWeight.bold),
                              //               ),
                              //       ),
                              //       Container(
                              //         alignment: Alignment.center,
                              //         width: size.width * 0.1,
                              //         height: size.height * 0.05,
                              //         decoration: BoxDecoration(
                              //           color: const Color(0xffD7DBDF),
                              //           border: Border.all(
                              //               color: Colors.black, width: 1.5),
                              //         ),
                              //         child: count > seatsNumbers.length - 1
                              //             ? const Text("")
                              //             : Text(seatsNumbers[count]
                              //                     .students!
                              //                     .firstName! +
                              //                 seatsNumbers[count]
                              //                     .students!
                              //                     .lastName!),
                              //       ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
