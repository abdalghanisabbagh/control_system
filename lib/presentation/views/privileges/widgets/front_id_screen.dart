import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/privileges_controller.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';

class FrontIdScreen extends GetView<PrivilegesController> {
  final Color color;

  final String frontId;
  final int id;
  final bool included;
  final String widgetName;
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
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "$widgetName : $frontId ",
              style: nunitoBold.copyWith(
                color: ColorManager.primary,
                fontSize: 16,
              ),
            ),
          ),
          controller.selectedRoleId == null
              ? const SizedBox.shrink()
              : included
                  ? IconButton(
                      onPressed: () {
                        controller.removedSreensIds.add(id);
                        controller.deleteScreensFromRole().then(
                          (value) {
                            if (value) {
                              MyFlashBar.showSuccess(
                                'Removed successfully From Role',
                                "Success",
                              ).show(Get.key.currentContext!);
                            }
                          },
                        );
                      },
                      icon: const Icon(Icons.delete))
                  : IconButton(
                      onPressed: () {
                        controller.selectedSreensIds.add(id);
                        controller.addScreensToRole().then(
                          (value) {
                            if (value) {
                              MyFlashBar.showSuccess(
                                'Added successfully To Role',
                                "Success",
                              ).show(Get.key.currentContext!);
                            }
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
        ],
      ),
    );
  }
}
