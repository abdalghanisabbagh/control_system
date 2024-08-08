import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

import '../../../domain/controllers/profile_controller.dart';
import '../../../domain/controllers/roles_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../base_screen.dart';
import 'widgets/add_new_roles_widget.dart';
import 'widgets/add_new_screen_widget.dart';
import 'widgets/add_screen_to_role_widget.dart';

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
                            padding: const EdgeInsets.all(5),
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
                                        ? Center(
                                            child: Text(
                                              "No Roles Found",
                                              style: nunitoBold.copyWith(
                                                color: ColorManager.black,
                                              ),
                                            ),
                                          )
                                        : Scrollbar(
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            controller: controller
                                                .rolesScrollController,
                                            child:
                                                TransformableListView.builder(
                                              getTransformMatrix:
                                                  controller.getTransformMatrix,
                                              controller: controller
                                                  .rolesScrollController,
                                              itemCount:
                                                  controller.roles.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  color:
                                                      ColorManager.rolesColors[
                                                          index %
                                                              ColorManager
                                                                  .rolesColors
                                                                  .length],
                                                  elevation: 10,
                                                  child: ListTile(
                                                    title: Text(
                                                      controller
                                                          .roles[index].name,
                                                      style:
                                                          nunitoBold.copyWith(
                                                        fontSize: 22,
                                                        color:
                                                            ColorManager.black,
                                                      ),
                                                    ),
                                                    trailing: Visibility(
                                                      visible: Get.find<
                                                              ProfileController>()
                                                          .canAccessWidget(
                                                        widgetId: '11100',
                                                      ),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF003366),
                                                        ),
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
                                            ),
                                          );
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
                            padding: const EdgeInsets.all(5),
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
                                        : Scrollbar(
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            controller: controller
                                                .screensScrollController,
                                            child:
                                                TransformableListView.builder(
                                              getTransformMatrix:
                                                  controller.getTransformMatrix,
                                              controller: controller
                                                  .screensScrollController,
                                              itemCount:
                                                  controller.screens.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  margin: const EdgeInsets.only(
                                                    left: 5,
                                                    top: 5,
                                                    bottom: 5,
                                                    right: 20,
                                                  ),
                                                  color: ColorManager
                                                          .screensColors[
                                                      index %
                                                          ColorManager
                                                              .screensColors
                                                              .length],
                                                  elevation: 10,
                                                  child: ListTile(
                                                    title: Text(
                                                      controller
                                                          .screens[index].name,
                                                      style:
                                                          nunitoBold.copyWith(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      controller.screens[index]
                                                          .frontId,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
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
