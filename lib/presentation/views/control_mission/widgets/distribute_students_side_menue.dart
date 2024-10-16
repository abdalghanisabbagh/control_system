import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import 'add_new_students_to_exam_room_widget.dart';
import 'available_students.dart';
import 'remove_students_from_exam_room_widget.dart';

class DistributeStudentsSideMenue
    extends GetView<DistributeStudentsController> {
  const DistributeStudentsSideMenue({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistributeStudentsController>(
      builder: (_) {
        return Container(
          height: Get.height * 0.7,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(
                        2,
                        15,
                      ),
                    ),
                  ],
                  color: ColorManager.primary,
                  border: Border.all(
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          'Exam Room Students',
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: IconButton(
                        tooltip: "Remove Students From Exam Room",
                        onPressed: () {
                          MyDialogs.showDialog(
                            context,
                            RemoveStudentsFromExamRoomWidget(),
                          );
                        },
                        icon: const Icon(
                          Icons.person_remove_alt_1,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fill,
                      child: IconButton(
                        tooltip: "Add Students To Exam Room",
                        onPressed: () {
                          MyDialogs.showDialog(
                            context,
                            AddNewStudentsToExamRoomWidget(),
                          );
                        },
                        icon: const Icon(
                          Icons.person_add_alt_1,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const AvailableStudents(),
            ],
          ),
        );
      },
    );
  }
}
