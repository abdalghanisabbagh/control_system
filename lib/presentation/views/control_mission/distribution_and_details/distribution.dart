import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../../Data/Models/exam_room/exam_room_res_model.dart';
import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../../domain/controllers/control_mission/distribution_controller.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/header_widget.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../widgets/add_exam_room_widget.dart';

class DistributionScreen extends GetView<DistributionController> {
  const DistributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(isSmallScreen ? 5 : 10),
        padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
        color: ColorManager.bgColor,
        child: Column(
          children: [
            if (!isSmallScreen)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(
                          AppRoutesNamesAndPaths.controlBatchScreenName);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: isSmallScreen ? 24 : 30,
                    ),
                  ),
                  FittedBox(
                    child: HeaderWidget(
                      text: "Distribution: ${controller.controlMissionName}",
                    ),
                  ),
                  const Spacer(),
                  GetBuilder<DistributionController>(
                    id: 'getDistributedStudentsCounts',
                    builder: (_) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Distributed students: ${controller.distributedStudents} of ${controller.totalStudents}',
                            style: nunitoBold.copyWith(
                              color: ColorManager.primary,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Undistributed students: ${controller.unDistributedStudents}',
                            style: nunitoBold.copyWith(
                              color: ColorManager.red,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const Spacer(),
                  Visibility(
                    visible: Get.find<ProfileController>()
                        .canAccessWidget(widgetId: '2201'),
                    child: InkWell(
                      onTap: () {
                        MyDialogs.showDialog(context, AddExamRoomWidget());
                        controller.getStageAndClassRoom();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.bgSideMenu,
                          borderRadius:
                              BorderRadius.circular(isSmallScreen ? 8 : 10),
                        ),
                        padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            "Create new exam room",
                            style: nunitoLight.copyWith(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 14 : 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Expanded(
              child: GetBuilder<DistributionController>(
                id: 'getExamRoomByControlMissionId',
                builder: (_) => controller.isLoadingGetExamRooms
                    ? Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      )
                    : controller.listExamRoom.isEmpty
                        ? Center(
                            child: Text(
                              "No Rooms",
                              style: nunitoRegular.copyWith(
                                color: ColorManager.bgSideMenu,
                                fontSize: isSmallScreen ? 18 : 23,
                              ),
                            ),
                          )
                        : SearchableList<ExamRoomResModel>(
                            filter: (value) => controller.listExamRoom
                                .where(
                                  (element) => element.name!
                                      .toLowerCase()
                                      .contains(value),
                                )
                                .toList(),
                            initialList: controller.listExamRoom,
                            filter: (query) => controller.listExamRoom
                                .where(
                                  (element) => element.name!
                                      .toLowerCase()
                                      .contains(query.toLowerCase()),
                                )
                                .toList(),
                            inputDecoration: const InputDecoration(
                              label: Text(
                                'Search by name',
                              ),
                            ),
                            emptyWidget: Center(
                                child: Text(
                              "No data found",
                              style: nunitoBold.copyWith(
                                color: ColorManager.bgSideMenu,
                                fontSize: 20,
                              ),
                            )),
                            itemBuilder: (examRoom) {
                              return Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 20,
                                      offset: const Offset(2, 15),
                                    ),
                                  ],
                                  color: ColorManager.ligthBlue,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 5 : 30,
                                  vertical: isSmallScreen ? 10 : 20,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 10 : 20,
                                        vertical: isSmallScreen ? 20 : 40,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Exam Room: ${examRoom.name}",
                                              overflow: TextOverflow.ellipsis,
                                              style: nunitoBold.copyWith(
                                                fontSize:
                                                    isSmallScreen ? 16 : 20,
                                                color: ColorManager.bgSideMenu,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Division: ${examRoom.stage}",
                                              overflow: TextOverflow.ellipsis,
                                              style: nunitoBold.copyWith(
                                                fontSize:
                                                    isSmallScreen ? 16 : 20,
                                                color: ColorManager.bgSideMenu,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Class Name: ${examRoom.classRoomResModel?.name}",
                                              overflow: TextOverflow.ellipsis,
                                              style: nunitoBold.copyWith(
                                                fontSize:
                                                    isSmallScreen ? 16 : 20,
                                                color: ColorManager.bgSideMenu,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Students Max Capacity: ${examRoom.classRoomResModel?.maxCapacity}",
                                              overflow: TextOverflow.ellipsis,
                                              style: nunitoBold.copyWith(
                                                fontSize:
                                                    isSmallScreen ? 16 : 20,
                                                color: ColorManager.bgSideMenu,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!isSmallScreen)
                                      Row(
                                        children: [
                                          Visibility(
                                            visible:
                                                Get.find<ProfileController>()
                                                    .canAccessWidget(
                                                        widgetId: '2202'),
                                            child: Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  MyAwesomeDialogue(
                                                    title:
                                                        'You Are About To Delete This Exam Room',
                                                    desc: 'Are You Sure?',
                                                    dialogType:
                                                        DialogType.warning,
                                                    btnOkOnPressed: () async {
                                                      controller
                                                          .deleteExamRoom(
                                                              examRoom.id!)
                                                          .then(
                                                        (value) {
                                                          value
                                                              ? MyFlashBar.showSuccess(
                                                                      'Exam Room Deleted Successfully',
                                                                      "Success")
                                                                  .show(context
                                                                          .mounted
                                                                      ? context
                                                                      : Get.key
                                                                          .currentContext!)
                                                              : null;
                                                        },
                                                      );
                                                    },
                                                    btnCancelOnPressed: () {},
                                                  ).showDialogue(context);
                                                },
                                                child: Container(
                                                  height: 45,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(11),
                                                    ),
                                                    color: ColorManager.red,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Delete Exam Room",
                                                      style: nunitoRegular
                                                          .copyWith(
                                                        color: Colors.white,
                                                        fontSize: isSmallScreen
                                                            ? 14
                                                            : 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Visibility(
                                            visible:
                                                Get.find<ProfileController>()
                                                    .canAccessWidget(
                                                        widgetId: '2203'),
                                            child: Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  await Get.find<
                                                          DistributeStudentsController>()
                                                      .saveExamRoom(examRoom);
                                                  context.mounted
                                                      ? context.goNamed(
                                                          AppRoutesNamesAndPaths
                                                              .distributeStudentsScreenName)
                                                      : null;
                                                },
                                                child: Container(
                                                  height: 45,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(11),
                                                    ),
                                                    color: ColorManager
                                                        .glodenColor,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Distribution",
                                                      style: nunitoRegular
                                                          .copyWith(
                                                        color: Colors.white,
                                                        fontSize: isSmallScreen
                                                            ? 14
                                                            : 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
