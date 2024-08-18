import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/controllers/profile_controller.dart';
import '../../../domain/controllers/subject/subject_controller.dart';
import '../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../base_screen.dart';
import "widgets/add_subject_widget.dart";
import 'widgets/subjects_widget.dart';

class SubjectSettingScreen extends GetView<SubjectsController> {
  const SubjectSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: GetBuilder<SubjectsController>(
        builder: (_) {
          return Container(
            color: ColorManager.bgColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Subject",
                        style: nunitoBlack.copyWith(
                          color: ColorManager.bgSideMenu,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: Get.find<ProfileController>().canAccessWidget(
                        widgetId: '7400',
                      ),
                      child: Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            context.goNamed(
                              AppRoutesNamesAndPaths.oprerationsScreenName,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.bgSideMenu,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Operation",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Visibility(
                      visible: Get.find<ProfileController>().canAccessWidget(
                        widgetId: '7100',
                      ),
                      child: Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Add New Subject",
                              titleStyle: nunitoRegular.copyWith(
                                color: ColorManager.bgSideMenu,
                                fontSize: 25,
                              ),
                              content: AddSubjectWidget(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.glodenColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Add Subject",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: SubjectsWidget(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
