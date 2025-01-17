import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Models/class_room/class_room_res_model.dart';
import '../../../../domain/controllers/class_room_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/elevated_edit_button.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/validations.dart';
import '../../class_room_seats/widgets/render_seat_widget.dart';

final _formKey = GlobalKey<FormState>();

class EditClassRoomWidget extends StatelessWidget {
  final TextEditingController classNameController = TextEditingController();

  final TextEditingController classNumberController = TextEditingController();
  final ClassRoomResModel classRoom;
  final TextEditingController columnNumber = TextEditingController();
  final TextEditingController floorNameController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();
  EditClassRoomWidget({super.key, required this.classRoom});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        height: context.height * 0.8,
        width: context.width * 0.8,
        child: GetBuilder<ClassRoomController>(
          builder: (controller) {
            return controller.isLoadingEditClassRoom
                ? Center(
                    child: LoadingIndicators.getLoadingIndicator(),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: GetBuilder<ClassRoomController>(
                      builder: (controller) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Edit ClassRoom",
                                      style: nunitoBold.copyWith(
                                        color: ColorManager.primary,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    tooltip: "Close",
                                    alignment: AlignmentDirectional.topEnd,
                                    color: Colors.black,
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      controller.count = 1;
                                      controller.numbers = 0;
                                      Get.back();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: MyTextFormFiled(
                                    myValidation: Validations
                                        .requiredWithoutSpecialCharacters,
                                    controller: classNameController
                                      ..text = classRoom.name ?? '',
                                    title: "Class Name",
                                    enableBorderColor: ColorManager.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MyTextFormFiled(
                                    isNumber: true,
                                    myValidation: Validations.requiredValidator,
                                    controller: classNumberController
                                      ..text = classRoom.classNumber.toString(),
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
                                  child: MyTextFormFiled(
                                    isNumber: true,
                                    myValidation: Validations.requiredValidator,
                                    controller: floorNameController
                                      ..text = classRoom.floor ?? '',
                                    title: "FLoor",
                                    enableBorderColor: ColorManager.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: MyTextFormFiled(
                                    myValidation: Validations.requiredValidator,
                                    isNumber: true,
                                    enableBorderColor: ColorManager.primary,
                                    controller: maxCapacityController
                                      ..text = classRoom.maxCapacity.toString(),
                                    title: "Max Capacity",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GetBuilder<ClassRoomController>(
                              builder: (controller) {
                                return MyTextFormFiled(
                                  myValidation: Validations.requiredValidator,
                                  enableBorderColor: ColorManager.primary,
                                  controller: columnNumber
                                    ..text = controller.numbers.toString(),
                                  isNumber: true,
                                  title: "Number of Row",
                                  onChanged: (value) {
                                    controller.numbers =
                                        int.tryParse(value!) ?? 0;
                                    controller.classSeats.clear();
                                    controller.classSeats = List.generate(
                                        controller.numbers, (int _) => 0);
                                    controller.update(['class_seats']);
                                    return value;
                                  },
                                );
                              },
                            ),
                            GetBuilder<ClassRoomController>(
                              id: 'class_seats',
                              builder: (controller) => controller.numbers < 1
                                  ? const SizedBox.shrink()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.numbers,
                                      itemBuilder: (context, index) {
                                        TextEditingController rowNumber =
                                            TextEditingController();
                                        return Column(
                                          children: [
                                            MyTextFormFiled(
                                              myValidation:
                                                  Validations.requiredValidator,
                                              isNumber: true,
                                              onChanged: (value) {
                                                if (value == '') {
                                                  controller.classSeats[index] =
                                                      0;
                                                } else {
                                                  controller.classSeats[index] =
                                                      int.parse(value!);
                                                }
                                                return value;
                                              },
                                              controller: rowNumber
                                                ..text =
                                                    '${controller.classSeats[index]}',
                                              title:
                                                  "'numper of ${index + 1} column'",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GetBuilder<ClassRoomController>(
                              builder: (controller) {
                                return InkWell(
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
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RenderSeats(
                              seatsNumbers: const [],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GetBuilder<ClassRoomController>(
                                    builder: (controller) {
                                      return ElevatedBackButton(
                                        onPressed: () {
                                          controller.count = 1;
                                          controller.numbers = 0;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: GetBuilder<ClassRoomController>(
                                    builder: (controller) {
                                      return ElevatedEditButton(
                                        onPressed: () async {
                                          _formKey.currentState!.validate()
                                              ? await controller
                                                  .editClassRoom(
                                                  id: classRoom.iD!,
                                                  name:
                                                      classNameController.text,
                                                  floorName:
                                                      floorNameController.text,
                                                  maxCapacity:
                                                      maxCapacityController
                                                          .text,
                                                  classNumber: int.tryParse(
                                                          classNumberController
                                                              .text) ??
                                                      0,
                                                  columns: controller.numbers,
                                                  rows: controller.classSeats,
                                                )
                                                  .then(
                                                  (value) {
                                                    controller.count = 1;
                                                    controller.numbers = 0;
                                                    value
                                                        ? {
                                                            Get.back(),
                                                            MyFlashBar
                                                                .showSuccess(
                                                              'The class has been updated successfully',
                                                              'Class Room',
                                                            ).show(context
                                                                    .mounted
                                                                ? context
                                                                : Get.key
                                                                    .currentContext!),
                                                          }
                                                        : null;
                                                  },
                                                )
                                              : null;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
