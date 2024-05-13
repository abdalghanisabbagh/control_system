import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:control_system/presentation/resource_manager/values_manager.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class SideMenueWidget extends StatelessWidget {
  const SideMenueWidget({super.key, required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    SideMenuController sideMenu = SideMenuController();
    // PageController pageController = PageController();
    return SideMenu(
      showToggle: true,
      items: [
        SideMenuItem(
          title: 'Dashboard',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsDashboard),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Students',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsStudent),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Control Batch',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsExam),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Batch Documents',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Certificates',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsCertificates),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Scanning Grades',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsProccess),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'School',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsCampus),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Classrooms',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsClassRooms),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Subject',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsSupject),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Chorts',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsCohort),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Admins',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsAdmin),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Proctors',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsPatchDoc),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          title: 'Sign Out',
          onTap: (index, _) {
            sideMenu.changePage(index);
          },
          iconWidget: Image.asset(AssetsManager.assetsIconsLogout),
          tooltipContent: "This is a tooltip for Dashboard item",
        ),
      ],
      controller: sideMenu,
      style: SideMenuStyle(
          //  showHamburger: false,
          // showTooltip: true,
          // displayMode: isMobile
          //     ? SideMenuDisplayMode.open
          //     : SideMenuDisplayMode.compact,
          hoverColor: Colors.blue[100],
          selectedHoverColor: Colors.blue[100],
          selectedColor: Colors.lightBlue,
          selectedTitleTextStyle: const TextStyle(color: Colors.white),
          selectedIconColor: Colors.white,
          unselectedTitleTextStyle:
              nunitoRegulerStyle(color: ColorManager.white)),
      title: Row(
        children: [
          Image.asset(
            AssetsManager.assetsLogosNisLogo22,
            width: 100,
          ),
           Text(
            "Control System",
            style:
              nunitoRegulerStyle(color: ColorManager.white,fontSize: AppSize.s18),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
    );
  }
}
