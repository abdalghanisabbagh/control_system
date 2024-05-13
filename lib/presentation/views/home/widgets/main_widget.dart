import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/customized_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource_manager/ReusableWidget/drop_down_button.dart';

class MainWidget extends GetView<HomeController> {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MultiSelectDropDownView(
            options: controller.options,
            onOptionSelected: controller.onOptionSelected,
          ),
          CustomizedButton(
            buttonTitle: "Success",
            onPressed: () {
              MyFlashBar.showSuccess("hi", "hello").show(context);
            },
          ),
          CustomizedButton(
            buttonTitle: "error",
            onPressed: () {
              MyFlashBar.showError("hi", "hello").show(context);
            },
          ),
          CustomizedButton(
            buttonTitle: "info",
            onPressed: () {
              MyFlashBar.showInfo("hi", "hello").show(context);
            },
          ),
          CustomizedButton(
            buttonTitle: "show info dialog",
            onPressed: () {
              MyAwesomeDialogue(
                title: "hi",
                desc: "hello",
                dialogType: DialogType.info,
                btnCancelOnPressed: () => Get.back(),
                btnOkOnPressed: () => Get.back(),
              ).showDialogue(context);
            },
          ),
        ],
      ),
    );
  }
}
