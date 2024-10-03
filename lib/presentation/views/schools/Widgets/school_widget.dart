import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/profile_controller.dart';
import '../../../../domain/controllers/school_controller.dart';

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
            return Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                controller.selectedSchoolIndex == -1
                    ? "Choose a school"
                    : "School ${controller.selectedSchoolName}",
                style: nunitoRegular.copyWith(
                  color: ColorManager.bgSideMenu,
                  fontSize: 25,
                ),
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
                return GetBuilder<ProfileController>(
                  builder: (selectSchool) => selectSchool.cachedUserProfile!
                          .userHasSchoolsResModel!.schoolId!.isEmpty
                      ? const Center(child: Text("No schools found"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectSchool.cachedUserProfile!
                              .userHasSchoolsResModel!.schoolId!.length,
                          itemBuilder: (context, index) {
                            var schoolName = selectSchool.cachedUserProfile!
                                .userHasSchoolsResModel!.schoolName![index];

                            var schoolType = selectSchool
                                .cachedUserProfile!
                                .userHasSchoolsResModel!
                                .schoolType![index]
                                .name;
                            bool isSelected =
                                index == controller.selectedSchoolIndex;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  controller.updateSelectedSchool(
                                    index,
                                    selectSchool
                                        .cachedUserProfile!
                                        .userHasSchoolsResModel!
                                        .schoolId![index],
                                    schoolName,
                                  );
                                  controller.getGradesBySchoolId();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isSelected
                                        ? Colors.blue
                                        : ColorManager.bgSideMenu,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "$schoolName ($schoolType)",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
