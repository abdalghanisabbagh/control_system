import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/roles_controller.dart';

class FrontIdScreen extends GetView<RolesController> {
  final String widgetName;
  final String frontId;
  final Color color;
  final bool included;
  final int id;
  //final VoidCallback onSelect;

  const FrontIdScreen({
    super.key,
    required this.widgetName,
    required this.frontId,
    required this.color,
    required this.included,
    required this.id,
    //  required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        //    color: widget.isSelected ? Colors.green : ColorManager.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$widgetName : $frontId ",
            style: nunitoBold.copyWith(
              color: ColorManager.primary,
              fontSize: 16,
            ),
          ),
          included
              ? IconButton(
                  onPressed: () {
                    controller.removedSreensIds.add(id);
                    controller.deleteScreensFromRole().then((value) {
                      if (value) {
                        MyFlashBar.showSuccess(
                          'Removed successfully From Role',
                          "Success",
                        ).show(Get.key.currentContext!);
                      }
                    });
                  },
                  icon: const Icon(Icons.delete))
              : IconButton(
                  onPressed: () {
                    controller.selectedSreensIds.add(id);
                    controller.addScreensToRole().then((value) {
                      if (value) {
                        MyFlashBar.showSuccess(
                          'Added successfully To Role',
                          "Success",
                        ).show(Get.key.currentContext!);
                      }
                    });
                  },
                  icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
