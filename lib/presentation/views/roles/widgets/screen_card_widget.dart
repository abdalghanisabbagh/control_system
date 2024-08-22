import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/roles_controller.dart';

class ScreenCardWidget extends GetView<RolesController> {
  final int index;

  const ScreenCardWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RolesController>(
      builder: (_) {
        return Card(
          margin: const EdgeInsets.only(
            left: 5,
            top: 5,
            bottom: 5,
            right: 20,
          ),
          color: ColorManager
              .screensColors[index % ColorManager.screensColors.length],
          elevation: 10,
          child: ListTile(
            title: Text(
              controller.searchScreensController.text.isEmpty
                  ? controller.screens[index].name
                  : controller.screens
                      .where((screen) =>
                          screen.name.toLowerCase().contains(controller
                              .searchScreensController.text
                              .toLowerCase()) ||
                          screen.frontId.contains(
                              controller.searchScreensController.text))
                      .toList()[index]
                      .name,
              style: nunitoBold.copyWith(
                color: ColorManager.black,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              controller.searchScreensController.text.isEmpty
                  ? controller.screens[index].frontId
                  : controller.screens
                      .where((screen) =>
                          screen.name.toLowerCase().contains(controller
                              .searchScreensController.text
                              .toLowerCase()) ||
                          screen.frontId.contains(
                              controller.searchScreensController.text))
                      .toList()[index]
                      .frontId,
            ),
          ),
        );
      },
    );
  }
}
