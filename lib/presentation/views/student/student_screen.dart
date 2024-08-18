import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/students_controllers/student_controller.dart';
import '../base_screen.dart';
import 'widgets/header_student_widget.dart';
import 'widgets/student_widget.dart';

class StudentScreen extends GetView<StudentController> {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: const Column(
          children: [
            /// Header Part
            HeaderStudentWidget(),
            SizedBox(
              height: 20,
            ),

            Expanded(
              child: RepaintBoundary(
                child: StudentWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
