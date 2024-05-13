import 'package:control_system/domain/controllers/home_controller.dart';

import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/views/home/widgets/home_screen_test.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/main_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('title'),
          centerTitle: true,
        ),
        body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SideMenu(
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'test',
                onTap: (index, _) {
                  //sideMenu.changePage(index);
                  controller.sideMenu.changePage(index);
                },
                icon: const Icon(Icons.ac_unit_rounded),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
            ],
            controller: controller.sideMenu,
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
            child: PageView(
              controller: controller.pageController,
              children: const [HomeScreenTest(), MainWidget()],
            ),
          )
        ]));
  }
}
