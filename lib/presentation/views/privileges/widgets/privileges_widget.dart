import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/privileges_controller.dart';

class CustomPrivilegeCardWidget extends StatelessWidget {
  final bool isSelected;

  final VoidCallback onSelect;
  final String roleName;
  const CustomPrivilegeCardWidget({
    super.key,
    required this.roleName,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivilegesController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          onSelect();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : ColorManager.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    roleName,
                    style: nunitoBold.copyWith(
                      color: ColorManager.primary,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
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
