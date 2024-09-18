import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/privileges_controller.dart';
import '../../../domain/controllers/profile_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../base_screen.dart';
import 'widgets/add_new_privileges_widget.dart';
import 'widgets/add_new_screen_widget.dart';
import 'widgets/front_id_screen.dart';
import 'widgets/privileges_widget.dart';
import 'widgets/screen_widget.dart';

class PrivilegesScreen extends GetView<PrivilegesController> {
  const PrivilegesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectedRoleId = null;
        controller.selectedScreenId = null;
        controller.lastSelectedFrontId = null;
        controller.includedActions = [];
        controller.filterColorScreen();
        controller.update();
      },
      child: BaseScreen(
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
                        const HeaderWidget(text: "Privileges"),
                        Expanded(
                          child: Visibility(
                            visible: Get.find<ProfileController>()
                                .canAccessWidget(widgetId: '11200'),
                            child: InkWell(
                              onTap: () {
                                MyDialogs.showDialog(
                                  context,
                                  AddNewPrivilegesWidget(),
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
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(
                                        "Add New Privileges",
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
                      title: 'Search Privileges',
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
                        child: GetBuilder<PrivilegesController>(
                          builder: (controller) {
                            if (controller.getAllLoading) {
                              return Center(
                                child: LoadingIndicators.getLoadingIndicator(),
                              );
                            } else if (controller.filteredRoles.isEmpty) {
                              return Center(
                                child: Text(
                                  "No Privileges Found",
                                  style: nunitoBold.copyWith(
                                      color: ColorManager.black),
                                ),
                              );
                            } else {
                              return PageStorage(
                                bucket: controller.previlegesPageStorageBucket,
                                key: controller.previlegesPageStorageKey,
                                child: ListView.builder(
                                  itemCount: controller.filteredRoles.length,
                                  itemBuilder: (context, index) {
                                    var role = controller.filteredRoles[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: CustomPrivilegeCardWidget(
                                        roleName: role.name!,
                                        isSelected: controller.selectedRoleId ==
                                            role.id!,
                                        onSelect: () {
                                          controller.setSelectedRole(role.id!);
                                        },
                                      ),
                                    );
                                  },
                                ),
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
                        child: GetBuilder<PrivilegesController>(
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
                              return PageStorage(
                                bucket: controller.screensPageStorageBucket,
                                key: controller.screensPageStorageKey,
                                child: ListView.builder(
                                  itemCount: controller.filteredScreens.length,
                                  itemBuilder: (context, index) {
                                    var screen =
                                        controller.filteredScreens[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: ScreenSideMenu(
                                        color: controller.selectedRoleId != null
                                            ? screen.color ?? Colors.grey
                                            : Colors.grey,
                                        frontId: screen.frontId,
                                        screenName: screen.name,
                                        isSelected:
                                            controller.selectedScreenId ==
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
                                ),
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
                      title: 'Search Actions By Name Or Front Id',
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
                        child: GetBuilder<PrivilegesController>(
                          builder: (_) {
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
                                  "No Actions Available",
                                  style: nunitoBold.copyWith(
                                    color: ColorManager.bgSideMenu,
                                  ),
                                ),
                              );
                            } else {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: controller.getAllLoading
                                    ? Center(
                                        child: LoadingIndicators
                                            .getLoadingIndicator(),
                                      )
                                    : PageStorage(
                                        bucket:
                                            controller.actionsPageStorageBucket,
                                        key: controller.actionsPageStorageKey,
                                        child: ListView.builder(
                                          key: ValueKey(controller
                                                  .lastSelectedFrontId
                                                  .toString() +
                                              controller.selectedRoleId
                                                  .toString()),
                                          itemCount: controller.widgets.length,
                                          itemBuilder: (context, index) {
                                            var widget =
                                                controller.widgets[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: FrontIdScreen(
                                                color: controller
                                                        .includedActions
                                                        .contains(widget.id)
                                                    ? Colors.green
                                                    : Colors.white,
                                                widgetName: widget.name,
                                                frontId: widget.frontId,
                                                id: widget.id,
                                                included: controller
                                                    .includedActions
                                                    .contains(widget.id),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
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
      ),
    );
  }
}
