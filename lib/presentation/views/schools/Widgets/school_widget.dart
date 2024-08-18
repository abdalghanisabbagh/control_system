import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/school_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';

class SchoolWidget extends GetView<SchoolController> {
  const SchoolWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<SchoolController>(
          builder: (_) {
            return Text(
              controller.selectedSchoolIndex == -1
                  ? "Choose a school"
                  : "School ${controller.selectedSchoolName}",
              style: nunitoRegular.copyWith(
                color: ColorManager.bgSideMenu,
                fontSize: 25,
              ),
            );
          },
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
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            child: GetBuilder<SchoolController>(
              builder: (_) {
                return controller.isLoadingSchools
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : controller.schools.isEmpty
                        ? const Center(child: Text("No schools found"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.schools.length,
                            itemBuilder: (context, index) {
                              var school = controller.schools[index];
                              bool isSelected =
                                  index == controller.selectedSchoolIndex;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.updateSelectedSchool(
                                        index, school.iD!);
                                    controller.getGradesBySchoolId();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isSelected
                                          ? Colors.blue
                                          : ColorManager.bgSideMenu,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "${school.schoolType?.name} ${school.name}",
                                      overflow: TextOverflow.ellipsis,
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
