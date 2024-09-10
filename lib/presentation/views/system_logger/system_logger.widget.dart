import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/system_logger_controller.dart';
import '../base_screen.dart';

class SystemLoggerWidget extends GetView<SystemLoggerController> {
  const SystemLoggerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      key: key,
      body: Container(
        color: ColorManager.bgColor,
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
