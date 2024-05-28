import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/class_room_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/app_dialogs.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/resource_manager/routes/index.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:control_system/presentation/views/class_rooms/widgets/edit_class_room_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../../resource_manager/ReusableWidget/my_snak_bar.dart';

class ClassRoomsScreen extends GetView<ClassRoomController> {
  const ClassRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: HeaderWidget(text: "Class Rooms"),
                ),
                InkWell(
                  onTap: () {
                    context.goNamed(
                        AppRoutesNamesAndPaths.classRoomSeatsScreenName);
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
                          "Add Class Room",
                          style: nunitoBold.copyWith(
                            color: ColorManager.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GetBuilder<ClassRoomController>(
                builder: (gradesControllers) {
                  return controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.classesRooms.isEmpty
                          ? const Center(
                              child: Text("No Class rooms"),
                            )
                          : controller.classesRooms.isEmpty
                              ? Center(
                                  child: Text(
                                    "No classes",
                                    style: nunitoRegular.copyWith(
                                      color: ColorManager.bgSideMenu,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: controller.classesRooms.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 50),
                                            child: Container(
                                              height: 220,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 20,
                                                    offset: const Offset(2,
                                                        15), // changes position of shadow
                                                  ),
                                                ],
                                                color: ColorManager.ligthBlue,
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .classesRooms[index]
                                                          .name!,
                                                      style: nunitoBold.copyWith(
                                                          color: ColorManager
                                                              .bgSideMenu,
                                                          fontSize: 35),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    // Text(
                                                    //   controller
                                                    //       .selectedSchool!
                                                    //       .name,
                                                    //   style: nunitoRegular
                                                    //       .copyWith(
                                                    //           color: ColorManager
                                                    //               .bgSideMenu,
                                                    //           fontSize: 20),
                                                    // ),
                                                    Row(
                                                      children: [
                                                        // Text(
                                                        //   "Building : ${controller.classesRooms[index].buildingName}",
                                                        //   style:
                                                        //       nunitoRegular
                                                        //           .copyWith(
                                                        //     color: ColorManager
                                                        //         .bgSideMenu,
                                                        //   ),
                                                        // ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          "Floor : ${controller.classesRooms[index].floor}",
                                                          style: nunitoRegular
                                                              .copyWith(
                                                            color: ColorManager
                                                                .bgSideMenu,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          "Capacity : ${controller.classesRooms[index].maxCapacity}",
                                                          style: nunitoRegular
                                                              .copyWith(
                                                            color: ColorManager
                                                                .bgSideMenu,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                    .classSeats =
                                                                controller
                                                                    .classesRooms[
                                                                        index]
                                                                    .rows!
                                                                    .replaceAll(
                                                                        '[', '')
                                                                    .replaceAll(
                                                                        ']', '')
                                                                    .split(',')
                                                                    .toList()
                                                                    .map((e) =>
                                                                        int.tryParse(
                                                                            e) ??
                                                                        0)
                                                                    .toList();
                                                            controller.numbers =
                                                                controller
                                                                    .classesRooms[
                                                                        index]
                                                                    .columns!;
                                                            MyDialogs
                                                                .showDialog(
                                                              context,
                                                              EditClassRoomWidget(
                                                                classRoom:
                                                                    controller
                                                                            .classesRooms[
                                                                        index],
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorManager
                                                                  .glodenColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Text(
                                                                  "Edit Classs",
                                                                  style: nunitoBold
                                                                      .copyWith(
                                                                    color: ColorManager
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            MyAwesomeDialogue(
                                                              title:
                                                                  'You Are About To Delete This Class',
                                                              desc:
                                                                  'Are You Sure?',
                                                              dialogType:
                                                                  DialogType
                                                                      .warning,
                                                              btnOkOnPressed:
                                                                  () async {
                                                                controller
                                                                    .deleteClassRoom(
                                                                        id: controller
                                                                            .classesRooms[index]
                                                                            .iD!)
                                                                    .then(
                                                                  (value) {
                                                                    value
                                                                        ? MyFlashBar.showSuccess("Class deleted successfully",
                                                                                "Success")
                                                                            .show(
                                                                                context)
                                                                        : MyFlashBar.showError("Something went wrong",
                                                                                "Error")
                                                                            .show(context);
                                                                  },
                                                                );
                                                              },
                                                              btnCancelOnPressed:
                                                                  () {
                                                                Get.back();
                                                              },
                                                            ).showDialogue(
                                                              context,
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Text(
                                                                  "Delete Classes",
                                                                  style: nunitoBold
                                                                      .copyWith(
                                                                    color: ColorManager
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 100,
                                            bottom: 125,
                                            child: Image.asset(
                                              AssetsManager.assetsIconsClass,
                                              fit: BoxFit.cover,
                                              height: 250,
                                              width: 250,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                },
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
