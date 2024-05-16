import 'package:control_system/domain/controllers/seating_number_tab_view_controller.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/views/base_screen.dart';
import 'package:control_system/presentation/views/seating_numbers/widgets/attendance_screen.dart';
import 'package:control_system/presentation/views/seating_numbers/widgets/cover_sheet_screen.dart';
import 'package:control_system/presentation/views/seating_numbers/widgets/seating_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource_manager/styles_manager.dart';

class SeatingNumbersScreen extends GetView<SeatingNumberController> {
  const SeatingNumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        key: key,
        body: Container(
          color: ColorManager.ligthBlue,
          padding: const EdgeInsets.all(20),
          child: GetBuilder<SeatingNumberController>(
            builder: (controller) => DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.primary),
                    child: TabBar(
                        overlayColor:
                            MaterialStateProperty.all(ColorManager.primary),
                        labelStyle: nunitoLightStyle().copyWith(fontSize: 30),
                        automaticIndicatorColorAdjustment: true,
                        labelColor: ColorManager.primary,
                        labelPadding: const EdgeInsets.symmetric(vertical: 15),
                        indicator: BoxDecoration(color: ColorManager.white),
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: ColorManager.white,
                        controller: controller.tabController,
                        tabs: const [
                          Text("Cover Sheet"),
                          Text("Seat numbers"),
                          Text("Attendance"),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: controller.tabController,
                        children: const [
                          CoverSheetsScreen(),
                          SeatingScreen(),
                          AttendanceScreen()
                        ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
