import 'package:control_system/presentation/resource_manager/ReusableWidget/header_widget.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/control_mission/review_control_mission_controller.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';

class ReviewAndDetailsMission extends GetView<ReviewControlMissionController> {
  const ReviewAndDetailsMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgSideMenu,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(7),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: ColorManager.bgColor,
              borderRadius: BorderRadius.circular(10)),
          child: GetBuilder<ReviewControlMissionController>(
            builder: (_) => Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.goNamed(
                              AppRoutesNamesAndPaths.controlBatchScreenName);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const HeaderWidget(
                      text: "Details and Review ",
                    ),
                  ],
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: ColorManager.bgSideMenu),
                //   child: TabBar(
                //       overlayColor:
                //           MaterialStateProperty.all(AppColor.bgSideMenu),
                //       labelStyle: AppTextStyle.nunitoRegular.copyWith(
                //         fontSize: 30,
                //       ),
                //       automaticIndicatorColorAdjustment: true,
                //       labelColor: AppColor.bgSideMenu,
                //       labelPadding: const EdgeInsets.symmetric(vertical: 15),
                //       indicator: BoxDecoration(color: AppColor.white),
                //       unselectedLabelColor: AppColor.white,
                //       controller: rmc.controller,
                //       tabs: rmc.myTabs),
                // ),
                // Expanded(
                //   child: TabBarView(
                //       controller: rmc.controller,
                //       children: [MissionDetailsWidget(), ReviewWidget()]),
                // )
              ],
            ),
          )),
    );
  }
}
