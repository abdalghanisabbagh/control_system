import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../../domain/controllers/control_mission/control_mission_opreation_controller.dart';
import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/ReusableWidget/my_snack_bar.dart';
import '../../../resource_manager/ReusableWidget/show_dialogue.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';

class ControlMissionReviewOperationWidget
    extends GetView<ControlMissionOperationController> {
  final ControlMissionResModel controlMission;

  const ControlMissionReviewOperationWidget(
      {super.key, required this.controlMission});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
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
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "${controlMission.name}",
                          style: nunitoBold.copyWith(
                              color: ColorManager.bgSideMenu, fontSize: 30),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Number Of Students: ${controlMission.count?['student_seat_numnbers']}",
                          style: nunitoRegular.copyWith(
                              color: ColorManager.bgSideMenu, fontSize: 16),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Start Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(controlMission.startDate!.substring(0, controlMission.startDate!.length - 1).toString()))}",
                                style: nunitoRegular.copyWith(
                                    color: ColorManager.green, fontSize: 16),
                              ),
                            ),
                            const SizedBox(width: 10),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "End Date: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(controlMission.endDate!.substring(0, controlMission.endDate!.length - 1).toString()))}",
                                style: nunitoRegular.copyWith(
                                    color: ColorManager.red, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Is Active ",
                            style: nunitoRegular.copyWith(
                              color: ColorManager.bgSideMenu,
                              fontSize: 20,
                            ),
                          ),
                          controlMission.active == 1
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: ColorManager.green,
                                    size: 25,
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.cancel,
                                    color: ColorManager.red,
                                    size: 25,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Column(
              children: [
                Visibility(
                  visible: Get.find<ProfileController>().canAccessWidget(
                    widgetId: '2400',
                  ),
                  child: Expanded(
                    child: InkWell(
                      onTap: () {
                        Hive.box('ControlMission').put('Id', controlMission.iD);
                        Hive.box('ControlMission')
                            .put('Name', controlMission.name);
                        context.goNamed(AppRoutesNamesAndPaths
                            .addNewStudentsToControlMissionName);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(10),
                          //   bottomLeft: Radius.circular(10),
                          // ),
                          color: ColorManager.bgSideMenu,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Add New Students",
                              style: nunitoRegular.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GetBuilder<ControlMissionController>(builder: (_) {
                  if (controlMission.active == 0) {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          MyAwesomeDialogue(
                            title: 'Activate Control Mission',
                            desc:
                                'Are you sure you want to activate this control mission?',
                            dialogType: DialogType.info,
                            btnCancelOnPressed: () {},
                            btnOkOnPressed: () {
                              controller
                                  .activeControlMission(id: controlMission.iD!)
                                  .then((value) {
                                if (value) {
                                  MyFlashBar.showSuccess(
                                    'Success',
                                    'Control mission has been activated successfully',
                                  ).show(context.mounted
                                      ? context
                                      : Get.key.currentContext!);
                                }
                              });
                            },
                          ).showDialogue(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: ColorManager.newStatus,
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Activate Control Mission",
                                style: nunitoRegular.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        MyAwesomeDialogue(
                          title: 'Delete Control Mission',
                          desc:
                              'Are you sure you want to delete this control mission?',
                          dialogType: DialogType.warning,
                          btnCancelOnPressed: () {},
                          btnOkOnPressed: () {
                            controller
                                .deleteControlMission(id: controlMission.iD!)
                                .then((value) async {
                              if (value) {
                                MyFlashBar.showSuccess(
                                  'Success',
                                  'Control mission has been deleted successfully',
                                ).show(context.mounted
                                    ? context
                                    : Get.key.currentContext!);
                              }
                            });
                          },
                        ).showDialogue(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: ColorManager.newStatus,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Delete Control Mission",
                              style: nunitoRegular.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Visibility(
                    visible: Get.find<ProfileController>().canAccessWidget(
                      widgetId: '2200',
                    ),
                    child: GetBuilder<DistributionController>(
                      builder: (distributionController) {
                        return InkWell(
                          onTap: () async {
                            await Future.wait([
                              distributionController
                                  .saveControlMissionId(controlMission.iD!),
                              distributionController
                                  .saveControlMissionName(controlMission.name!),
                            ]);
                            distributionController
                                .getDistributedStudentsCounts();
                            context.mounted
                                ? context.goNamed(
                                    AppRoutesNamesAndPaths
                                        .distributioncreateMissionScreenName,
                                  )
                                : null;
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                              color: ColorManager.glodenColor,
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "Distribution",
                                  style: nunitoRegular.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: Get.find<ProfileController>().canAccessWidget(
                      widgetId: '2300',
                    ),
                    child: GetBuilder<DetailsAndReviewMissionController>(
                      builder: (detailsAndReviewMissionController) {
                        return InkWell(
                          onTap: () async {
                            await Future.wait(
                              [
                                detailsAndReviewMissionController
                                    .saveControlMissionId(controlMission.iD!),
                                detailsAndReviewMissionController
                                    .saveControlMissionName(
                                        controlMission.name!),
                              ],
                            );
                            detailsAndReviewMissionController
                                .getStudentsGrades();
                            context.mounted
                                ? context.goNamed(
                                    AppRoutesNamesAndPaths
                                        .reviewAndDetailsMissionName,
                                  )
                                : null;
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              color: ColorManager.red,
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "Details And Review",
                                  style: nunitoRegular.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
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
    );
  }
}
