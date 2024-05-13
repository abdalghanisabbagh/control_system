import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/customized_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/drop_down_button.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/show_dialgue.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/views/home/home_screen_test.dart';
import 'package:control_system/presentation/resource_manager/constants/app_constatnts.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/views/home/home_screen_test.dart';
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideMenu(
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'test',
                onTap: (index, _) {
                  //sideMenu.changePage(index);
                  print("object");
                  
                },
                icon: const Icon(Icons.ac_unit_rounded),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
            
            ],
            controller: sideMenu,
            style: SideMenuStyle(
              //  showHamburger: true,
              showTooltip: true,
              displayMode: SideMenuDisplayMode.open,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: Image.asset(AssetsManager.assetsIconsAdmin),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
          ),
          Expanded(
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
          ),
        ],
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
                  autoHideTimer: AppConstants.durationTwoSeconds,
                ).showDialogue(context);
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideMenu(
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'test',
                onTap: (index, _) {
                  //sideMenu.changePage(index);
                  print("object");
                  
                },
                icon: const Icon(Icons.ac_unit_rounded),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
            
            ],
            controller: sideMenu,
            style: SideMenuStyle(
              //  showHamburger: true,
              showTooltip: true,
              displayMode: SideMenuDisplayMode.open,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: Image.asset(AssetsManager.assetsIconsAdmin),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
