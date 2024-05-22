import 'package:control_system/domain/controllers/school_controller.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationSystemWidget extends GetView<SchoolController> {
  const EducationSystemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
              return controller.schools.isEmpty
                  ? const Center(
                      child: Text("No Schools"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.schools.length,
                      itemBuilder: (context, index) {
                        var school = controller.schools[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // controller.updateSelectedGrade(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorManager.bgSideMenu,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                      "${school.schoolType?.name}  ${school.name}"),
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
