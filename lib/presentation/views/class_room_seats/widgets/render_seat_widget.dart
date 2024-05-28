import 'package:control_system/Data/Models/student_seat/student_seat_model.dart';
import 'package:control_system/domain/controllers/class_room_controller.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

import '../../../resource_manager/styles_manager.dart';

// ignore: must_be_immutable
class RendarSeats extends StatelessWidget {
  RendarSeats({super.key, required this.seatsNumbers});
  List<StudentSeatModel> seatsNumbers = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ClassRoomController>(
      builder: (controller) {
        return controller.classSeats.isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  SizedBox(
                    width: 500,
                    height: 200,
                    child: Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Image.asset(
                        AssetsManager.assetsImagesbackground,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  ListView.builder(
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
                                i++, controller.count++)
                              Stack(children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: size.width * 0.1,
                                  child: Image.asset(
                                      AssetsManager.assetsImagesClassDesk),
                                ),
                                Positioned(
                                  //       width: 0,
                                  top: 40,
                                  //   left: 0,
                                  right: (size.width * 0.085) / 2,
                                  child: Text(
                                    controller.count.toString(),
                                    style: nunitoBold.copyWith(
                                      color: ColorManager.black,
                                      fontSize: 35,
                                    ),
                                  ),
                                )
                              ]),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
      },
    );
  }
}
