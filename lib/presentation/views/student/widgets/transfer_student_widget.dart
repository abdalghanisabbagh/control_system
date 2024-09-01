import 'package:control_system/Data/Models/student/student_res_model.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_edit_button.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../../../../domain/controllers/students_controllers/transfer_student_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/constants/app_constatnts.dart';

class TransferStudentWidget extends GetView<TransferStudentController> {
  final StudentResModel studentResModel;

  const TransferStudentWidget({super.key, required this.studentResModel});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transfer Student',
                style: nunitoBold.copyWith(fontSize: 20),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Select School',
            style: nunitoBlack.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          MultiSelectDropDownView(
            options: AppConstants.schoolDivision
                .map((e) => ValueItem(label: e, value: e))
                .toList(),
            onOptionSelected: (value) {},
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Select Grade',
            style: nunitoBlack.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          MultiSelectDropDownView(
            options: AppConstants.schoolDivision
                .map((e) => ValueItem(label: e, value: e))
                .toList(),
            onOptionSelected: (value) {},
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Select Class',
            style: nunitoBlack.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          MultiSelectDropDownView(
            options: AppConstants.schoolDivision
                .map((e) => ValueItem(label: e, value: e))
                .toList(),
            onOptionSelected: (value) {},
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Select Cohort',
            style: nunitoBlack.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          MultiSelectDropDownView(
            options: AppConstants.schoolDivision
                .map((e) => ValueItem(label: e, value: e))
                .toList(),
            onOptionSelected: (value) {},
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedEditButton(
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
