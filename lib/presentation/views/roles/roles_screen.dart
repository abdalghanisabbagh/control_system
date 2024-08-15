import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

import '../../../domain/controllers/profile_controller.dart';
import '../../../domain/controllers/roles_controller.dart';
import '../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';
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
                                                return Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  color:
                                                      ColorManager.rolesColors[
                                                          index %
                                                              ColorManager
                                                                  .rolesColors
                                                                  .length],
                                                  elevation: 10,
                                                  child: ExpansionTile(
                                                    onExpansionChanged: (_) {
                                                      controller
                                                          .removedSreensIds
                                                          .clear();
                                                      controller.update();
                                                    },
                                                    title: Text(
                                                      controller
                                                          .roles[index].name!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      child: IntrinsicWidth(
                                                        child: Row(
                                                          children: [
                                                            ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                  0xFF003366,
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                MyDialogs
                                                                    .showDialog(
                                                                  context,
                                                                  AddScreensToRolesWidget(
                                                                    role: controller
                                                                            .roles[
                                                                        index],
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
                                                    children: controller
                                                                    .roles[
                                                                        index]
                                                                    .screens !=
                                                                null &&
                                                            controller
                                                                .roles[index]
                                                                .screens!
                                                                .isNotEmpty
                                                        ? [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                controller
                                                                        .deleteScreenLoading
                                                                    ? FittedBox(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        child: LoadingIndicators
                                                                            .getLoadingIndicator(),
                                                                      ).paddingOnly(
                                                                        right:
                                                                            25)
                                                                    : ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              ColorManager.red,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          controller.removedSreensIds.isEmpty
                                                                              ? MyFlashBar.showError('Please select at least one screen to delete', controller.roles[index].name!).show(Get.key.currentContext!)
                                                                              : controller.deleteScreensFromRole(controller.roles[index].id!).then(
                                                                                  (isAdded) {
                                                                                    if (isAdded) {
                                                                                      Get.back();
                                                                                      MyFlashBar.showSuccess('Screens removed from ${controller.roles[index].name}', controller.roles[index].name!).show(Get.key.currentContext);
                                                                                    }
                                                                                  },
                                                                                );
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Delete Screens",
                                                                        ),
                                                                      ).paddingOnly(
                                                                        right:
                                                                            25),
                                                                const Divider(
                                                                  color:
                                                                      ColorManager
                                                                          .black,
                                                                ),
                                                                CheckboxListTile(
                                                                  value: controller
                                                                          .removedSreensIds
                                                                          .isEmpty
                                                                      ? false
                                                                      : controller.removedSreensIds.length ==
                                                                              controller.roles[index].screens!.length
                                                                          ? true
                                                                          : null,
                                                                  tristate:
                                                                      true,
                                                                  onChanged:
                                                                      (value) {
                                                                    if (value ??
                                                                        false) {
                                                                      controller.removedSreensIds.addAll(controller
                                                                          .roles[
                                                                              index]
                                                                          .screens!
                                                                          .map((e) =>
                                                                              e.id));
                                                                    } else {
                                                                      controller
                                                                          .removedSreensIds
                                                                          .clear();
                                                                    }
                                                                    controller
                                                                        .update();
                                                                  },
                                                                  title: Row(
                                                                    children: [
                                                                      FittedBox(
                                                                        child:
                                                                            Text(
                                                                          "Front Id",
                                                                          style:
                                                                              nunitoBold.copyWith(
                                                                            color:
                                                                                ColorManager.black,
                                                                            fontSize:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Spacer(),
                                                                      FittedBox(
                                                                        child:
                                                                            Text(
                                                                          "Screens",
                                                                          style:
                                                                              nunitoBold.copyWith(
                                                                            color:
                                                                                ColorManager.black,
                                                                            fontSize:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ).paddingSymmetric(
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            ...controller
                                                                .roles[index]
                                                                .screens!
                                                                .map(
                                                              (screen) =>
                                                                  Column(
                                                                children: [
                                                                  const Divider(
                                                                    color: ColorManager
                                                                        .black,
                                                                  ),
                                                                  CheckboxListTile(
                                                                    value: controller
                                                                        .removedSreensIds
                                                                        .contains(
                                                                            screen.id),
                                                                    onChanged:
                                                                        (value) {
                                                                      if (value!) {
                                                                        controller
                                                                            .removedSreensIds
                                                                            .add(screen.id);
                                                                      } else {
                                                                        controller
                                                                            .removedSreensIds
                                                                            .remove(screen.id);
                                                                      }
                                                                      controller
                                                                          .update();
                                                                    },
                                                                    title: Row(
                                                                      children: [
                                                                        FittedBox(
                                                                          child:
                                                                              Text(
                                                                            screen.frontId,
                                                                            style:
                                                                                nunitoBold.copyWith(
                                                                              color: ColorManager.black,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const Spacer(),
                                                                        FittedBox(
                                                                          child:
                                                                              Text(
                                                                            screen.name,
                                                                            style:
                                                                                nunitoBold.copyWith(
                                                                              color: ColorManager.black,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ).paddingSymmetric(
                                                                      horizontal:
                                                                          10,
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
                                                              style: nunitoBold
                                                                  .copyWith(
                                                                color:
                                                                    ColorManager
                                                                        .black,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                  ),
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
