import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../../domain/controllers/class_room_controller.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';
import 'edit_class_room_widget.dart';

class ClassRoomsWidget extends GetView<ClassRoomController> {
  const ClassRoomsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassRoomController>(
      builder: (_) {
        return controller.isLoading
            ? Center(
                child: LoadingIndicators.getLoadingIndicator(),
              )
            : controller.classesRooms.isEmpty
                ? Center(
                    child: Text(
                      "No Class rooms",
                      style: nunitoBlack.copyWith(
                        color: ColorManager.bgSideMenu,
                        fontSize: 30,
                      ),
                    ),
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
                    : SearchableList(
                        inputDecoration: const InputDecoration(
                          label: Text(
                            'Search by name',
                          ),
                        ),
                        initialList: controller.classesRooms,
                        emptyWidget: Center(
                          child: Text(
                            "No data found",
                            style: nunitoBold.copyWith(
                              color: ColorManager.bgSideMenu,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        filter: (query) => controller.classesRooms
                            .where(
                              (element) => element.name!.toLowerCase().contains(
                                    query.toLowerCase(),
                                  ),
                            )
                            .toList(),
                        itemBuilder: (classRoom) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                  ),
                                  child: Container(
                                    height: 220,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 20,
                                          offset: const Offset(
                                            2,
                                            15,
                                          ), // changes position of shadow
                                        ),
                                      ],
                                      color: ColorManager.ligthBlue,
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                classRoom.name!,
                                                style: nunitoBold.copyWith(
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                  fontSize: 35,
                                                ),
                                              ),
                                              Text(
                                                " (Class Number :  ${classRoom.classNumber!.toString()})",
                                                style: nunitoBold.copyWith(
                                                  color: ColorManager.grey,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            controller.schools
                                                    .firstWhereOrNull(
                                                      (element) =>
                                                          element.iD ==
                                                          classRoom.schoolsID,
                                                    )
                                                    ?.name ??
                                                '',
                                            style: nunitoRegular.copyWith(
                                              color: ColorManager.bgSideMenu,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Floor : ${classRoom.floor}",
                                                style: nunitoRegular.copyWith(
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Capacity : ${classRoom.maxCapacity}",
                                                style: nunitoRegular.copyWith(
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Visibility(
                                                visible: Get.find<
                                                        ProfileController>()
                                                    .canAccessWidget(
                                                  widgetId: '6200',
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.classSeats =
                                                        classRoom.rows!;
                                                    controller.numbers =
                                                        classRoom.columns!;
                                                    MyDialogs.showDialog(
                                                      context,
                                                      EditClassRoomWidget(
                                                        classRoom: classRoom,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .glodenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(
                                                          10,
                                                        ),
                                                        child: Text(
                                                          "Edit Classs",
                                                          style: nunitoBold
                                                              .copyWith(
                                                            color: ColorManager
                                                                .white,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Visibility(
                                                visible: Get.find<
                                                        ProfileController>()
                                                    .canAccessWidget(
                                                  widgetId: '6300',
                                                ),
                                                child: InkWell(
                                                  onTap: () async {
                                                    MyAwesomeDialogue(
                                                      title:
                                                          'You Are About To Delete This Class',
                                                      desc: 'Are You Sure?',
                                                      dialogType:
                                                          DialogType.warning,
                                                      btnOkOnPressed: () async {
                                                        controller
                                                            .deleteClassRoom(
                                                          id: classRoom.iD!,
                                                        )
                                                            .then(
                                                          (value) {
                                                            value
                                                                ? MyFlashBar.showSuccess(
                                                                        "Class deleted successfully",
                                                                        "Success")
                                                                    .show(context
                                                                            .mounted
                                                                        ? context
                                                                        : Get
                                                                            .key
                                                                            .currentContext!)
                                                                : null;
                                                          },
                                                        );
                                                      },
                                                      btnCancelOnPressed: () {},
                                                    ).showDialogue(
                                                      context,
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(
                                                          10,
                                                        ),
                                                        child: Text(
                                                          "Delete Classes",
                                                          style: nunitoBold
                                                              .copyWith(
                                                            color: ColorManager
                                                                .white,
                                                            fontSize: 16,
                                                          ),
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
    );
  }
}
