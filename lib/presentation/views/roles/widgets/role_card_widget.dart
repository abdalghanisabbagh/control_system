import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/profile_controller.dart';
import '../../../../domain/controllers/roles_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import 'add_screen_to_role_widget.dart';

class RoleCardWidget extends GetView<RolesController> {
  final int index;

  const RoleCardWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RolesController>(
      builder: (_) {
        return Card(
          clipBehavior: Clip.antiAlias,
          color:
              ColorManager.rolesColors[index % ColorManager.rolesColors.length],
          elevation: 10,
          child: ExpansionTile(
            onExpansionChanged: (_) {
              controller.removedSreensIds.clear();
              controller.update();
            },
            title: Text(
              controller.searchRolesController.text.isEmpty
                  ? controller.roles[index].name!
                  : controller.roles
                      .where((role) => role.name!.toLowerCase().contains(
                          controller.searchRolesController.text.toLowerCase()))
                      .toList()[index]
                      .name!,
              overflow: TextOverflow.ellipsis,
              style: nunitoBold.copyWith(
                fontSize: 22,
                color: ColorManager.black,
              ),
            ),
            trailing: Visibility(
              visible: Get.find<ProfileController>().canAccessWidget(
                widgetId: '11100',
              ),
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF003366,
                        ),
                      ),
                      onPressed: () {
                        MyDialogs.showDialog(
                          context,
                          AddScreensToRolesWidget(
                            role: controller.roles[index],
                          ),
                        );
                      },
                      child: const Text(
                        "Add Screen",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            children: controller.roles[index].screens != null &&
                    controller.roles[index].screens!.isNotEmpty
                ? [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        controller.deleteScreenLoading
                            ? FittedBox(
                                fit: BoxFit.fill,
                                child: LoadingIndicators.getLoadingIndicator(),
                              ).paddingOnly(right: 25)
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.red,
                                ),
                                onPressed: () async {
                                  controller.removedSreensIds.isEmpty
                                      ? MyFlashBar.showError(
                                              'Please select at least one screen to delete',
                                              controller.roles[index].name!)
                                          .show(Get.key.currentContext!)
                                      : controller
                                          .deleteScreensFromRole(
                                              controller.roles[index].id!)
                                          .then(
                                          (isAdded) {
                                            if (isAdded) {
                                              Get.back();
                                              MyFlashBar.showSuccess(
                                                      'Screens removed from ${controller.roles[index].name}',
                                                      controller
                                                          .roles[index].name!)
                                                  .show(Get.key.currentContext);
                                            }
                                          },
                                        );
                                },
                                child: const Text(
                                  "Delete Screens",
                                ),
                              ).paddingOnly(right: 25),
                        const Divider(
                          color: ColorManager.black,
                        ),
                        CheckboxListTile(
                          value: controller.removedSreensIds.isEmpty
                              ? false
                              : controller.removedSreensIds.length ==
                                      controller.roles[index].screens!.length
                                  ? true
                                  : null,
                          tristate: true,
                          onChanged: (value) {
                            if (value ?? false) {
                              controller.removedSreensIds.addAll(controller
                                  .roles[index].screens!
                                  .map((e) => e.id));
                            } else {
                              controller.removedSreensIds.clear();
                            }
                            controller.update();
                          },
                          title: Row(
                            children: [
                              FittedBox(
                                child: Text(
                                  "Front Id",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FittedBox(
                                child: Text(
                                  "Screens",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ).paddingSymmetric(
                            horizontal: 10,
                          ),
                        ),
                      ],
                    ),
                    ...controller.roles[index].screens!.map(
                      (screen) => Column(
                        children: [
                          const Divider(
                            color: ColorManager.black,
                          ),
                          CheckboxListTile(
                            value:
                                controller.removedSreensIds.contains(screen.id),
                            onChanged: (value) {
                              if (value!) {
                                controller.removedSreensIds.add(screen.id);
                              } else {
                                controller.removedSreensIds.remove(screen.id);
                              }
                              controller.update();
                            },
                            title: Row(
                              children: [
                                FittedBox(
                                  child: Text(
                                    screen.frontId,
                                    style: nunitoBold.copyWith(
                                      color: ColorManager.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                FittedBox(
                                  child: Text(
                                    screen.name,
                                    style: nunitoBold.copyWith(
                                      color: ColorManager.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(
                              horizontal: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ]
                : [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No Screens Found For This Role',
                      style: nunitoBold.copyWith(
                        color: ColorManager.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
          ),
        );
      },
    );
  }
}
