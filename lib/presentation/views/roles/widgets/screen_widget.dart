import 'package:control_system/domain/controllers/roles_controller.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSideMenu extends StatelessWidget {
  final String screenName;
  final String frontId;
  final bool isSelected;
  final VoidCallback onSelect;
  final int screenId;
  final Color? color;

  const ScreenSideMenu({
    super.key,
    required this.screenName,
    required this.frontId,
    required this.isSelected,
    required this.onSelect,
    required this.screenId,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RolesController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          onSelect();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$screenName :  $frontId",
                  style: nunitoBold.copyWith(
                    color: ColorManager.primary,
                    fontSize: 16,
                  ),
                ),
              ),
             
            ],
          ),
        ),
      );
    });
  }
}
