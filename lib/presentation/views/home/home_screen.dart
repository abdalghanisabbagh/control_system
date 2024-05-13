import 'package:control_system/domain/controllers/home_controller.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideMenu(
            
            showToggle: true,
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsDashboard),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Students',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsStudent),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Control Batch',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsExam),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Batch Documents',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Certificates',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsCertificates),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Scanning Grades',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsProccess),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'School',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsCampus),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Classrooms',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsClassRooms),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Subject',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsSupject),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Chorts',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsCohort),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Admins',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsAdmin),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Proctors',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Sign Out',
                onTap: (index, _) {
                  controller.sideMenu.changePage(index);
                },
                iconWidget: Image.asset(AssetsManager.assetsIconsLogout),
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
            title: Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 100,
                  ),
                  child: Image.asset(AssetsManager.assetsLogosNisLogo22),
                ),
                Text(
                  "Control System",
                  style: TextStyle(fontSize: AppSize.s25),
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
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeScreenTest(),
                MainWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
