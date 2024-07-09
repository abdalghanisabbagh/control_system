import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../Data/Models/school/school_response/school_res_model.dart';
import '../../../../domain/controllers/school_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';

class SelectSchoolForm extends GetView<SchoolController> {
  const SelectSchoolForm({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          height: size.height *
              (size.height > 770
                  ? 0.7
                  : size.height > 670
                      ? 0.8
                      : 0.9),
          width: 500,
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
                    builder: (controller) => controller.isLoadingSchools
                        ? Center(
                            child: LoadingIndicators.getLoadingIndicator(),
                          )
                        : controller.schools.isEmpty
                            ? const Center(child: Text('No Schools available'))
                            : Center(
                                child: ListView.builder(
                                  itemCount: controller.schools.length,
                                  itemBuilder: (context, index) {
                                    SchoolResModel currentSchool =
                                        controller.schools[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorManager.bgSideMenu,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorManager.white
                                                  .withOpacity(0.2),
                                              spreadRadius: 4,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.school,
                                            color: ColorManager.white,
                                          ),
                                          focusColor: ColorManager.bgSideMenu,
                                          hoverColor: ColorManager.bgSideMenu,
                                          onTap: () async {
                                            MyFlashBar.showSuccess(
                                              currentSchool.name!,
                                              "School Selected",
                                            ).show(context);
                                            await Future.delayed(
                                                Durations.long2);
                                            await controller
                                                .saveToSchoolBox(currentSchool)
                                                .then((_) {
                                              context.goNamed(
                                                AppRoutesNamesAndPaths
                                                    .dashBoardScreenName,
                                              );
                                            });
                                          },
                                          title: Text(
                                            "${currentSchool.schoolType!.name ?? ""} ${currentSchool.name ?? ""}",
                                            style: nunitoRegularStyle(
                                              color: ColorManager.white,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
