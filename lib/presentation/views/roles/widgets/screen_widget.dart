import 'package:control_system/domain/controllers/privileges_controller.dart';
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
    return GetBuilder<PrivilegesController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            onSelect();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? ColorManager.primary : ColorManager.grey,
                width: isSelected ? 4 : 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$screenName :  $frontId",
                      style: nunitoBold.copyWith(
                        color: ColorManager.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
