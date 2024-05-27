import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/school_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/styles_manager.dart';
import 'package:control_system/presentation/views/schools/Widgets/add_grade_to_school.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<SchoolController>(builder: (_) {
              return SizedBox(
                width: size.width * 0.3,
                child: Text(
                  controller.selectedSchoolIndex == -1
                      ? "Please select school"
                      : "School (${controller.selectedSchoolName})",
                  style: nunitoRegular.copyWith(
                    color: ColorManager.bgSideMenu,
                    fontSize: 23,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }),
            IconButton(
              tooltip: "Add New Grade",
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
              icon: const Icon(Icons.add),
            )
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
            child: GetBuilder<SchoolController>(builder: (controller) {
              return controller.selectedSchoolIndex == -1
                  ? Center(
                      child: Text(
                      "Please select a school",
                      style: nunitoRegular.copyWith(
                        color: ColorManager.bgSideMenu,
                        fontSize: 25,
                      ),
                    ))
                  : controller.isLoadingGrades
                      ? const Center(child: CircularProgressIndicator())
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
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
            }),
          ),
        ),
      ],
    );
  }
}
