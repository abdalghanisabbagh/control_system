import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/views/roles/widgets/front_id_screen.dart';
import 'package:control_system/presentation/views/roles/widgets/role_widget.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/profile_controller.dart';
import '../../../domain/controllers/roles_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../base_screen.dart';
import 'widgets/add_new_roles_widget.dart';
import 'widgets/add_new_screen_widget.dart';
import 'widgets/screen_widget.dart';

class RolesScreen extends GetView<RolesController> {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeaderWidget(text: "Roles"),
                      Visibility(
                        visible: Get.find<ProfileController>()
                            .canAccessWidget(widgetId: '11200'),
                        child: InkWell(
                          onTap: () {
                            MyDialogs.showDialog(
                              context,
                              AddNewRolesWidget(),
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
                                  "Add New Roles",
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
                    ],
                  ),
                  MytextFormFiled(
                    title: 'Search Roles',
                    controller: controller.searchRolesController,
                    onChanged: (value) {
                      controller.serachInRoles(value!);
                      return value;
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GetBuilder<RolesController>(
                        builder: (controller) {
                          if (controller.getAllLoading) {
                            return Center(
                              child: LoadingIndicators.getLoadingIndicator(),
                            );
                          } else if (controller.filteredRoles.isEmpty) {
                            return Center(
                              child: Text(
                                "No Roles Found",
                                style: nunitoBold.copyWith(
                                    color: ColorManager.black),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: controller.filteredRoles.length,
                              itemBuilder: (context, index) {
                                var role = controller.filteredRoles[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: CustomRoleCardWidget(
                                    roleName: role.name!,
                                    isSelected:
                                        controller.selectedRoleId == role.id!,
                                    onSelect: () {
                                      controller.setSelectedRole(role.id!);

                                    },
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: HeaderWidget(text: "Screens"),
                        ),
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Visibility(
                            visible:
                                Get.find<ProfileController>().canAccessWidget(
                              widgetId: '11100',
                            ),
                            child: InkWell(
                              onTap: () {
                                MyDialogs.showDialog(
                                  context,
                                  AddNewScreenWidget(),
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
                                      "Add New Screen",
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
                      ),
                    ],
                  ),
                  MytextFormFiled(
                    title: 'Search Screens By Name Or Front Id',
                    controller: controller.searchScreensController,
                    onChanged: (value) {
                      controller.searchWithinFilteredScreens(value!);
                      return value;
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GetBuilder<RolesController>(
                        builder: (_) {
                          if (controller.getAllLoading) {
                            return Center(
                              child: LoadingIndicators.getLoadingIndicator(),
                            );
                            // } else if (controller.selectedRoleId == null) {
                            //   return Center(
                            //     child: Text(
                            //       "please select a role first",
                            //       style: nunitoBold.copyWith(
                            //         color: ColorManager.bgSideMenu,
                            //       ),
                            //     ),
                            //   );
                          } else if (controller.filteredScreens.isEmpty) {
                            return Center(
                              child: Text(
                                "No Screens Available",
                                style: nunitoBold.copyWith(
                                  color: ColorManager.bgSideMenu,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: controller.filteredScreens.length,
                              itemBuilder: (context, index) {
                                var screen = controller.filteredScreens[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ScreenSideMenu(
                                    color: screen.color ?? Colors.grey,
                                    frontId: screen.frontId,
                                    screenName: screen.name,
                                    isSelected: controller.selectedScreenId ==
                                        screen.id,
                                    screenId: screen.id,
                                    onSelect: () async {
                                      await controller.setSelectedScreen(
                                          screen.id, screen.frontId);
                                      controller.filterWidgets();
                                      controller.filterColorScreen();
                                    },
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: HeaderWidget(text: "Actions"),
                        ),
                      ),
                    ],
                  ),
                  MytextFormFiled(
                    title: 'Search Widgets By Name Or Front Id',
                    controller: controller.searchWidgetsController,
                    onChanged: (value) {
                      controller.searchWithinFilteredWidgets(value!);
                      return value;
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GetBuilder<RolesController>(
                        builder: (_) {
                          // if (controller.selectedRoleId == null) {
                          //   return Center(
                          //     child: Text(
                          //       "Please Select Role ",
                          //       style: nunitoBold.copyWith(
                          //         color: ColorManager.bgSideMenu,
                          //       ),
                          //     ),
                          //   );
                          // }

                          if (controller.lastSelectedFrontId == null) {
                            return Center(
                              child: Text(
                                "Please Select Screen ",
                                style: nunitoBold.copyWith(
                                  color: ColorManager.bgSideMenu,
                                ),
                              ),
                            );
                          }
                          if (controller.widgets.isEmpty) {
                            return Center(
                              child: Text(
                                "No Screens Available",
                                style: nunitoBold.copyWith(
                                  color: ColorManager.bgSideMenu,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: controller.widgets.length,
                              itemBuilder: (context, index) {
                                var widget = controller.widgets[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: FrontIdScreen(
                                    color: controller.includedActions
                                            .contains(widget.id)
                                        ? Colors.green
                                        : Colors.white,
                                    widgetName: widget.name,
                                    frontId: widget.frontId,
                                    id: widget.id,
                                    included: controller.includedActions
                                        .contains(widget.id),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
