import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/profile_controller.dart';
import '../../../../domain/controllers/students_controllers/student_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';
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
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '1300',
              ),
              child: IconButton(
                tooltip: "Promote Students From Excel",
                icon: const Icon(FontAwesomeIcons.arrowUpFromGroundWater),
                onPressed: () {
                  controller.isImportedPromote = true;
                  controller.isImportedNew = false;
                  controller.pickAndReadFile();
                },
              ),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '1600',
              ),
              child: IconButton(
                  tooltip: "Download excel template",
                  icon: const Icon(FontAwesomeIcons.cloudArrowDown),
                  onPressed: () {
                    controller.downloadTemp();
                  }),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '1200',
              ),
              child: IconButton(
                tooltip: "Import From Excel",
                icon: const Icon(FontAwesomeIcons.fileExcel),
                onPressed: () {
                  controller.isImportedNew = true;
                  controller.isImportedPromote = false;
                  controller.pickAndReadFile();
                },
              ),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '1700',
              ),
              child: IconButton(
                  tooltip: "Export To Excel",
                  icon: const Icon(FontAwesomeIcons.fileExport),
                  onPressed: () {
                    controller.exportToCsv(context, controller.studentsRows);
                  }),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '1100',
              ),
              child: IconButton(
                tooltip: "Add New Student",
                icon: const Icon(FontAwesomeIcons.userPlus),
                onPressed: () {
                  MyDialogs.showDialog(context, AddSingleStudentWidget());
                },
              ),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '1400',
              ),
              child: IconButton(
                tooltip: "Sync Students",
                icon: const Icon(FontAwesomeIcons.rotate),
                onPressed: () {
                  controller.onInit();
                },
              ),
            ),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '1500',
              ),
              child: IconButton(
                tooltip: "Send To DataBase",
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (!controller.isImportedNew &&
                      !controller.isImportedPromote) {
                    MyAwesomeDialogue(
                      title: "Error",
                      desc: "Please import File first",
                      dialogType: DialogType.error,
                    ).showDialogue(context);
                  } else if (controller.hasErrorInGrade) {
                    MyAwesomeDialogue(
                      title: "Error",
                      desc: "Please check your Grade",
                      dialogType: DialogType.error,
                    ).showDialogue(context);
                  } else if (controller.hasErrorInClassRoom) {
                    MyAwesomeDialogue(
                      title: "Error",
                      desc: "Please check your Class Room",
                      dialogType: DialogType.error,
                    ).showDialogue(context);
                  } else if (controller.hasErrorInCohort) {
                    MyAwesomeDialogue(
                      title: "Error",
                      desc: "Please check your Cohort",
                      dialogType: DialogType.error,
                    ).showDialogue(context);
                  } else if (controller.hasError.isNotEmpty) {
                    MyAwesomeDialogue(
                      title: "Error",
                      desc: "Please check your values",
                      dialogType: DialogType.error,
                    ).showDialogue(context);
                  } else if (controller.hasErrorInBlbId) {
                    MyAwesomeDialogue(
                      title: "Error",
                      desc: "Please check your Blb Id",
                      dialogType: DialogType.error,
                    ).showDialogue(context);
                  } else {
                    if (controller.isImportedNew) {
                      controller
                          .addManyStudents(students: controller.students)
                          .then((value) {
                        if (value) {
                          MyAwesomeDialogue(
                            title: "Success",
                            desc: "Students Added Successfully",
                            dialogType: DialogType.success,
                          ).showDialogue(context.mounted
                              ? context
                              : Get.key.currentContext!);
                        }
                      });
                    } else if (controller.isImportedPromote) {
                      controller
                          .updateManyStudents(students: controller.students)
                          .then((value) {
                        if (value) {
                          MyAwesomeDialogue(
                            title: "Success",
                            desc: "Students Promoted Successfully",
                            dialogType: DialogType.success,
                          ).showDialogue(context.mounted
                              ? context
                              : Get.key.currentContext!);
                        }
                      });
                    }
                  }
                },
              ),
            ),
          }
        ],
      ),
    );
  }
}
