import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

import '../../../domain/controllers/class_room_controller.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../resource_manager/ReusableWidget/my_back_button.dart';
import '../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../resource_manager/validations.dart';
import 'widgets/render_seat_widget.dart';

class ClassRoomSeatsScreen extends GetView<ClassRoomController> {
  final TextEditingController classNameController = TextEditingController();

  final TextEditingController classNumber = TextEditingController();
  final TextEditingController columnNumber = TextEditingController(text: "0");
  final TextEditingController floorNameController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ClassRoomSeatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassRoomController>(
      builder: (_) {
        return controller.isLoadingAddClassRoom
            ? Center(
                child: LoadingIndicators.getLoadingIndicator(),
              )
            : Form(
                key: _formKey,
                child: Scaffold(
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
                                      myValidation:
                                          Validations.requiredValidator,
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
                                      controller: classNumber,
                                      title: "Class Number",
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
                                      myValidation:
                                          Validations.requiredValidator,
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
                                      myValidation:
                                          Validations.requiredValidator,
                                      isNumber: true,
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
                                myValidation: Validations.requiredValidator,
                                enableBorderColor: ColorManager.primary,
                                controller: columnNumber,
                                title: "Number of Rows",
                                onChanged: (value) {
                                  controller.numbers =
                                      int.tryParse(value!) ?? 0;
                                  controller.classSeats.clear();
                                  controller.classSeats = List.generate(
                                      controller.numbers, (int _) => 0);
                                  controller.update();
                                  return value;
                                },
                              ),
                              GetBuilder<ClassRoomController>(
                                builder: (_) => controller.numbers < 1
                                    ? const SizedBox.shrink()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                                myValidation: Validations
                                                    .requiredValidator,
                                                onChanged: (value) {
                                                  if (value == '') {
                                                    controller
                                                        .classSeats[index] = 0;
                                                  } else {
                                                    controller
                                                            .classSeats[index] =
                                                        int.parse(value!);
                                                  }
                                                  return value;
                                                },
                                                controller: rowNumper,
                                                title:
                                                    "'numper of ${index + 1} column'",
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
                                  controller.count = 1;
                                  _formKey.currentState!.validate()
                                      ? controller.update(['classSeats'])
                                      : null;
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
                                      style: nunitoRegular.copyWith(
                                          color: ColorManager.white),
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
                            int maxCapacity =
                                int.parse(maxCapacityController.text);
                            int renderCapacity = controller.classSeats
                                .fold(0, (int p, c) => p + c);
                            if (renderCapacity == maxCapacity) {
                              _formKey.currentState!.validate()
                                  ? await controller
                                      .addNewClass(
                                      name: classNameController.text,
                                      maxCapacity: maxCapacity.toString(),
                                      floorName: floorNameController.text,
                                      rows: controller.classSeats,
                                      columns:
                                          int.tryParse(columnNumber.text) ?? 0,
                                    )
                                      .then(
                                      (value) {
                                        value
                                            ? {
                                                controller.numbers = 0,
                                                controller.classSeats.clear(),
                                                classNameController.clear(),
                                                floorNameController.clear(),
                                                maxCapacityController.clear(),
                                                columnNumber.clear(),
                                                classNumber.clear(),
                                                controller.update(),
                                                window.history.go(-1),
                                              }
                                            : null;
                                      },
                                    )
                                  : null;
                              controller.numbers = 0;
                            } else {
                              MyAwesomeDialogue(
                                title: "Class Create",
                                desc: "capacity not equal",
                                dialogType: DialogType.error,
                              ).showDialogue(context);
                            }
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                                    style: nunitoRegular.copyWith(
                                        color: ColorManager.white),
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
                ),
              );
      },
    );
  }
}
