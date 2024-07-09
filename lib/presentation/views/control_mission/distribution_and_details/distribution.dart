import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/control_mission/distribute_students_controller.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/control_mission/distribution_controller.dart';
import '../../../resource_manager/ReusableWidget/app_dialogs.dart';
import '../../../resource_manager/ReusableWidget/header_widget.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialgue.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../widgets/add_exam_room_widget.dart';

class DistributionScreen extends GetView<DistributionController> {
  const DistributionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        color: ColorManager.bgColor,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.goNamed(
                          AppRoutesNamesAndPaths.controlBatchScreenName);
                    },
                    icon: const Icon(Icons.arrow_back)),
                HeaderWidget(
                  text: "Distribution: ${controller.controlMissionName}",
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    MyDialogs.showDialog(context, AddExamRoomWidget());
                    controller.getStageAndClassRoom();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.bgSideMenu,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Create new exam room",
                      style: nunitoLight.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            GetBuilder<DistributionController>(
              builder: (_) => controller.isLodingGetExamRooms
                  ? Expanded(
                      child: Center(
                        child: LoadingIndicators.getLoadingIndicator(),
                      ),
                    )
                  : controller.listExamRoom.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(
                              "No Rooms",
                              style: nunitoRegular.copyWith(
                                color: ColorManager.bgSideMenu,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
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
                                        offset: const Offset(
                                          2,
                                          15,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                    color: ColorManager.ligthBlue,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 40,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Exam Room: ${room.name}",
                                              style: nunitoBold.copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      ColorManager.bgSideMenu),
                                            ),
                                            Text(
                                              "Division : ${room.stage}",
                                              style: nunitoBold.copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      ColorManager.bgSideMenu),
                                            ),
                                            Text(
                                              "Class Name : ${room.name}",
                                              style: nunitoBold.copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      ColorManager.bgSideMenu),
                                            ),
                                            Text(
                                              "Students Max Capacity : ${room.capacity}",
                                              style: nunitoBold.copyWith(
                                                  fontSize: 20,
                                                  color:
                                                      ColorManager.bgSideMenu),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
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
                                                                .show(context)
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
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                      11,
                                                    ),
                                                  ),
                                                  color: ColorManager.red,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Delete Exam Room",
                                                    style:
                                                        nunitoRegular.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                await Get.find<
                                                        DistributeStudentsController>()
                                                    .saveExamRoom(room);
                                                context.mounted
                                                    ? context.goNamed(
                                                        AppRoutesNamesAndPaths
                                                            .distributeStudentsScreenName,
                                                      )
                                                    : null;
                                              },
                                              child: Container(
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(
                                                      11,
                                                    ),
                                                  ),
                                                  color:
                                                      ColorManager.glodenColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Distribution",
                                                    style:
                                                        nunitoRegular.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 18,
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
