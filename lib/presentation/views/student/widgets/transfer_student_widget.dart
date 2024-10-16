import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/student/student_res_model.dart';
import '../../../../domain/controllers/students_controllers/transfer_student_controller.dart';
import '../../../resource_manager/ReusableWidget/drop_down_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';

class TransferStudentWidget extends GetView<TransferStudentController> {
  final StudentResModel studentResModel;

  const TransferStudentWidget({super.key, required this.studentResModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: GetBuilder<TransferStudentController>(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: controller.isLoadingSchools
                ? [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Transfer Student: ${studentResModel.firstName} ${studentResModel.secondName} ${studentResModel.thirdName}',
                            style: nunitoBold.copyWith(fontSize: 20),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Close',
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
                    Center(
                      child: LoadingIndicators.getLoadingIndicator(),
                    ),
                  ]
                : [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Transfer Student: ${studentResModel.firstName} ${studentResModel.secondName} ${studentResModel.thirdName}',
                            style: nunitoBold.copyWith(fontSize: 20),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Close',
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
                      searchEnabled: true,
                      options: controller.schoolsOptions
                          .where((e) => e.value != studentResModel.schoolsID)
                          .toList(),
                      onOptionSelected: controller.onSchoolChanged,
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
                    controller.selectedItemSchool == null
                        ? Center(
                            child: Text(
                              'Please select school',
                              style: nunitoBlack,
                            ),
                          )
                        : controller.isLoadingGrades
                            ? Center(
                                child: LoadingIndicators.getLoadingIndicator(),
                              )
                            : controller.gradesOptions.isNotEmpty
                                ? MultiSelectDropDownView(
                                    searchEnabled: true,
                                    options: controller.gradesOptions,
                                    onOptionSelected: controller.onGradeChanged,
                                  )
                                : Center(
                                    child: Text('No grades found',
                                        style: nunitoBlack),
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
                    controller.selectedItemSchool == null
                        ? Center(
                            child: Text(
                              'Please select school',
                              style: nunitoBlack,
                            ),
                          )
                        : controller.isLoadingClassRooms
                            ? Center(
                                child: LoadingIndicators.getLoadingIndicator(),
                              )
                            : controller.classesOptions.isEmpty
                                ? Center(
                                    child: Text(
                                      'No class rooms found',
                                      style: nunitoBlack,
                                    ),
                                  )
                                : MultiSelectDropDownView(
                                    searchEnabled: true,
                                    options: controller.classesOptions,
                                    onOptionSelected:
                                        controller.onClassRoomChanged,
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
                    controller.selectedItemSchool == null
                        ? Center(
                            child: Text(
                              'Please select school',
                              style: nunitoBlack,
                            ),
                          )
                        : controller.isLoadingCohorts
                            ? Center(
                                child: LoadingIndicators.getLoadingIndicator(),
                              )
                            : controller.cohortsOptions.isEmpty
                                ? Center(
                                    child: Text(
                                      'No cohorts found',
                                      style: nunitoBlack,
                                    ),
                                  )
                                : MultiSelectDropDownView(
                                    searchEnabled: true,
                                    options: controller.cohortsOptions,
                                    onOptionSelected:
                                        controller.onCohortChanged,
                                  ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.transferLoading
                        ? Center(
                            child: LoadingIndicators.getLoadingIndicator(),
                          )
                        : ElevatedEditButton(
                            title: 'Transfer',
                            onPressed: () {
                              controller.transferStudent(studentResModel.iD!);
                            },
                          ),
                  ],
          );
        },
      ),
    );
  }
}
