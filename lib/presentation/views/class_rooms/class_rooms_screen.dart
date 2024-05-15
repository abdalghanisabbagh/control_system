import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:flutter/material.dart';

import '../../resource_manager/ReusableWidget/header_widget.dart';

class ClassRoomsScreen extends StatelessWidget {
  const ClassRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: HeaderWidget(text: "Class Rooms")),
                InkWell(
                  onTap: () {
                    // Get.toNamed(Routes.classRoomSeats);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.glodenColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Add Class Room",
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
