import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/user/users_res/user_res_model.dart';
import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';

// ignore: must_be_immutable
class AddSchoolUser extends GetView<AdminController> {
  final UserResModel userResModel;

  const AddSchoolUser({super.key, required this.userResModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.25,
      height: Get.height * 0.55,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Add School to User',
                style: nunitoBold.copyWith(
                  fontSize: 25,
                  color: ColorManager.bgSideMenu,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            GetBuilder<AdminController>(builder: (_) {
              if (controller.isloadingGetSchools) {
                return Expanded(
                  child: Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                );
              }

              if (controller.schoolsList.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No items available',
                      style: nunitoBold.copyWith(
                        fontSize: 20,
                        color: ColorManager.bgSideMenu,
                      ),
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: controller.schoolsList.length,
                  itemBuilder: (context, index) {
                    final school = controller.schoolsList[index];
                    final isChecked =
                        controller.selectedSchoolID.contains(school.iD);

                    return CheckboxListTile(
                      title: Text(
                          '${school.schoolType!.name}' ' ' '${school.name}'),
                      value: isChecked,
                      onChanged: (bool? value) {
                        if (value == true) {
                          controller.selectedSchoolID.add(school.iD!);
                        } else {
                          controller.selectedSchoolID.remove(school.iD!);
                        }
                        controller.update();
                      },
                    );
                  },
                ),
              );
            }),
            GetBuilder<AdminController>(builder: (_) {
              if (controller.isLodingEditUserSchools) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedBackButton(
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedEditButton(
                      onPressed: () {
                        controller
                            .editUserSchool(userResModel.iD!)
                            .then((value) {
                          if (value) {
                            Get.back();
                            MyFlashBar.showSuccess(
                              "User Roles Updated",
                              "Success",
                            ).show(Get.key.currentContext!);
                          }
                        });
                      },
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
