import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/control_mission/review_control_mission_controller.dart';
import '../../../resource_manager/ReusableWidget/header_widget.dart';
import '../../../resource_manager/routes/app_routes_names_and_paths.dart';
import '../widgets/mission_details_widget.dart';
import '../widgets/review_widget.dart';

class DetailsAndReviewMission
    extends GetView<DetailsAndReviewMissionController> {
  const DetailsAndReviewMission({super.key});

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
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context
                        .goNamed(AppRoutesNamesAndPaths.controlBatchScreenName);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const HeaderWidget(
                  text: "Details and Review",
                ),
              ],
            ),
            Expanded(
              child: DefaultTabController(
                length: controller.myTabs.length,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.primary),
                      child: TabBar(
                        overlayColor:
                            WidgetStateProperty.all(ColorManager.primary),
                        labelStyle: nunitoRegularStyle(),
                        automaticIndicatorColorAdjustment: true,
                        labelColor: ColorManager.primary,
                        labelPadding: const EdgeInsets.symmetric(vertical: 5),
                        indicator: BoxDecoration(color: ColorManager.white),
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: ColorManager.white,
                        controller: controller.tabController,
                        tabs: controller.myTabs,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          MissionDetailsWidget(),
                          ReviewWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
