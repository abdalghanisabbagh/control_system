import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/class_room_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_back_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../resource_manager/ReusableWidget/header_widget.dart';
import 'widgets/render_seat_widget.dart';

class ClassRoomSeatsScreen extends GetView<ClassRoomController> {
  final TextEditingController columnNumper = TextEditingController(text: "0");
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController buildingNameController = TextEditingController();
  final TextEditingController floorNameController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();

  ClassRoomSeatsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyBackButton(),
                HeaderWidget(text: "Add New Class"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MytextFormFiled(
                          controller: classNameController,
                          title: "Class Name",
                          enableBorderColor: ColorManager.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: MytextFormFiled(
                          controller: buildingNameController,
                          title: "Building",
                          enableBorderColor: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MytextFormFiled(
                          controller: floorNameController,
                          title: "FLoor",
                          enableBorderColor: ColorManager.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: MytextFormFiled(
                          enableBorderColor: ColorManager.primary,
                          controller: maxCapacityController,
                          title: "Max Capacity",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MytextFormFiled(
                    enableBorderColor: ColorManager.primary,
                    controller: columnNumper,
                    isPrice: true,
                    title: "Number of Row",
                    onChange: (value) {
                      controller.numbers = int.tryParse(value!) ?? 0;
                      controller.classSeats.clear();
                      controller.classSeats =
                          List.generate(controller.numbers, (int _) => 0);
                      controller.update();
                      return value;
                    },
                  ),
                  GetBuilder<ClassRoomController>(
                    builder: (_) => controller.numbers < 1
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.numbers,
                            itemBuilder: (context, index) {
                              TextEditingController rowNumper =
                                  TextEditingController();
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MytextFormFiled(
                                    onChange: (value) {
                                      if (value == '') {
                                        controller.classSeats[index] = 0;
                                      } else {
                                        controller.classSeats[index] =
                                            int.parse(value!);
                                      }
                                      return value;
                                    },
                                    controller: rowNumper,
                                    title: "'numper of ${index + 1} column'",
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      controller.update();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.bgSideMenu,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Center(
                        child: Text(
                          "Render Seats and generate seats ID",
                          style:
                              nunitoRegular.copyWith(color: ColorManager.white),
                        ),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
            RendarSeats(
              seatsNumbers: const [],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                int maxCapacity = int.parse(maxCapacityController.text);
                int renderCapacity =
                    controller.classSeats.fold(0, (int p, c) => p + c);

                if (renderCapacity == maxCapacity) {
                  await controller
                      .addNewClass(
                        name: classNameController.text,
                        maxCapacity: maxCapacity.toString(),
                        floorName: floorNameController.text,
                        rows: controller.classSeats,
                        columns: int.tryParse(columnNumper.text) ?? 0,
                      )
                      .then(
                        (value) => value
                            ? {
                                MyFlashBar.showSuccess(
                                  "Class has been Added",
                                  "Class Create",
                                ).show(context),
                                controller.numbers = 0,
                                controller.classSeats.clear(),
                                classNameController.clear(),
                                floorNameController.clear(),
                                maxCapacityController.clear(),
                                columnNumper.clear(),
                                buildingNameController.clear(),
                                controller.update(),
                              }
                            : MyFlashBar.showError(
                                "Class Not Created",
                                "Class Create",
                              ).show(context),
                      );
                  controller.numbers = 0;
                } else {
                  MyAwesomeDialogue(
                    title: "Class Create",
                    desc: "capacity not equal",
                    dialogType: DialogType.error,
                  ).showDialogue(context);
                  log("$maxCapacity  :: $renderCapacity");
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 55,
                    width: 150,
                    decoration: BoxDecoration(
                      color: ColorManager.bgSideMenu,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Center(
                      child: Text(
                        "Add Class",
                        style:
                            nunitoRegular.copyWith(color: ColorManager.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
