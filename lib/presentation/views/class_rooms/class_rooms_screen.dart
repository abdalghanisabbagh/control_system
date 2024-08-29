import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/controllers/class_room_controller.dart';
import '../../../domain/controllers/profile_controller.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/routes/index.dart';
import '../base_screen.dart';
import 'widgets/class_rooms_widget.dart';

class ClassRoomsScreen extends GetView<ClassRoomController> {
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
                const Expanded(
                  child: HeaderWidget(text: "Class Rooms"),
                ),
                Visibility(
                  visible: Get.find<ProfileController>().canAccessWidget(
                    widgetId: '6100',
                  ),
                  child: InkWell(
                    onTap: () {
                      context.goNamed(
                          AppRoutesNamesAndPaths.classRoomSeatsScreenName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.glodenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: ClassRoomsWidget(),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
