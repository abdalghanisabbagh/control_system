import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/control_mission_controller.dart';
import '../base_screen.dart';
import 'widgets/header_mission_widget.dart';

class ControlMissionScreen extends GetView<ControlMissionController> {
  const ControlMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
        child: const Column(
          children: [
            HeaderMissionWidget(),
            Divider(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
