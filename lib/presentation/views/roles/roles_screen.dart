import 'package:control_system/domain/controllers/roles_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/views/roles/widgets/add_new_roles_widget.dart';
import 'package:control_system/presentation/views/roles/widgets/add_screen_to_role_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/profile_controller.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/color_manager.dart';
import '../../resource_manager/styles_manager.dart';
import '../base_screen.dart';
import 'widgets/add_new_screen_widget.dart';

class RolesScreen extends GetView<RolesController> {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
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
                              visible:
                                  Get.find<ProfileController>().canAccessWidget(
                                widgetId: '11200',
                              ),
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
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GetBuilder<RolesController>(
                              builder: (controller) {
                                return controller.getAllLoading
                                    ? Center(
                                        child: LoadingIndicators
                                            .getLoadingIndicator(),
                                      )
                                    : controller.roles.isEmpty
                                        ? const Center(
                                            child: Text("No Roles Found"),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller.roles.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                color: Colors.grey,
                                                elevation: 10,
                                                child: ListTile(
                                                  title: Text(controller
                                                      .roles[index].name),
                                                  trailing: Visibility(
                                                    visible: Get.find<
                                                            ProfileController>()
                                                        .canAccessWidget(
                                                      widgetId: '11100',
                                                    ),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        MyDialogs.showDialog(
                                                          context,
                                                          AddScreensToRolesWidget(
                                                            role: controller
                                                                .roles[index],
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        "Add Screen",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HeaderWidget(text: "Screens"),
                            Visibility(
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
                          ],
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GetBuilder<RolesController>(
                              builder: (controller) {
                                return controller.getAllLoading
                                    ? Center(
                                        child: LoadingIndicators
                                            .getLoadingIndicator(),
                                      )
                                    : controller.screens.isEmpty
                                        ? const Center(
                                            child: Text("No Screens Found"),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.screens.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                color: Colors.grey,
                                                elevation: 10,
                                                child: ListTile(
                                                  title: Text(
                                                    controller
                                                        .screens[index].name,
                                                  ),
                                                  subtitle: Text(
                                                    controller
                                                        .screens[index].frontId,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
