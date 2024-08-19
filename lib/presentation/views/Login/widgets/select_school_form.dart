import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/user_has_schools_controller.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

class SelectSchoolForm extends GetView<UserHasSchoolsController> {
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
                  child: GetBuilder<UserHasSchoolsController>(
                    builder: (controller) =>
                        controller.userHasSchoolsResModel!.schoolId!.isEmpty
                            ? const Center(child: Text('No Schools available'))
                            : Center(
                                child: ListView.builder(
                                  itemCount: controller
                                      .userHasSchoolsResModel!.schoolId!.length,
                                  itemBuilder: (context, index) {
                                    (String, int) currentSchool = (
                                      controller.userHasSchoolsResModel!
                                          .schoolName![index],
                                      controller.userHasSchoolsResModel!
                                          .schoolId![index]
                                    );
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
                                          leading: const Icon(
                                            Icons.school,
                                            color: ColorManager.white,
                                          ),
                                          focusColor: ColorManager.bgSideMenu,
                                          hoverColor: ColorManager.bgSideMenu,
                                          onTap: () async {
                                            controller.update();
                                            MyFlashBar.showSuccess(
                                              currentSchool.$1,
                                              "School Selected",
                                            ).show(context);
                                            // await Future.delayed(
                                            //     Durations.long2);
                                            // await controller
                                            //     .(currentSchool)
                                            //     .then(
                                            //   (_) {
                                            //     context.mounted
                                            //         ? context.goNamed(
                                            //             AppRoutesNamesAndPaths
                                            //                 .dashBoardScreenName,
                                            //           )
                                            //         : Get.key.currentContext
                                            //             ?.goNamed(
                                            //             AppRoutesNamesAndPaths
                                            //                 .dashBoardScreenName,
                                            //           );
                                            //   },
                                            // );
                                          },
                                          // title: Text(
                                          //   "${currentSchool.schoolType!.name ?? ""} ${currentSchool.name ?? ""}",
                                          //   style: nunitoRegularStyle(
                                          //     color: ColorManager.white,
                                          //     fontSize: 16,
                                          //   ),
                                          // ),
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
