import 'dart:math' show pi;

import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/dashboard_controller.dart';
import 'clock_painter.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final dashboardControllers = Get.find<DashboardController>();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(2, 15), // changes position of shadow
          ),
        ],
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GetBuilder<DashboardController>(
            builder: (dashboardControllers) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${dashboardControllers.timeOfDay.hourOfPeriod > 9 ? dashboardControllers.timeOfDay.hourOfPeriod : "0${dashboardControllers.timeOfDay.hourOfPeriod}"}:${dashboardControllers.timeOfDay.minute > 9 ? dashboardControllers.timeOfDay.minute : "0${dashboardControllers.timeOfDay.minute}"}",
                    style: nunitoBold.copyWith(
                        color: ColorManager.bgSideMenu, fontSize: 35),
                  ),
                  const SizedBox(width: 5),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      dashboardControllers.period!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              );
            },
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          color: ColorManager.bgSideMenu.withOpacity(0.14),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: GetBuilder<DashboardController>(
                      builder: (dashboardControllers) {
                        return Transform.rotate(
                          angle: -pi / 2,
                          child: CustomPaint(
                            painter: ClockPainter(
                              context,
                              dashboardControllers.dateTime,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
