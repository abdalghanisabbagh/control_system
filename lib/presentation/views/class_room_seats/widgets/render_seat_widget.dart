import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

import '../../../../Data/Models/student_seat/student_seat_res_model.dart';
import '../../../../domain/controllers/class_room_controller.dart';

// ignore: must_be_immutable
class RenderSeats extends StatelessWidget {
  List<StudentSeatNumberResModel> seatsNumbers = [];

  RenderSeats({super.key, required this.seatsNumbers});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ClassRoomController>(
      id: 'classSeats',
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
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    width: size.width * 0.1,
                                    child: Image.asset(
                                        AssetsManager.assetsImagesClassDesk),
                                  ),
                                  Positioned.fill(
                                    right: 10,
                                    child: Center(
                                      child: Text(
                                        controller.count.toString(),
                                        style: nunitoBold.copyWith(
                                          color: ColorManager.black,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
