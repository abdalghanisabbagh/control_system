import 'package:control_system/Data/Models/student_seat/student_seat_model.dart';
import 'package:control_system/domain/controllers/class_room_controller.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

// ignore: must_be_immutable
class RendarSeats extends StatelessWidget {
  RendarSeats({super.key, required this.seatsNumbers});
  List<StudentSeatModel> seatsNumbers = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ClassRoomController>(
      builder: (controller) => controller.classSeats.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.numbers,
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
                          child:
                              Image.asset(AssetsManager.assetsImagesClassDesk),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
