import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../app/extensions/device_type_extension.dart';
import '../../../../domain/controllers/studentsController/student_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/index.dart';
import 'add_single_student_widget.dart';

class HeaderStudentWidget extends GetView<StudentController> {
  const HeaderStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            'Students',
            style: nunitoBlack.copyWith(
              color: ColorManager.bgSideMenu,
              fontSize: 30,
            ),
          ),
          if (context.isDesktop) ...{
            const Spacer(),
            IconButton(
              tooltip: "Promot Students From Excel",
              icon: const Icon(FontAwesomeIcons.arrowUpFromGroundWater),
              onPressed: () {
              },
            ),
            IconButton(
              tooltip: "Download excel template",
              icon: const Icon(FontAwesomeIcons.cloudArrowDown),
              onPressed: () {
                // controller.downloadeTemp();
              },
            ),
            IconButton(
              tooltip: "Import From Excel",
              icon: const Icon(FontAwesomeIcons.fileExcel),
              onPressed: () {
                controller.pickAndReadFile();
              },
            ),
            IconButton(
              tooltip: "Add New Student",
              icon: const Icon(FontAwesomeIcons.userPlus),
              onPressed: () {
                MyDialogs.showDialog(context, AddSingleStudentWidget());
              },
            ),
            IconButton(
              tooltip: "Sync Students",
              icon: const Icon(FontAwesomeIcons.rotate),
              onPressed: () {
                
                controller.onInit();
                // MyDialogs.showDialog(context, EditStudentWidget());
              },
            ),
            IconButton(
              tooltip: "Send To DataBase",
              icon: const Icon(Icons.send),
              onPressed: () {
                controller.addManyStudents(students: controller.students);
              },
            ),
          }
        ],
      ),
    );
  }
}
