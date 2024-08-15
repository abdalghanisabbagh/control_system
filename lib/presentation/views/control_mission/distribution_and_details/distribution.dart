import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/control_mission/distribute_students_controller.dart';
import '../../../../domain/controllers/control_mission/distribution_controller.dart';
import '../../../../domain/controllers/profile_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/header_widget.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../widgets/add_exam_room_widget.dart';

class DistributionScreen extends GetView<DistributionController> {
  const DistributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; // Adjust this threshold as needed

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(isSmallScreen ? 5 : 10),
        padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
        color: ColorManager.bgColor,
        child: Column(
          children: [
            if (!isSmallScreen) // Show header and create button only on larger screens
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
                  HeaderWidget(
                    text: "Distribution: ${controller.controlMissionName}",
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
            Expanded(
              child: GetBuilder<DistributionController>(
                builder: (_) => controller.isLodingGetExamRooms
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
                        : Container(
                            margin: EdgeInsets.all(isSmallScreen ? 5 : 10),
                            padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                            child: ListView.builder(
                              itemCount: controller.listExamRoom.length,
                              itemBuilder: (context, index) {
                                final room = controller.listExamRoom[index];
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
                                                "Exam Room: ${room.name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: nunitoBold.copyWith(
                                                  fontSize:
                                                      isSmallScreen ? 16 : 20,
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Division: ${room.stage}",
                                                overflow: TextOverflow.ellipsis,
                                                style: nunitoBold.copyWith(
                                                  fontSize:
                                                      isSmallScreen ? 16 : 20,
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Class Name: ${room.name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: nunitoBold.copyWith(
                                                  fontSize:
                                                      isSmallScreen ? 16 : 20,
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Students Max Capacity: ${room.capacity}",
                                                overflow: TextOverflow.ellipsis,
                                                style: nunitoBold.copyWith(
                                                  fontSize:
                                                      isSmallScreen ? 16 : 20,
                                                  color:
                                                      ColorManager.bgSideMenu,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (!isSmallScreen) // Show buttons only on larger screens
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
                                                                room.id!)
                                                            .then(
                                                          (value) {
                                                            value
                                                                ? MyFlashBar.showSuccess(
                                                                        'Exam Room Deleted Successfully',
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
                                                    ).showDialogue(context);
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .only(
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
                                                          fontSize:
                                                              isSmallScreen
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
                                                        .saveExamRoom(room);
                                                    context.mounted
                                                        ? context.goNamed(
                                                            AppRoutesNamesAndPaths
                                                                .distributeStudentsScreenName)
                                                        : null;
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .only(
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
                                                          fontSize:
                                                              isSmallScreen
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
            ),
          ],
        ),
      ),
    );
  }
}
