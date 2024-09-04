import 'package:control_system/Data/Models/school/school_response/school_res_model.dart';
import 'package:control_system/Data/Models/school/school_type/school_type_model.dart';
import 'package:control_system/domain/controllers/profile_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/loading_indicators.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/school_controller.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';

class SelectSchoolForm extends GetView<ProfileController> {
  const SelectSchoolForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          width: 420,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Your School",
                    style: nunitoBoldStyle(
                      color: ColorManager.black,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: GetBuilder<SchoolController>(
                      init: SchoolController(),
                      builder: (schoolController) {
                        return schoolController.isLoading
                            ? Center(
                                child: LoadingIndicators.getLoadingIndicator(),
                              )
                            : GetBuilder<ProfileController>(
                                builder: (selectSchool) => selectSchool
                                        .cachedUserProfile!
                                        .userHasSchoolsResModel!
                                        .schoolId!
                                        .isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No Schools available',
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          children: List.generate(
                                            selectSchool
                                                .cachedUserProfile!
                                                .userHasSchoolsResModel!
                                                .schoolId!
                                                .length,
                                            (index) {
                                              final ({
                                                String name,
                                                int id,
                                                int schoolTypeId,
                                                SchoolTypeResModel? type
                                              }) currentSchool = (
                                                name: selectSchool
                                                    .cachedUserProfile!
                                                    .userHasSchoolsResModel!
                                                    .schoolName![index],
                                                id: selectSchool
                                                    .cachedUserProfile!
                                                    .userHasSchoolsResModel!
                                                    .schoolId![index],
                                                schoolTypeId: selectSchool
                                                    .cachedUserProfile!
                                                    .userHasSchoolsResModel!
                                                    .schoolTypeIds![index],
                                                type: selectSchool
                                                    .cachedUserProfile!
                                                    .userHasSchoolsResModel!
                                                    .schoolType![index],
                                              );
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorManager.bgSideMenu,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(25),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: ColorManager
                                                            .white
                                                            .withOpacity(0.2),
                                                        spreadRadius: 4,
                                                        blurRadius: 7,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: ListTile(
                                                    leading: const Icon(
                                                      Icons.school,
                                                      color: ColorManager.white,
                                                    ),
                                                    focusColor:
                                                        ColorManager.bgSideMenu,
                                                    hoverColor:
                                                        ColorManager.bgSideMenu,
                                                    onTap: () async {
                                                      schoolController
                                                          .isLoading = true;
                                                      schoolController.update();
                                                      MyFlashBar.showSuccess(
                                                        currentSchool.name,
                                                        "School Selected",
                                                      ).show(context);
                                                      await Future.delayed(
                                                          Durations.long2);
                                                      await schoolController
                                                          .saveToSchoolBox(
                                                        SchoolResModel(
                                                          iD: currentSchool.id,
                                                          name: currentSchool
                                                              .name,
                                                          schoolTypeID:
                                                              currentSchool
                                                                  .schoolTypeId,
                                                          schoolType:
                                                              currentSchool
                                                                  .type,
                                                        ),
                                                      )
                                                          .then(
                                                        (_) {
                                                          context.mounted
                                                              ? context.goNamed(
                                                                  AppRoutesNamesAndPaths
                                                                      .dashBoardScreenName,
                                                                )
                                                              : Get.key
                                                                  .currentContext
                                                                  ?.goNamed(
                                                                  AppRoutesNamesAndPaths
                                                                      .dashBoardScreenName,
                                                                );
                                                        },
                                                      );
                                                    },
                                                    title: Text(
                                                      "${currentSchool.name} (${currentSchool.type?.name})",
                                                      style: nunitoRegularStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
