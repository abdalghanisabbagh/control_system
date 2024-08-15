import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/batch_documents.dart/batch_documents_controller.dart';
import '../base_screen.dart';
import 'widgets/attendance_screen.dart';
import 'widgets/cover_sheet_screen.dart';
import 'widgets/seating_screen.dart';

class BatchDocumentsScreen extends GetView<BatchDocumentsController> {
  const BatchDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        key: key,
        body: Container(
          color: ColorManager.ligthBlue,
          padding: const EdgeInsets.all(20),
          child: GetBuilder<BatchDocumentsController>(
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
                          WidgetStateProperty.all(ColorManager.primary),
                      labelStyle: nunitoSemiBoldStyle(),
                      automaticIndicatorColorAdjustment: true,
                      labelColor: ColorManager.primary,
                      labelPadding: const EdgeInsets.symmetric(vertical: 15),
                      indicator: const BoxDecoration(color: ColorManager.white),
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: ColorManager.white,
                      controller: controller.tabController,
                      tabs: const [
                        Text("Cover Sheet"),
                        Text("Seat numbers"),
                        Text("Attendance"),
                      ],
                    ),
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
