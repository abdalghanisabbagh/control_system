import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/profile_controller.dart';
import '../../../../domain/controllers/school_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';
import 'add_grade_to_school.dart';

class GradeSystemWidget extends GetView<SchoolController> {
  const GradeSystemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<SchoolController>(builder: (_) {
              return SizedBox(
                width: size.width * 0.25,
                child: Text(
                  controller.selectedSchoolIndex == -1
                      ? "Please select school"
                      : "School ${controller.selectedSchoolName}",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.bgSideMenu,
                    fontSize: 23,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }),
            Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '5200',
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      controller.selectedSchoolIndex == -1
                          ? MyAwesomeDialogue(
                                  title: "Error",
                                  desc: "please select a school",
                                  dialogType: DialogType.error)
                              .showDialogue(context)
                          : MyDialogs.showDialog(
                              context,
                              const AddNewGradeToSchool(),
                            );
                    },
                    label: const Text("Add New Grade"),
                    icon: const Icon(Icons.add)),
              ),
              // IconButton(
              //   tooltip: "Add New Grade",
              //   onPressed: () {
              //     controller.selectedSchoolIndex == -1
              //         ? MyAwesomeDialogue(
              //                 title: "Error",
              //                 desc: "please select a school",
              //                 dialogType: DialogType.error)
              //             .showDialogue(context)
              //         : MyDialogs.showDialog(
              //             context,
              //             const AddNewGradeToSchool(),
              //           );
              //   },
              //   icon: const Icon(Icons.add),
              // ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(2, 15), // changes position of shadow
                  ),
                ],
                color: ColorManager.ligthBlue,
                borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            child: GetBuilder<SchoolController>(
              builder: (controller) {
                return controller.selectedSchoolIndex == -1
                    ? Center(
                        child: Text(
                          "Please select a school",
                          style: nunitoRegular.copyWith(
                            color: ColorManager.bgSideMenu,
                            fontSize: 25,
                          ),
                        ),
                      )
                    : controller.isLoadingGrades
                        ? Center(
                            child: LoadingIndicators.getLoadingIndicator(),
                          )
                        : controller.grades.isEmpty
                            ? Center(
                                child: Text(
                                "No grades found",
                                style: nunitoRegular.copyWith(
                                  color: ColorManager.bgSideMenu,
                                  fontSize: 25,
                                ),
                              ))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.grades.length,
                                itemBuilder: (context, index) {
                                  var grade = controller.grades[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorManager.bgSideMenu,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Text(grade.name!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
              },
            ),
          ),
        ),
      ],
    );
  }
}
