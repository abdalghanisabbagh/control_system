import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/customized_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:control_system/presentation/resource_manager/constants/app_constatnts.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SideMenuController sideMenu = SideMenuController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
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
                ).showDialogue(context);
              },
            ),
            CustomizedButton(
              buttonTitle: "show error dialog",
              onPressed: () {
                MyAwesomeDialogue(
                  title: "hi",
                  desc: "hello",
                  dialogType: DialogType.error,
                ).showDialogue(context);
              },
            ),
            CustomizedButton(
              buttonTitle: "show success dialog",
              onPressed: () {
                MyAwesomeDialogue(
                        title: "hi",
                        desc: "hello",
                        dialogType: DialogType.success,
                        autoHideTimer: AppConstants.durationTwoSeconds)
                    .showDialogue(context);
              },
            ),
            CustomizedButton(
              buttonTitle: "show warning dialog",
              onPressed: () {
                MyAwesomeDialogue(
                  title: "hi",
                  desc: "hello",
                  dialogType: DialogType.warning,
                  btnCancelOnPressed: () => Get.back(),
                  btnOkOnPressed: () => Get.back(),
                ).showDialogue(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
