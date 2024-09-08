import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/dashboard_controller.dart';
import '../../resource_manager/ReusableWidget/header_widget.dart';
import '../base_screen.dart';
import 'widgets/index.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) {
        return BaseScreen(
          body: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const HeaderWidget(text: "Dashboard"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              NotificationCardWidget(
                                schoolName: controller.schoolName ?? '',
                                userName: controller.userName ?? '',
                                schoolTypeName: controller.schoolTypeName ?? '',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (context.isMobile) ...{
                                const CalendarWidget(),
                                const SizedBox(
                                  height: 20,
                                ),
                              },
                              // const RecruitmentDataWidget(),
                            ],
                          ),
                        ),
                        if (!context.isMobile)
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Column(
                                children: [
                                  CalendarWidget(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ProfileCardWidget(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClockWidget(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
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
      },
    );
  }
}
