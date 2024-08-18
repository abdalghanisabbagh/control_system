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
import 'widgets/role_card_widget.dart';
import 'widgets/screen_card_widget.dart';

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
                                return controller.rolesLoading
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
                                            child: ListView.builder(
                                              controller: controller
                                                  .rolesScrollController,
                                              itemCount:
                                                  controller.roles.length,
                                              itemBuilder: (context, index) {
                                                return RoleCardWidget(
                                                  index: index,
                                                ).paddingOnly(right: 15);
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
                                  visible: Get.find<ProfileController>()
                                      .canAccessWidget(
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
                                                return ScreenCardWidget(
                                                  index: index,
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
