import 'package:control_system/Data/Models/user/users_res/user_res_model.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';

// ignore: must_be_immutable
class AddRoleUser extends GetView<AdminController> {
  const AddRoleUser({super.key, required this.userResModel});
  final UserResModel userResModel;
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
            const Text(
              'Add Role to User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GetBuilder<AdminController>(builder: (_) {
              if (controller.isLodingGetRoles) {
                Expanded(
                  child: Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  ),
                );
              }

              if (controller.rolesList.isEmpty) {
                return Expanded(
                  child: Center(
                      child: Text(
                    'No items available',
                    style: nunitoBold.copyWith(
                      fontSize: 20,
                      color: ColorManager.bgSideMenu,
                    ),
                  )),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.rolesList.length,
                  itemBuilder: (context, index) {
                    final role = controller.rolesList[index];
                    final isChecked =
                        userResModel.userHasRoles!.roles!.contains(role.name);

                    return CheckboxListTile(
                      title: Text(role.name),
                      value: isChecked,
                      onChanged: (bool? value) {
                        if (value == true) {
                          //  userRoles.add(role.name);
                        } else {
                          //userRoles.remove(role.name);
                        }
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
