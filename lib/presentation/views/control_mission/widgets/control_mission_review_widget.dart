import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../Data/Models/control_mission/control_mission_res_model.dart';
import '../../../../domain/controllers/controllers.dart';
import '../../../resource_manager/index.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';

class ControlMissionReviewWidget extends GetView<ControlMissionController> {
  const ControlMissionReviewWidget({super.key, required this.controlMission});

  final ControlMissionResModel controlMission;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(2, 15), // changes position of shadow
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controlMission.name}",
                      style: nunitoBold.copyWith(
                          color: ColorManager.bgSideMenu, fontSize: 30),
                    ),
                    Text(
                      "Number Of Students: ${controlMission.count?['student_seat_numnbers']}",
                      style: nunitoRegular.copyWith(
                          color: ColorManager.bgSideMenu, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              context.goNamed(
                  AppRoutesNamesAndPaths.addNewStudentsToControlMissionName);
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: ColorManager.bgSideMenu,
              ),
              child: Center(
                child: Text(
                  "Add New Students To Control Mission",
                  style: nunitoRegular.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Visibility(
                visible: Get.find<ProfileController>().canAccessWidget(
                  widgetId: '2200',
                ),
                child: Expanded(
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
                        context.mounted
                            ? context.goNamed(
                                AppRoutesNamesAndPaths
                                    .distributioncreateMissionScreenName,
                              )
                            : null;
                      },
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: ColorManager.glodenColor),
                        child: Center(
                          child: Text(
                            "Distribution",
                            style: nunitoRegular.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Visibility(
                visible: Get.find<ProfileController>().canAccessWidget(
                  widgetId: '2300',
                ),
                child: Expanded(
                  child: GetBuilder<DetailsAndReviewMissionController>(
                      builder: (detailsAndReviewMissionController) {
                    return InkWell(
                      onTap: () async {
                        await Future.wait([
                          detailsAndReviewMissionController
                              .saveControlMissionId(controlMission.iD!),
                          detailsAndReviewMissionController
                              .saveControlMissionName(controlMission.name!),
                        ]);
                        context.mounted
                            ? context.goNamed(
                                AppRoutesNamesAndPaths
                                    .reviewAndDetailsMissionName,
                              )
                            : null;
                      },
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: ColorManager.red,
                        ),
                        child: Center(
                          child: Text(
                            "Details And Review",
                            style: nunitoRegular.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
